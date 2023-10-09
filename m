Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E261E95A95
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 15:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B306789321;
	Mon,  9 Oct 2023 15:05:05 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFC689321
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 15:05:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVaCl95XkuiMrmKixE8VPeyiwIDZVrj4NzpHGdgBFQOE5XJEiUfudLPIsOEJekbfxxSis9CjpzZyMeGntznJUra3J4xZ86jul+PzYC4Q1bxdEJeBHcNHOUfq+S1u61CM3qV0VJHauTGAwcFp/RroAtfACUC8F6l22a9j2gUivLyL1/6uOxUBZZDdnTu1/GHogumzNzG0ZEj7SUdXgHewXOp6BrmJEXZkHb0gLt+4gY8CZkdIdkhvpbvQLxqnJzXuKzv1at7kFeoWWS+A42boWnkF1qW6VsevwNVH+9PXgFWpPxk5nQkGKo/aHYQdKxvYvAhLV2auqKEclMjp9AHb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZKhb+RasCtx1bO2b1p7be/Sj7ou1RjKhi7ay7wysbo=;
 b=XdM0sIi99Tgpm8EO8+yBc/dAvYHu+bZIkx6d3abzTRzZpQOBwd2TFvDIspCNSddbu2V7uRflkcEMJA6RE0LRhyiV89kkMCERWgsHZYm3uHPGhOWs1iy84rPPiS0f54j40iCtnNSH0rFnh+Ywk2nbeOJPG9VgzdgAivviEZFnRhYKOO0qxfKQGRHJgAQRyRI603D95k8kmWv7H/+6H3zQhvIKao1+9f4OfIFS/nFGChr3mUqFt25aeSZGXnaVFMW3bVnx6WeeQmYFg9w+PxQYkhiS1Aqu/cZI0ZjTWFCTmt+dDj0y0yKlcOHN3/ZVt0frq0NKLMMkX/k9N/V9S66+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZKhb+RasCtx1bO2b1p7be/Sj7ou1RjKhi7ay7wysbo=;
 b=DPybmQSKG4DezRqq5mJBk8B/7hDr2PUNUvbiWVDD0O29+p2VfK8ONBDYau+5C10nv3WDViEyCm/Km+hr7wB3kmhRbrue8b29Vp/qghk6sHP4wo037LXO19VL2LnLWTkNhdmrAa6iNoyDHcLX4oszDKsBOLHnFpI+N+JEfJphT8s=
Received: from DM6PR12MB2697.namprd12.prod.outlook.com (2603:10b6:5:49::18) by
 BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 15:04:58 +0000
