Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269FECDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 13:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F52E10EF65;
	Wed, 24 Jun 2026 13:31:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KOnpZeDo";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06BCF10EF49
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 13:31:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qF1WBqSxaW4MAyA9ufoy7jWxEDUr0GLa5+XCBYmBwAjM7iJ9NvONXu/Qh4LnYCa82KAJcqY+X+ZXoOyKuYoQtkxbbFXIuZFYwJE7V2qpZ3y65srXE4aXX1GLXaO1BYNj/qQWLWc3Ue0nixjz0zDsxevpoU3fWtEd0WDx2j3I9xFp38QpTeRZb2949IJ84+11+ceb6VJL1aSgYxsWgk9CJtzAPqzyr8YStRbpGw7g7FgI/Jwtfmvi7maUZXmXjmp8WknDybq/yIL+2Shou6nSayH6onsR6AtEoRpkzsOO0E5I7MTrrdSyGt/KFPzjHdsyVR4/EUGvX0zBdMAaI9Y3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhatTD8BCtACPqujEAaVrt0XSk9yF97n1j7y6c3XNrI=;
 b=x3S5bMWs8j9PkHAjRsD6Z3IHsRV672U+yb28kj2nzuFugKzhTG9Q9DNSBsbbF3eZOCsd36uPcRCyku8JdWGILOMYWWGM8hk906Dkj+J7xLVc1MSjcqNB0/oipKLHFSHwTudIG2vSMPtR7n7mCIx1TLcfwKZPBJDUS9LYQGfZV2NwlEWnBpbmZZDgjmi3h04ExkyADYH/OpZr7JLv7sMn2yu4L29ihUSb3qWbQsMgoIeCDaSOFKA4lcYGQtpeRm+tbyoC/2TNiei4PHFffifaXAi44cJxjw6TpkrCgIlXYoGLrIa5zeZy3gM5v/mOZymjJwnFzikDqTjIuVZzvCA8xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhatTD8BCtACPqujEAaVrt0XSk9yF97n1j7y6c3XNrI=;
 b=KOnpZeDoNLRL8fGi2YE37P3UQ7TB+sOSkJD5dVdbTQuQ3AFJZh44l1G5jmQehrwuJ5TpULOXnz1NFhTn4oF1anSYTvnNQVqxPE+oM2egdPgzFDPVUESyFI9hr7AQ4IflevHvr2ILVWOJi7IFcGXVjtwpMAJI363noXZr2Lg5+S4=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 13:31:10 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%7]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 13:31:10 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Sun, Yongqiang" <Yongqiang.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: clamp v9 CRIU control stack checkpoint copy
 to BO size
Thread-Topic: [PATCH] drm/amdkfd: clamp v9 CRIU control stack checkpoint copy
 to BO size
