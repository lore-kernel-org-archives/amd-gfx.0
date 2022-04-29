Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B075CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 02:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4428B10EF62;
	Fri, 29 Apr 2022 02:45:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 984AC10EF62
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 02:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mD7XGLr5rCoPFSOe6+91F9DkkdzNTRy83gJ/DdB4Uj34pTik7+Sq863SarF0W/NspmogeRHX/ajfgyN3V0QEUhNfGFB/tfpzNdvV40USRAGLY4+Uf1ENXZpVMOfXPNfT8pts83gEHV13iWfMrY9nCR/8HWXImpoX7jTtWC0VTk3yVVIBM3LpFHAAQyG+T7oixzkEIsZvLZ7GVoYo3OwQ1LnFZZyN4gCsBUA8Eb3RdLsvgiIoL6nCkDoBzS5gm6ipJJmf8cM/jkjIVyuMO25Yv990PhYTOoY1dYuO6H9KAV++kOSSWcpaG/Yp5BfP4LlLNEj8pbxBmGCOq6rTn3mCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXxbsJzmbKW72+8B8KvtbMIS+FFwXwcK4fJj/APp7Wk=;
 b=l6ZEw/ViCpfNhkR1yOJQZPXnrpipPxiyTnoKjUgUE8I1KYKxulER7b3pBtuDjzhjUesMniq7gcqilS73wIGY88IaTwYTGlwzYmPvpmgbmaw886+9YNGQdK+LMQ2XP67TaWCF1raIAuCRCP5qQ3CCkc63aDa/mHYpeL/CDERIR8rWE9Y9+uMeNmAcLT33zok460ztwPl0FsH9EDZF9K5SDqMMzo4w4/nqk+tYxDraFKhXlkq2LnnevfTIfriQHS8is1ssR1VCEnwWE9rKGPkW34j+p2xfjPQZVsUkzwLFojONLOoe9daPIz6RxKUOOkG5xgM5uT6fubKRGk3NyPzt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXxbsJzmbKW72+8B8KvtbMIS+FFwXwcK4fJj/APp7Wk=;
 b=cIMvh3hZYETZyBRMzIYewJI4anjfiaSmQyu9ZY1AKTGaV0AArK84JSMz+dHRfF5M3Nxny/5LkczBJx0TgITmIkvXkJk8Dt/iGqHqc9G0HIpWTo/w3guC6Q+pg6Kq+dqruGf20RnqDVUGDvfvZxtQbVuR6iFwoNoLe2+fQGN78ik=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB3552.namprd12.prod.outlook.com (2603:10b6:208:ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 02:45:09 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 02:45:09 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu/psp: deallocate memory when psp_load_fw
 failed
Thread-Topic: [PATCH 5/5] drm/amdgpu/psp: deallocate memory when psp_load_fw
 failed
Thread-Index: AQHYW00cTYRv/oGQY0KeCTFe+34NH60GL5aA
Date: Fri, 29 Apr 2022 02:45:09 +0000
Message-ID: <BN9PR12MB52576DD50D26A0B832FEF7E7FCFC9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220428221231.1030104-1-alexander.deucher@amd.com>
 <20220428221231.1030104-5-alexander.deucher@amd.com>
In-Reply-To: <20220428221231.1030104-5-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=526cd714-db43-4ae8-8a6b-ee0505430a5f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-04-29T02:44:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e629be13-26c9-416b-b435-08da298a4678
x-ms-traffictypediagnostic: MN2PR12MB3552:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3552D18D88218F6ED62DB4B9FCFC9@MN2PR12MB3552.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6aGjcvYWR1y1p7tLeOTX7NvaNbV/9tKRh530u87G1VbxHYWsH5uCtDd2/PfDz98EvJB3eLWL49rcs8BrDHQr4QdUUS5J83pToQFzH2Wq6n1n+Imj7AZPptzfanKkheTdMk8gRKHsia9qHSr+6PfQq2vP4RtgyyZVPUElyVzfuIQrRpK//jokLbMSYGvi/UGhOZNVIgWQwAg9yCg5fclqDrXsGBf5uCJFC9QFI338DNXZoycKWI0n2ONAEIjnp6vYWiS/8uh4N2sOJHCp2dmdxY5VvHfEyN7ZTcbxRnXCGOkMY5CrLHQpUqNGx0XchWQkGdNyv7Znp4FdkVaFagwCu+gQkl8JXVp51zsTW/k3bbn89F4VmjxfSkea9a67rXKoV+afHkFpe+Wne0cq605XXa/DnQNX2jKrvBUxXydeB7koAjfg3N4i/9MsDuiE0gUfG9YgXjJuU/vSUVFi5XHJ8vy34piJX7/LwM7eiwHLfxF/u3YUXtP3IfZuv5f2I6XMpTYkwXK7l1PVIAPvbNhXr39PGDubkAI8RBWPVvQ3ti/IrFhQX1kCL5sid3lsg73DeHwn7YRtK/eLPUn+U+fAY8jmMbrADvsnqZK+x6VqQ+2W5/l/15SXWZ4k7U6kaGrIu9KOZuORgfesqHVI68W+0rk3XQek8GdZNoZQRcScdBvxpeExPFscRIRuiwsovfATHBR1zXQa3YVAmvn06z0/vA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(2906002)(71200400001)(8936002)(5660300002)(38100700002)(186003)(316002)(6506007)(7696005)(33656002)(55016003)(53546011)(66556008)(66476007)(38070700005)(4326008)(8676002)(9686003)(64756008)(86362001)(76116006)(52536014)(66946007)(54906003)(66446008)(110136005)(83380400001)(26005)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/SuLTD8Wm0GFPdr+48+eRpVxZ4WzsHdLej76/l745rYP/vqN2jV/4ImeGeie?=
 =?us-ascii?Q?IS0EP2kzfZWyAQBo9vbrtI1rpFeqX1lh5y3MYIBdWwnIfhf2/dI4shG0je0r?=
 =?us-ascii?Q?ABaktbxHIp05BKOC5Nhybg9ev1q8qICxVhOnDJuImYszYAmX89LwG7jBizi0?=
 =?us-ascii?Q?KgwbtVeFznXFwd3Ez3Ymd4vLwPsyel76OBCJ8TbeIx3alZHpdeL7Tx1YXELD?=
 =?us-ascii?Q?JFpS/Zg96RQyRojgtYWvaCQwhovRvnpJf/uPNqiDoTzyGeudScQwcNCb5O7B?=
 =?us-ascii?Q?MJKOdlpvJQ9UWrYbPn41uMNFKj0HlYPO49G36Q4mWOzsdm4eSNgOOMeHBKJ5?=
 =?us-ascii?Q?Mvn0MaIwl+OoCqxxCMre0mzXTSwLcWVZTQrJoEZrGvKXJRY+/pDkTyi7oxNl?=
 =?us-ascii?Q?q/ekbt0ncHfurZ1lYcEhS1WnqUp2L9hLd0VY4mDhFPPqdM7/FssGoDSgeapo?=
 =?us-ascii?Q?y+IdQJ8cv3mT941evGmYksFpZgmmgG2BlIleGoqzLPnLbd4R1k7/Ajy/OhCx?=
 =?us-ascii?Q?y46Bw1fwFRZesFaWEOLOfr13eugPmctm4ci1uKh49iCBNMVJTvaJ1z+yHL9l?=
 =?us-ascii?Q?iP4kjTPNxj+kyiRZPcrYDGHwvXY30jf6xyqoYb72eqr6tlHhwxep9P21glA+?=
 =?us-ascii?Q?/Bt3ajc9XPe0ouCn+SPD8ZDOot5FlB8FNYgUPMJVpeeiRnYkjkr9eGrMO9cj?=
 =?us-ascii?Q?OeIgY8TFyGpuq7jS+p87pTYKbPZ3pbH7r0GwjPhNJFXJuFMYQiV5YKWteKjl?=
 =?us-ascii?Q?+s1EmpRzSjdSoWtOPYiQXN478mNlyl4zd1lLLjawtGBtzBgLfq5KzFFih1M8?=
 =?us-ascii?Q?v2hYOgAX/LKtr3Nq6SoPHznBLRJ7kbzkbm0KhXqSXAtwXWUaycpAwBr3tlmz?=
 =?us-ascii?Q?cOGBmUflqSAG8+7SYT28HWKGDn+bIU1mF9cT3Vt58Rsbl+2Y7OuN5+RvKp+2?=
 =?us-ascii?Q?rb72lyk2RsNh/NVfHiJfKm7BLHlBdmw+vv4NwmClWDqHS0k02Ym7hFd36bf4?=
 =?us-ascii?Q?FGeWMuQZAqKVvC4EUj6yrdK14a3EVOn2iYfuuPPeZlqCpPThXoQsP1hiLobl?=
 =?us-ascii?Q?l/rlZ4IMpb5QHudi/o522s2g3huSzTXXX++c7Y/cR/Q33Rc412QBzaVv2/n5?=
 =?us-ascii?Q?xDiX7pn9Pvql2MH1KCHjpYKqEHrTu8OQdd1AmqHvxqZTWgy8eY6TiSyh1Uf2?=
 =?us-ascii?Q?Y03JA0ytN9BZvpHGTl2ElPE0B8vZbmtxQZZfme3GcS8bF7xz4ikJmc9HoikY?=
 =?us-ascii?Q?Od2VtXjvciHlHtqJ3r6n6aYC2O2AtsLdLyrFnYuc5AiJNhfdp7x3TmLM0oLE?=
 =?us-ascii?Q?VodjZRfSzbKXzHLTsuZCz3zMbUZS9jNzmdVhq9nnCP6Y6tS5h3sTkyciNJyG?=
 =?us-ascii?Q?3qo89LYeXEpe2Eg8LymLkoKAfGSJoia2fxWy9Wwht8LfAM8fJVe5dp/1lkxG?=
 =?us-ascii?Q?mPMr78X4jyw0nWsmOiMxkPY2pgYWHa+dkLYBWyrAEzO9oZHLKj1kWrIL1ufy?=
 =?us-ascii?Q?5w836tpy964pt3/P/CQDYh9rUdQYbbK1mMNpETK+LDt/CL8VlKx93jv3AThq?=
 =?us-ascii?Q?LyhTkwy5EOvjpWqIU0x8m7h6w5tOIjpF9ikpBPgJhu4/Gdr77iPZTTmQKfWE?=
 =?us-ascii?Q?NiDUsBk7FIsWh4L1Jdl/BX5tMuQuLk3jHJuygsMWMxDY3FmOlsndH5ccrPwe?=
 =?us-ascii?Q?vB7s19uJIAm/i6XVeq96oavOXD1RDIQD/i5xz60GbYD5KZVwSit2goitOBpb?=
 =?us-ascii?Q?JJTiVxb0Ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e629be13-26c9-416b-b435-08da298a4678
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 02:45:09.0731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Gr8W/OkM6A+j0XfROxh8by/M5RjLcq5HhYdcfihm+TF26SPRr9zKPLbf2w9bpL/apG/Nnz0QcvxW/wZ7TLdEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3552
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
Cc: "Wong, Alice" <Shiwei.Wong@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, April 29, 2022 06:13
To: amd-gfx@lists.freedesktop.org
Cc: Wong, Alice <Shiwei.Wong@amd.com>; Deucher, Alexander <Alexander.Deuche=
r@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/psp: deallocate memory when psp_load_fw fai=
led

From: Alice Wong <shiwei.wong@amd.com>

psp_load_fw failure would cause memory leak for psp tmr and psp ring becaus=
e psp_hw_init is not called as psp block is not fully initialized.
Clean up psp tmr and psp ring when psp_load_fw fail by calling psp_free_sha=
red_bufs and psp_ring_destroy.

Signed-off-by: Alice Wong <shiwei.wong@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index b1b6f5dd35dd..ccb7106b2f27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -153,6 +153,12 @@ static int psp_early_init(void *handle)
        return 0;
 }