Received: from DM6PR12MB2697.namprd12.prod.outlook.com
 ([fe80::82a:c688:3c6:ee34]) by DM6PR12MB2697.namprd12.prod.outlook.com
 ([fe80::82a:c688:3c6:ee34%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 15:04:57 +0000
From: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu/umsch: fix psp frontdoor loading
Thread-Topic: [PATCH 1/3] drm/amdgpu/umsch: fix psp frontdoor loading
Thread-Index: AQHZ+PvdWzFM93R9MkuB6hualsvNrbBBkcWg
Date: Mon, 9 Oct 2023 15:04:57 +0000
Message-ID: <DM6PR12MB269751C70ECAC59711D576B8FACEA@DM6PR12MB2697.namprd12.prod.outlook.com>
References: <20231007085402.67350-1-Lang.Yu@amd.com>
In-Reply-To: <20231007085402.67350-1-Lang.Yu@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c986bbbd-2a23-48c1-a0e5-024d93494add;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-09T15:04:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2697:EE_|BY5PR12MB4885:EE_
x-ms-office365-filtering-correlation-id: eb4ae0df-7968-4eba-76e4-08dbc8d91a3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JEjnH3DnkyC/Aev/xdjznanQTAYBd5PbzC6wj1PIoQDYRRegiNBD1vYQZ6yHw6nRZ/cplPuBKOJ5tr6AGQYuDWLpVWnlmjqqcxnN2KuTwvvqg+5NA3a7KVi/uSCyF1Ul4yIzQVFS1sDIZXyQ0ZWevW5eHAitBJtYHZfOurWgEJaaXndOteIrhFj3+RGHqbWeW7UXgfOfta1e9QpjoGT0a9LZ9QD5D337ajOLxVoX1fKhry1Jn+zKV8Z7ywY3NxC6m/yV90MV+b4R9R0E4IJ7h2q+RsSsWodkNifkUgQVnIeB9mg4By6f315Sopf4p308avF3fwXaJE36MmlQ1hDjK7LHXKaaNu1W1LAOQAl6FQluAWpWMZRC/7Z2TGME0yDulf5liz/ROpdxJq4IH8GtMVrF8+SSlmkt+s4qu9Q3K1bCFpgcn/+hVamvVAHz9K8bK/laabWq5HZXE6kwjkGbXroIsdW6JFJ5VT/fL0+v+hh50/3mevlclPa38lDPVNEqZ5DIZJSd1hD+CjweyW3ouO1mYTnNfe7FdF6UQzh+CCdehPtmsYpkM7mV7KZgPMKgo7Rbb9SKhpCNEhE9XS0HsesOeO6NV142IDvlFf3n7v0IYCBccCaA3sOLqrHTpDWQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(86362001)(38100700002)(38070700005)(33656002)(122000001)(55016003)(2906002)(53546011)(9686003)(30864003)(478600001)(41300700001)(52536014)(71200400001)(5660300002)(8936002)(8676002)(7696005)(4326008)(83380400001)(6506007)(66476007)(64756008)(66556008)(66446008)(76116006)(54906003)(110136005)(66946007)(316002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pPNSFopm9rGdLbLy93Qf3B7FDFkANiYiBnldkfEyQOkyyMlu3zS4uVFsv6BX?=
 =?us-ascii?Q?D+Rz54re+/Sf+NubWGFkWO2c1pV1uFNWfytU2lPclGzSFLNDO6bD+XimvP9h?=
 =?us-ascii?Q?YyzluLrzlEpCZ/ZqbImfHZdcWhuxkAnleCxoJoR+s30LZbYHbb95ad6G67Vh?=
 =?us-ascii?Q?2+I44Lj+UHma9a2lptO+92g4xe+JTdfN774KcvKZyZUmJ3psr0bJoTK8CH3p?=
 =?us-ascii?Q?gRra+9gcBePl/GxGisAGXxh/N51Kx0PhiKFNsZiK8+aQZH9wCGKnIuKYj55n?=
 =?us-ascii?Q?pTHnGSi7zL7xXN1KHlxHs0E7xvL1X1LgH/+zmx5EyozDbP1ROLwKS9+0HUcd?=
 =?us-ascii?Q?9Y9l2eHydT9dAJQuxSlPDOxs58feYxkmC1QWD7+ZpddKwYUgwm1eBmvxba+1?=
 =?us-ascii?Q?ZCXZAHem4E2XtFKgrUetfdEx8sIjbUNqXTf/iUgxEgHxL4EJZAcQ5jxYFz2M?=
 =?us-ascii?Q?gCzkffzzs2bHPSWqkI7H+QLw/sJypJfBWcuKd0w2q0VxG3S6sLHkannzxc79?=
 =?us-ascii?Q?BTAhUww/R0OiID/S4p2CpErVi+3AJXv46GoGqDjHmNSjAFLrYbXvXTuf2j/w?=
 =?us-ascii?Q?T7+QPlwX+nBwDemf8C/IMI4opYiqW8T1LoBwWQoEerEYoIgCvVYIO8klShGP?=
 =?us-ascii?Q?WkyRxbulk2bUpfrlpPNdtmF2XdN8oY8dtFSV72B3Q2Ayd3uJglcRC0/YtabP?=
 =?us-ascii?Q?i+IPGicvyFUsnXJqKKaWkPj3rK15Y9pFnrW/5fbmKEvOLws8ov1hYtzsZmW2?=
 =?us-ascii?Q?In7bkCh5IuP9mtuw9su6qtB54hmrN5T9jLcrSx5A+ASPW2gwP4NOoWU7IYBk?=
 =?us-ascii?Q?XooLLsZ+ecIfBf8Jp26Esu1kqw+aszdW2W/0yKwbpqCF6lPFi8A+4n5vlnUp?=
 =?us-ascii?Q?JqGpEd635Fzuc4bVh35AhNl2nAgLZl2j4h3jGxmGR3gIZqlBb0PxHeN15pig?=
 =?us-ascii?Q?jMJABkjZ2ykmM7xHJJjpZs7DTGfDDzAoQFKH0kUl+OSd/X54NBPHvffzL9dj?=
 =?us-ascii?Q?6JxW1atPRfDM9IDaX2EzRmASR9XKySNxwWFJgE9wBpc7MhQT7jP2FmA9XJUL?=
 =?us-ascii?Q?mBEAKVqkaahP7//6kkVlzeCVxCevnzA+FJrK4xRPQiEHSs1M3a7YwA/qUY7j?=
 =?us-ascii?Q?VsLmcB7AIUG+DjHdXUiH4t+YV2BVAqTVRckYU+t39FytIlgZnPPNYT1G1fJy?=
 =?us-ascii?Q?6Gzh3FhrqyyMpvj+iV+MAawFPaQ9dl3cNsNSXONRhZZwClCDIcI6epIlgjlc?=
 =?us-ascii?Q?2SHx9FwTyyk7EsYu3JnrFsQhhd4Tc9ZkvqfUQpds2LpB1X7QeBshtNIQ4GS+?=
 =?us-ascii?Q?ef2y53KxF2j9qX8qZh12JwmbdudMx58eHohPauqlFCHuInWy/BNhiqxNxbaR?=
 =?us-ascii?Q?iBLOJvn1ucFZnPKuWsetWZWPhBPQyhRFe1LsbfNYsxwciseBtjnc2fYgEtA2?=
 =?us-ascii?Q?6eH4CDy4uB31aVS/LIoX1CacLgdy0x/U1t7OrkNe3uKobowpK+13bkFYN6+9?=
 =?us-ascii?Q?DdjIwGvliG033qKznyemMGsSyCytCEMG1KXDgnXkzh+ThSstOVpvjpOyjRq5?=
 =?us-ascii?Q?tjq13XHmim9z1+VZY1Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4ae0df-7968-4eba-76e4-08dbc8d91a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 15:04:57.6317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8AWKvhE66w5kxDlhHBO8KkUt4HF5AJjqAYxmo43yfV650pE1SDioAlvv5zuJaznUmfMSGbMgMNcyONR0qKevxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.c=
om>

-Veera

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Saturday, October 7, 2023 2:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.Gopalakris=
hnan@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/umsch: fix psp frontdoor loading

These changes are missed in rebase.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c |  35 +++---  drivers/gpu/drm=
/amd/amdgpu/amdgpu_umsch_mm.h |  18 +++-
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c   | 107 ++++++++-----------
 3 files changed, 72 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umsch_mm.c
index aeff9926412f..9d89c4186989 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -75,17 +75,6 @@ struct umsch_mm_test {
        uint32_t                num_queues;
 };

-int umsch_mm_psp_update_sram(struct amdgpu_device *adev, u32 ucode_size) -=
{
-       struct amdgpu_firmware_info ucode =3D {
-               .ucode_id =3D AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER,
-               .mc_addr =3D adev->umsch_mm.cmd_buf_gpu_addr,
-               .ucode_size =3D ucode_size,
-       };
-
-       return psp_execute_ip_fw_load(&adev->psp, &ucode);
-}
-
 static int map_ring_data(struct amdgpu_device *adev, struct amdgpu_vm *vm,
                          struct amdgpu_bo *bo, struct amdgpu_bo_va **bo_va=
,
                          uint64_t addr, uint32_t size)
@@ -694,15 +683,17 @@ int amdgpu_umsch_mm_allocate_ucode_data_buffer(struct=
 amdgpu_umsch_mm *umsch)
        return 0;
 }

-void* amdgpu_umsch_mm_add_cmd(struct amdgpu_umsch_mm *umsch,
-                             void* cmd_ptr, uint32_t reg_offset, uint32_t =
reg_data)
+int amdgpu_umsch_mm_psp_execute_cmd_buf(struct amdgpu_umsch_mm *umsch)
 {
-       uint32_t* ptr =3D (uint32_t *)cmd_ptr;
-
-       *ptr++ =3D (reg_offset << 2);
-       *ptr++ =3D reg_data;
+       struct amdgpu_device *adev =3D umsch->ring.adev;
+       struct amdgpu_firmware_info ucode =3D {
+               .ucode_id =3D AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER,
+               .mc_addr =3D adev->umsch_mm.cmd_buf_gpu_addr,
+               .ucode_size =3D ((uintptr_t)adev->umsch_mm.cmd_buf_curr_ptr=
 -
+                             (uintptr_t)adev->umsch_mm.cmd_buf_ptr),
+       };

-       return ptr;
+       return psp_execute_ip_fw_load(&adev->psp, &ucode);
 }

 static void umsch_mm_agdb_index_init(struct amdgpu_device *adev) @@ -824,1=
1 +815,9 @@ static int umsch_mm_hw_init(void *handle)
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
        int r;

-       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) {
-               r =3D umsch_mm_load_microcode(&adev->umsch_mm);
-               if (r)
-                       return r;
-       }
+       r =3D umsch_mm_load_microcode(&adev->umsch_mm);
+       if (r)
+               return r;

        umsch_mm_ring_start(&adev->umsch_mm);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umsch_mm.h
index d83fdf2da464..8258a43a6236 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
@@ -150,6 +150,7 @@ struct amdgpu_umsch_mm {
        struct amdgpu_bo                *cmd_buf_obj;
        uint64_t                        cmd_buf_gpu_addr;
        uint32_t                        *cmd_buf_ptr;
+       uint32_t                        *cmd_buf_curr_ptr;

        uint32_t                        wb_index;
        uint64_t                        sch_ctx_gpu_addr;
@@ -167,19 +168,28 @@ struct amdgpu_umsch_mm {
        struct mutex                    mutex_hidden;
 };

-int umsch_mm_psp_update_sram(struct amdgpu_device *adev, u32 ucode_size);
-
 int amdgpu_umsch_mm_submit_pkt(struct amdgpu_umsch_mm *umsch, void *pkt, i=
nt ndws);  int amdgpu_umsch_mm_query_fence(struct amdgpu_umsch_mm *umsch);

 int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_mm *umsch);  int am=
dgpu_umsch_mm_allocate_ucode_buffer(struct amdgpu_umsch_mm *umsch);  int am=
dgpu_umsch_mm_allocate_ucode_data_buffer(struct amdgpu_umsch_mm *umsch);
-void* amdgpu_umsch_mm_add_cmd(struct amdgpu_umsch_mm *umsch,
-                             void* cmd_ptr, uint32_t reg_offset, uint32_t =
reg_data);
+
+int amdgpu_umsch_mm_psp_execute_cmd_buf(struct amdgpu_umsch_mm *umsch);

 int amdgpu_umsch_mm_ring_init(struct amdgpu_umsch_mm *umsch);

+#define WREG32_SOC15_UMSCH(reg, value)                                    =
                     \
+       do {                                                               =
                     \
+               uint32_t reg_offset =3D adev->reg_offset[VCN_HWIP][0][reg##=
_BASE_IDX] + reg;      \
+               if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {  =
                         \
+                       *adev->umsch_mm.cmd_buf_curr_ptr++ =3D (reg_offset =
<< 2);                 \
+                       *adev->umsch_mm.cmd_buf_curr_ptr++ =3D value;      =
                       \
+               } else  {                                                  =
                     \
+                       WREG32(reg_offset, value);                         =
                     \
+               }                                                          =
                     \
+       } while (0)
+
 #define umsch_mm_set_hw_resources(umsch) \
        ((umsch)->funcs->set_hw_resources ? (umsch)->funcs->set_hw_resource=
s((umsch)) : 0)  #define umsch_mm_add_queue(umsch, input) \ diff --git a/dr=
ivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch=
_mm_v4_0.c
index 99713949b61f..a60178156c77 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -34,23 +34,10 @@
 #include "umsch_mm_4_0_api_def.h"
 #include "umsch_mm_v4_0.h"

-#define WREG32_SOC15_UMSCH(ptr, reg, value) \
-({     void *ret =3D ptr;                                                 =
                               \
-       do {                                                               =
                             \
-               uint32_t reg_offset =3D adev->reg_offset[VCN_HWIP][0][reg##=
_BASE_IDX] + reg;              \
-               if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP)    =
                                 \
-                       ret =3D amdgpu_umsch_mm_add_cmd((&adev->umsch_mm), =
(ptr), (reg_offset), (value)); \
-               else                                                       =
                             \
-                       WREG32(reg_offset, value);                         =
                             \
-       } while (0);                                                       =
                             \
-       ret;                                                               =
                             \
-})
-
 static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm *umsch)  {
        struct amdgpu_device *adev =3D umsch->ring.adev;
-       void* ptr =3D umsch->cmd_buf_ptr;
-       uint32_t data;
+       uint64_t data;
        int r;

        r =3D amdgpu_umsch_mm_allocate_ucode_buffer(umsch);
@@ -61,97 +48,95 @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_u=
msch_mm *umsch)
        if (r)
                goto err_free_ucode_bo;