Thread-Index: AQHc8pbiYXVMIDzy6kC8zZ3n29fRcLZN1ghC
Date: Wed, 24 Jun 2026 13:31:10 +0000
Message-ID: <SA1PR12MB814437FD732B489BB58E56A6EFED2@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260602135049.1054739-1-Yongqiang.Sun@amd.com>
In-Reply-To: <20260602135049.1054739-1-Yongqiang.Sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-24T13:31:10.500Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|SA3PR12MB9092:EE_
x-ms-office365-filtering-correlation-id: 6ce72e76-5d14-4573-7f3c-08ded1f4daf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: ZKffK00NsJsa12UH0NgVawdL/1a+6jK4j9wKFp61oO8g/CaFz9EBAtl0Bu0rkD6GLSy+QtmNkrMSB0kkuZNEUD70e/SYCHMMQ+dh2AAodvk0LAXAtqsFP4YkAb4UGw3Z73B8Sf+z0j20HTXkq4hgRIeScSWkAnVqBKBZKdFH5T1lJvndz/9cHdVWRbXzGAPHslzelkd0VmIP1TOdR1VVdGPUfQEwOdpT7N/ppxHbPw6tK3G2+pD9M9YsWO+GdCJhLwp3R7bNeWJ2jXXCcCRmLw8YvkZEieh20Tp2rYAnsRgbNhEXwN0zMFH+tweOnN5jOmo0fu5kLDEMQkLOPSV8cXrIeoZ7c3S+6iUqw1IDhlBtGDWyaI9uSUi/HS/BhlsIhc16tKB94zbbpV2r+Iys7IoWPgGYGVHPG3BAkR16jzx7w9tqXX+B++Epg3BLwrunQqZh1nqJ8zbKGs+JO4g5ac9b9/hzNaim2vxHF0Qe08SkSlOf1kAx5guUQEgVKZeVqo+LfGixxLKRB9iuf1UuPbD4gee5Od1vp449AFNkgKrLIANpZTFCtE+Z55gH4hkoOdzHmbaku3dlfZGUYgj3sTJzIiLuGfPJvtWtMupcSjyVbuFzJ5n2MUliAc7t/br9MmRv6cB+edV1sSWtrJKWaTdukBOiI+ZDg3F5C7eg/B7dj9M2ZNCr/WXBCfzHlxzaew0DFMnmjZpFdiUpM8GPAgIt0S7B9XfIQRH1nKHuU+k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OP8IXnT9swlf4u6xo0ftzNNgxY4AFzkOG909Uc0jL93ST3c6LR5rydrA3Wl3?=
 =?us-ascii?Q?m+7kBP4RVDoYbWne/tuYVcbzv9wK0NPemyL6KmD4uyFOoJr48KaxOXZyy/Jj?=
 =?us-ascii?Q?AwND7volKNVrgNJZ2db+fJJPuNwBDMsjZ+9Bz+az8o3ttt/DZgbJBXJ7U1O7?=
 =?us-ascii?Q?BbIipFNhUqBQDwXQz75j11x2p6nRbTvItVCJQaCvDZH5B4KDCxbsrdJDRYTZ?=
 =?us-ascii?Q?ty8hxuykHL22p3zArsbNu7Jy6egYlpM3poVEFjIjTJnfAP3c9SwkT1+z/8Y7?=
 =?us-ascii?Q?1elMpZrfqk1YLAVg2KNnAUneGea1UeaeC+sJLouEP0wlahXdLbX2rVIkNJDt?=
 =?us-ascii?Q?UHPYsHn6+GJiVKV2DQvxpEqeONnHr3jAiE4RG9zFDTCbG/nmPIn+yzyv2Zl8?=
 =?us-ascii?Q?V1f3NpaRRUZvJ1StX4HSu/510vWQ7Ckub2lDbwLMwyQsER8pyIdsAy56VKaY?=
 =?us-ascii?Q?BVmamRnyShimBGJlJx/vzXpGcyRtnQ1gNbnuUzySHYTCQcbsWXCl4NetzMHD?=
 =?us-ascii?Q?9M+dXB7TjQqC7aqTaYIM1pOGwPt/FqQ2cIQnU73PGhWZk9dDveXNEYrXu+Zd?=
 =?us-ascii?Q?aJS74XxsV2VKCJYBy1Fo+JE46QBTMBmASaiAYMI62JLJ/IqLAtJvwVxakTfk?=
 =?us-ascii?Q?IxoDNzOlHm4ihi1fJ/1qG9LWcmeOF0RB/g4fZCzU5gmmIZP8X9CFoLcs6AAz?=
 =?us-ascii?Q?sj28yGRaJRvf+TNbomcw0RneLfmdsnjZi7rhw8+mcrWuXsGy3S4uYM3fvXVG?=
 =?us-ascii?Q?P+8zBdUtYv/SKCGBoUoeyptF5vblFe9gWZzZCWmJy7r/ImUQWjFEZiIzjfM8?=
 =?us-ascii?Q?w+Wgh2AvPZs6887yQUxZH0iIvTWHpP8l9pSAvdh4+4yT8RtpBWi4NVZO29ci?=
 =?us-ascii?Q?SKTqsjII0D2o4ypCtDHmfeh9nfwuvrEAM1DE9uRl1hMHFLmU5ZIsj+Eaod8t?=
 =?us-ascii?Q?oQzgaG0CjfRk3MugYrsvLIsUsq4RXr6nVOd3WJzn3oEKaYtexanO8CHwhsee?=
 =?us-ascii?Q?4aIwos4JybfiGBI9eHuQ35vM7qZBgSUxpe5T5cenp1lCd7fRvV+Skcj1DCzh?=
 =?us-ascii?Q?7asWFNWxCf2KXKvU+EYgA5XuDFV5Y3sU+KQhVeHrfW7AvsAiHiidLfQL+3Us?=
 =?us-ascii?Q?lEq/nGQ+GybLuan66oSZvOcoXm98iiSLlWLZOU9zA1EohUsPSUIRnYKygePC?=
 =?us-ascii?Q?OxKYyLUz62GKWopNZEldhYYg5URNW2usV1zyIMAAvD79qgY/XkiSekUL8hG9?=
 =?us-ascii?Q?WtuLBN15F/b59vsgSmjEZdvmvNRg/i3eAro5iDZX1m3Pl//wj/PfnRtpbhy9?=
 =?us-ascii?Q?WLA5S6J2/SStQM34aL8kD/fHFd7E0kRZdliOWYpfba252OyYDkRS72b43Ysr?=
 =?us-ascii?Q?lsqHVEnDbKIG97Ft4d96IRsBY9Veft/EzX+tC7zcJFyLDIkmbwE2mGgG6phh?=
 =?us-ascii?Q?6PSQvsLP2G5MBgaXtTqjOo29C9S6tbC9T2sGRL5XNzga0/DdRm2vJz9oHF21?=
 =?us-ascii?Q?Ll5vcFx7n+w/ZqJcCrdEKg24c+Z1twghSvh+kipOYiImhWuPFp3Ab5kYYh/9?=
 =?us-ascii?Q?rIugkiTJNA2P7mp6QOP5ZjrCWTn7Ml1j/gckZ0xqYGbD9HmtajEpGRQwsxpF?=
 =?us-ascii?Q?k8qJwXmFFFJ4A4L22AbdndmVS4E4cPnrWgGQG86K3sxzB5gbKqfd19smeqp3?=
 =?us-ascii?Q?hbBQNAp4NYMetZeSHzw8aoONZ03D4CDt67uYOQMtCAD9LVBr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce72e76-5d14-4573-7f3c-08ded1f4daf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 13:31:10.8210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcGTlgVKBRbemsKkN22TNr46eP2H9SPrBjtQx8oeSiz/ZWtXq7alRrDcvZ9/bj6H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092
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