+void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx) {
+       amdgpu_bo_free_kernel(&mem_ctx->shared_bo, &mem_ctx->shared_mc_addr=
,
+                             &mem_ctx->shared_buf);
+}
+
 static void psp_free_shared_bufs(struct psp_context *psp)  {
        void *tmr_buf;
@@ -1003,12 +1009,6 @@ int psp_ta_init_shared_buf(struct psp_context *psp,
                                      &mem_ctx->shared_buf);
 }

-void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx) -{
-       amdgpu_bo_free_kernel(&mem_ctx->shared_bo, &mem_ctx->shared_mc_addr=
,
-                             &mem_ctx->shared_buf);
-}
-
 static void psp_prep_ta_invoke_indirect_cmd_buf(struct psp_gfx_cmd_resp *c=
md,
                                       uint32_t ta_cmd_id,
                                       struct ta_context *context)
@@ -2409,18 +2409,18 @@ static int psp_load_fw(struct amdgpu_device *adev)

        ret =3D psp_load_non_psp_fw(psp);
        if (ret)
-               goto failed;
+               goto failed1;

        ret =3D psp_asd_initialize(psp);
        if (ret) {
                DRM_ERROR("PSP load asd failed!\n");
-               return ret;
+               goto failed1;
        }

        ret =3D psp_rl_load(adev);
        if (ret) {
                DRM_ERROR("PSP load RL failed!\n");
-               return ret;
+               goto failed1;
        }

        if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev)) { @@ -2464,12 +=
2464,15 @@ static int psp_load_fw(struct amdgpu_device *adev)

        return 0;

+failed1:
+       psp_free_shared_bufs(psp);
 failed:
        /*
         * all cleanup jobs (xgmi terminate, ras terminate,
         * ring destroy, cmd/fence/fw buffers destory,
         * psp->cmd destory) are delayed to psp_hw_fini
         */
+       psp_ring_destroy(psp, PSP_RING_TYPE__KM);
        return ret;
 }

--
2.35.1