+       umsch->cmd_buf_curr_ptr =3D umsch->cmd_buf_ptr;
+
        data =3D RREG32_SOC15(VCN, 0, regUMSCH_MES_RESET_CTRL);
        data =3D REG_SET_FIELD(data, UMSCH_MES_RESET_CTRL, MES_CORE_SOFT_RE=
SET, 0);
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regUMSCH_MES_RESET_CTRL, data);
+       WREG32_SOC15_UMSCH(regUMSCH_MES_RESET_CTRL, data);

        data =3D RREG32_SOC15(VCN, 0, regVCN_MES_CNTL);
        data =3D REG_SET_FIELD(data, VCN_MES_CNTL, MES_INVALIDATE_ICACHE, 1=
);
        data =3D REG_SET_FIELD(data, VCN_MES_CNTL, MES_PIPE0_RESET, 1);
        data =3D REG_SET_FIELD(data, VCN_MES_CNTL, MES_PIPE0_ACTIVE, 0);
        data =3D REG_SET_FIELD(data, VCN_MES_CNTL, MES_HALT, 1);
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_CNTL, data);
+       WREG32_SOC15_UMSCH(regVCN_MES_CNTL, data);

        data =3D RREG32_SOC15(VCN, 0, regVCN_MES_IC_BASE_CNTL);
        data =3D REG_SET_FIELD(data, VCN_MES_IC_BASE_CNTL, VMID, 0);
        data =3D REG_SET_FIELD(data, VCN_MES_IC_BASE_CNTL, EXE_DISABLE, 0);
        data =3D REG_SET_FIELD(data, VCN_MES_IC_BASE_CNTL, CACHE_POLICY, 0)=