I was unaware of this feature of the mqd. Looks legit to me.

Patch is
Reviewed-by: David Francis <David.Francis@amd.com>

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yongqian=
g Sun <Yongqiang.Sun@amd.com>
Sent: Tuesday, June 2, 2026 9:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Sun, Yongqiang
Subject: [PATCH] drm/amdkfd: clamp v9 CRIU control stack checkpoint copy to=
 BO size

CRIU checkpoint copies the MQD control stack using cp_hqd_cntl_stack_size
from hardware without bounding it to the allocated BO region. If the HW
field is larger than the queue's control stack allocation, memcpy reads
past the BO into adjacent GTT memory and can leak kernel data to userspace.

Store the page-aligned control stack BO size in mqd_manager and clamp
checkpoint copies and reported checkpoint sizes to
min(cp_hqd_cntl_stack_size, mm->ctl_stack_size). Apply the same bound
for multi-XCC v9.4.3 checkpoint layout.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  1 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 25 ++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm=
/amd/amdkfd/kfd_mqd_manager.h
index 06ca6235ff1b..63ea70e5c0e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -127,6 +127,7 @@ struct mqd_manager {
        struct mutex    mqd_mutex;
        struct kfd_node *dev;
        uint32_t mqd_size;
+       uint32_t ctl_stack_size;
 };

 struct mqd_user_context_save_area_header {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_mqd_manager_v9.c
index a04102fd2fb7..741de3ded293 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -27,6 +27,7 @@
 #include <linux/uaccess.h>
 #include "kfd_priv.h"
 #include "kfd_mqd_manager.h"
+#include "kfd_topology.h"
 #include "v9_structs.h"
 #include "gc/gc_9_0_offset.h"
 #include "gc/gc_9_0_sh_mask.h"
@@ -411,8 +412,11 @@ static int get_wave_state(struct mqd_manager *mm, void=
 *mqd,
 static int get_checkpoint_info(struct mqd_manager *mm, void *mqd, u32 *ctl=
_stack_size)
 {
        struct v9_mqd *m =3D get_mqd(mqd);
+       u32 per_xcc_size;

-       if (check_mul_overflow(m->cp_hqd_cntl_stack_size, NUM_XCC(mm->dev->=
xcc_mask), ctl_stack_size))
+       per_xcc_size =3D min_t(u32, m->cp_hqd_cntl_stack_size, mm->ctl_stac=
k_size);
+
+       if (check_mul_overflow(per_xcc_size, NUM_XCC(mm->dev->xcc_mask), ct=
l_stack_size))
                return -EINVAL;

        return 0;
@@ -421,13 +425,15 @@ static int get_checkpoint_info(struct mqd_manager *mm=
, void *mqd, u32 *ctl_stack
 static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_ds=
t, void *ctl_stack_dst)
 {
        struct v9_mqd *m;
+       u32 ctl_stack_copy_size;
        /* Control stack is located one page after MQD. */
        void *ctl_stack =3D (void *)((uintptr_t)mqd + AMDGPU_GPU_PAGE_SIZE)=
;

        m =3D get_mqd(mqd);
+       ctl_stack_copy_size =3D min_t(u32, m->cp_hqd_cntl_stack_size, mm->c=
tl_stack_size);

        memcpy(mqd_dst, m, sizeof(struct v9_mqd));
-       memcpy(ctl_stack_dst, ctl_stack, m->cp_hqd_cntl_stack_size);
+       memcpy(ctl_stack_dst, ctl_stack, ctl_stack_copy_size);
 }

 static void checkpoint_mqd_v9_4_3(struct mqd_manager *mm,
@@ -436,15 +442,19 @@ static void checkpoint_mqd_v9_4_3(struct mqd_manager =
*mm,
                                                                  void *ctl=
_stack_dst)
 {
        struct v9_mqd *m;
+       u32 ctl_stack_stride;
        int xcc;
        uint64_t size =3D get_mqd(mqd)->cp_mqd_stride_size;

+       ctl_stack_stride =3D min_t(u32, get_mqd(mqd)->cp_hqd_cntl_stack_siz=
e,
+                                mm->ctl_stack_size);
+
        for (xcc =3D 0; xcc < NUM_XCC(mm->dev->xcc_mask); xcc++) {
                m =3D get_mqd(mqd + size * xcc);

                checkpoint_mqd(mm, m,
                                (uint8_t *)mqd_dst + sizeof(*m) * xcc,
-                               (uint8_t *)ctl_stack_dst + m->cp_hqd_cntl_s=
tack_size * xcc);
+                               (uint8_t *)ctl_stack_dst + ctl_stack_stride=
 * xcc);
        }
 }

@@ -998,6 +1008,15 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_=
TYPE type,
                mqd->is_occupied =3D kfd_is_occupied_cp;
                mqd->get_checkpoint_info =3D get_checkpoint_info;
                mqd->mqd_size =3D sizeof(struct v9_mqd);
+               if (dev->kfd->cwsr_enabled) {
+                       struct kfd_topology_device *topo_dev;
+
+                       topo_dev =3D kfd_topology_device_by_id(dev->id);
+                       if (topo_dev)
+                               mqd->ctl_stack_size =3D
+                                       ALIGN(topo_dev->node_props.ctl_stac=
k_size,
+                                             AMDGPU_GPU_PAGE_SIZE);
+               }
                mqd->mqd_stride =3D mqd_stride_v9;
 #if defined(CONFIG_DEBUG_FS)
                mqd->debugfs_show_mqd =3D debugfs_show_mqd;
--
2.43.0