;
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_IC_BASE_CNTL, data);
+       WREG32_SOC15_UMSCH(regVCN_MES_IC_BASE_CNTL, data);

+       WREG32_SOC15_UMSCH(regVCN_MES_INTR_ROUTINE_START,
+               lower_32_bits(adev->umsch_mm.irq_start_addr >> 2));
+       WREG32_SOC15_UMSCH(regVCN_MES_INTR_ROUTINE_START_HI,
+               upper_32_bits(adev->umsch_mm.irq_start_addr >> 2));

-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_INTR_ROUTINE_START,
-                                lower_32_bits(adev->umsch_mm.irq_start_add=
r >> 2));
+       WREG32_SOC15_UMSCH(regVCN_MES_PRGRM_CNTR_START,
+               lower_32_bits(adev->umsch_mm.uc_start_addr >> 2));
+       WREG32_SOC15_UMSCH(regVCN_MES_PRGRM_CNTR_START_HI,
+               upper_32_bits(adev->umsch_mm.uc_start_addr >> 2));

-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_INTR_ROUTINE_START_HI,
-                                upper_32_bits(adev->umsch_mm.irq_start_add=
r >> 2));
-
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_PRGRM_CNTR_START,
-                                lower_32_bits(adev->umsch_mm.uc_start_addr=
 >> 2));
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_PRGRM_CNTR_START_HI,
-                                upper_32_bits(adev->umsch_mm.uc_start_addr=
 >> 2));
-
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_INSTR_BASE_LO, 0);
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_INSTR_BASE_HI, 0);
+       WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_INSTR_BASE_LO, 0);
+       WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_INSTR_BASE_HI, 0);

        data =3D adev->umsch_mm.uc_start_addr + adev->umsch_mm.ucode_size -=
 1;
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_INSTR_MASK_LO, low=
er_32_bits(data));
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_INSTR_MASK_HI, upp=
er_32_bits(data));
+       WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_INSTR_MASK_LO, lower_32_bits(da=
ta));
+       WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_INSTR_MASK_HI,
+upper_32_bits(data));

-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_IC_BASE_LO,
-                                lower_32_bits(adev->umsch_mm.ucode_fw_gpu_=
addr));
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_IC_BASE_HI,
-                                upper_32_bits(adev->umsch_mm.ucode_fw_gpu_=
addr));
+       data =3D adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP ?
+              0 : adev->umsch_mm.ucode_fw_gpu_addr;
+       WREG32_SOC15_UMSCH(regVCN_MES_IC_BASE_LO, lower_32_bits(data));
+       WREG32_SOC15_UMSCH(regVCN_MES_IC_BASE_HI, upper_32_bits(data));

-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_MIBOUND_LO, 0x1FFFFF);
+       WREG32_SOC15_UMSCH(regVCN_MES_MIBOUND_LO, 0x1FFFFF);

-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_BASE0_LO,
-                                lower_32_bits(adev->umsch_mm.data_start_ad=
dr));
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_BASE0_HI,
-                                upper_32_bits(adev->umsch_mm.data_start_ad=
dr));
+       WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_BASE0_LO,
+               lower_32_bits(adev->umsch_mm.data_start_addr));
+       WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_BASE0_HI,
+               upper_32_bits(adev->umsch_mm.data_start_addr));

-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_MASK0_LO,
-                                lower_32_bits(adev->umsch_mm.data_size - 1=
));
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_MASK0_HI,
-                                upper_32_bits(adev->umsch_mm.data_size - 1=
));
+       WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_MASK0_LO,
+               lower_32_bits(adev->umsch_mm.data_size - 1));
+       WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_MASK0_HI,
+               upper_32_bits(adev->umsch_mm.data_size - 1));

-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_DC_BASE_LO,
-                                lower_32_bits(adev->umsch_mm.data_fw_gpu_a=
ddr));
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_DC_BASE_HI,
-                                upper_32_bits(adev->umsch_mm.data_fw_gpu_a=
ddr));
+       data =3D adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP ?
+              0 : adev->umsch_mm.data_fw_gpu_addr;
+       WREG32_SOC15_UMSCH(regVCN_MES_DC_BASE_LO, lower_32_bits(data));
+       WREG32_SOC15_UMSCH(regVCN_MES_DC_BASE_HI, upper_32_bits(data));

-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_MDBOUND_LO, 0x3FFFF);
+       WREG32_SOC15_UMSCH(regVCN_MES_MDBOUND_LO, 0x3FFFF);

        data =3D RREG32_SOC15(VCN, 0, regUVD_UMSCH_FORCE);
        data =3D REG_SET_FIELD(data, UVD_UMSCH_FORCE, IC_FORCE_GPUVM, 1);
        data =3D REG_SET_FIELD(data, UVD_UMSCH_FORCE, DC_FORCE_GPUVM, 1);
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regUVD_UMSCH_FORCE, data);
+       WREG32_SOC15_UMSCH(regUVD_UMSCH_FORCE, data);

        data =3D RREG32_SOC15(VCN, 0, regVCN_MES_IC_OP_CNTL);
        data =3D REG_SET_FIELD(data, VCN_MES_IC_OP_CNTL, PRIME_ICACHE, 0);
        data =3D REG_SET_FIELD(data, VCN_MES_IC_OP_CNTL, INVALIDATE_CACHE, =
1);
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_IC_OP_CNTL, data);
+       WREG32_SOC15_UMSCH(regVCN_MES_IC_OP_CNTL, data);

        data =3D RREG32_SOC15(VCN, 0, regVCN_MES_IC_OP_CNTL);
        data =3D REG_SET_FIELD(data, VCN_MES_IC_OP_CNTL, PRIME_ICACHE, 1);
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_IC_OP_CNTL, data);
+       WREG32_SOC15_UMSCH(regVCN_MES_IC_OP_CNTL, data);

-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_GP0_LO, 0);
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_GP0_HI, 0);
+       WREG32_SOC15_UMSCH(regVCN_MES_GP0_LO, 0);
+       WREG32_SOC15_UMSCH(regVCN_MES_GP0_HI, 0);

-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_GP1_LO, 0);
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_GP1_HI, 0);
+       WREG32_SOC15_UMSCH(regVCN_MES_GP1_LO, 0);
+       WREG32_SOC15_UMSCH(regVCN_MES_GP1_HI, 0);

        data =3D RREG32_SOC15(VCN, 0, regVCN_MES_CNTL);
        data =3D REG_SET_FIELD(data, VCN_MES_CNTL, MES_INVALIDATE_ICACHE, 0=
);
        data =3D REG_SET_FIELD(data, VCN_MES_CNTL, MES_PIPE0_RESET, 0);
        data =3D REG_SET_FIELD(data, VCN_MES_CNTL, MES_HALT, 0);
        data =3D REG_SET_FIELD(data, VCN_MES_CNTL, MES_PIPE0_ACTIVE, 1);
-       ptr =3D WREG32_SOC15_UMSCH(ptr, regVCN_MES_CNTL, data);
+       WREG32_SOC15_UMSCH(regVCN_MES_CNTL, data);

-       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
-               umsch_mm_psp_update_sram(adev,
-                                        (u32)((uintptr_t)ptr - (uintptr_t)=
umsch->cmd_buf_ptr));
-       }
+       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP)
+               amdgpu_umsch_mm_psp_execute_cmd_buf(umsch);

        r =3D SOC15_WAIT_ON_RREG(VCN, 0, regVCN_MES_MSTATUS_LO, 0xAAAAAAAA,=
 0xFFFFFFFF);
        if (r) {
--
2.25.1

