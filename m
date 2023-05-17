Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DE0C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 18:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF4F10E458;
	Wed, 17 May 2023 18:09:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB25510E458
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 18:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8zAodx7phTG7OweDtI8Iper4ephh3eMcWheDHuwk9F7lUyFNABHdTzDG7EkMbZMT7Xyu1xYFgi7+n/DnsDBZ2kFZ3NV1qiYsOjn7DZTWw2MTQ4nHvAoQ/IclL+xqCmoA/RJdIdwgYwPzT8MXUzDa9TcaR4cljppyTAdQ9CIMFWby/FpBdECoPKyHP9inLAM4lPCBvdFn6RXiv9KtZ8RQ8wEdT2uCbrHNSLj/sy9umINfAHoGX7RXm1uuyWtV5R5pbEkwBQXZllX21/JhZ3qkLQexvWBmIM/wVdyvHF2EnNPqc9e7kAwk4kFP7S4kogxJgUYbqiNYrx4Vk0uwvWb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9W4pekmIUOaRbdeNPCOhALIAOjWrQFGRzWW96LyO9zA=;
 b=eKk9NVED3U7fvK8tuXO3UYvwkJS3uMfhEWk+8rTRZ+VCyt8mtiufrAVO1ZofrGNdNZ9BFVTfJJ4nCMtKpc3IkhMKGzpj7dmC/IvjX6Fa/kr0wR1GOekr+Z4HlqdcFFq0Irp1dA06ysKbtQN7BusyA0wHLHjZySnvfJRtA7PeXvMcQc2tZzDvkrOExypJ3AutPILbmg7+Xz5npkCIilkZy5qI5YwWLDo32aHf/eLeXphmHf5W7FduefGkW9NjM4JbQvqYI4uwUYxsM2iXKOkNhGt4EN9igRyKABb/JtCRNN0EzcrrjgkU9UHpWl+oJcQ+iXIGP2hsV01BFNN25IlUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9W4pekmIUOaRbdeNPCOhALIAOjWrQFGRzWW96LyO9zA=;
 b=K5tsSyUQOJNW2KJEXidbdLILnBukQNyVsLfJRm2ScRhZROLmElVIPygEDypMYPfopWynkyaQ26tM4B7d8I2Xk8a4+qjy49rUOtuWoKxBs4RGnTzgc57xG1EANjwZRyI+qrKi7QMxHjYrCPJTQYxtCyDVy3HWFjgjW8cpygRrkGk=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 18:09:28 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7ca6:a548:58f8:e0c0]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7ca6:a548:58f8:e0c0%2]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 18:09:28 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition code
Thread-Topic: [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition code
Thread-Index: AQHZiON9fjDJHSsPfUCUfJJK3QA5369ew6IN
Date: Wed, 17 May 2023 18:09:28 +0000
Message-ID: <BL3PR12MB64254554ED9CC41B79B5E96CEE7E9@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20230517171726.4188188-1-alexander.deucher@amd.com>
In-Reply-To: <20230517171726.4188188-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-17T18:09:28.122Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|DM6PR12MB4355:EE_
x-ms-office365-filtering-correlation-id: 3efc61ec-b6aa-4146-f087-08db5701db0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3qqmpJaTBHaAAlKnbi48fVg5F6L2MOcqMJmHyqFbYsIPRNGTfuUPH4kmKAzeu0Qc76prGkV2n0QBEmsOV707pWD98PuBrEM8pokdwrHzC9bDU9JE0BM7O2WQvUVdhj2Ho8GKo1BhfAunvI2TZBNQ4xeuo1OI/j79XsGLc2lr8NQxRa5ox8/+hU1WpHNIKteaPry8zGrUrERqJW64ZUd7gtor6PL7yLdxWlj0HcmppKrBWOQT6s0s4JCedtdkwCpdMaw1XrFr/kQGntRdFTWRw7ij5UmuykDe+kx8PldPzSju9q9VURipvX5yPmmNW6nMfbQanAhScnixpnOox8oWEnFX2Unw+P7Ms84yHdJSoYnPHirwio/qTK2AdpMZYkrh0rkqfmCHcWSfMTjw5YMkFQ6PEYkvwMEww3/vJd0nRfO/Glz+GKDM9+KHLEVpCsGtMESugYjH98YCF7L1MNdWYYcWX4c+aNaMr2Gk4Kht7tw5A16TB9Ml0vu1Lddn/5HYC1v/nSB2XZK7fFclaGE0oH4k0vn9pu5+7/e5uWCAChxdSUHlXCxbfcuOLjVFBO49gln01sNAqF+TZ5SQVlE+Z7k6aNUKVqkWazKvWYhSENt/9RB5CC6A1AIHb4wHVibM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199021)(19627405001)(38070700005)(76116006)(4326008)(478600001)(66446008)(66946007)(64756008)(66556008)(7696005)(66476007)(316002)(110136005)(91956017)(86362001)(33656002)(83380400001)(6506007)(186003)(53546011)(9686003)(26005)(52536014)(5660300002)(2906002)(8936002)(8676002)(41300700001)(55016003)(38100700002)(122000001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PWIngAsW9dN5i4zO7g8XQ/Ftsrg8e8bsKhVcVSKh0YQobUexw6mB3eFfSPmV?=
 =?us-ascii?Q?s2LJ69WEjaOLuVeCxnx+3pYmspIuaSYmsh62c8FW4f1TIscskzLerBA/6Y48?=
 =?us-ascii?Q?J1G2lOV7199HoUjTBKxQhu9gvKR7+MDPVJhvpAWmtgca0mUyXBuAWqoA475H?=
 =?us-ascii?Q?2kRg0BgVbPWFOb5ViroR69Lxo2e1yPYYvnwumOScNeRd3US9N7CqFNG69vLb?=
 =?us-ascii?Q?Mj9rwPM/wr15ZrHkcBWTiPWH505/ejq97CuW5Uj6tlqvmrlsnK2IMFhTemKD?=
 =?us-ascii?Q?wZdUifFThdBZUd0DxRPJYBfgU2Dh45HiWWJiGXYezOX5luzohzZuifL1uL8U?=
 =?us-ascii?Q?sseQymLkRikLHmWJTJGf1/YgkPy9TmR8w8iDjuhMpXrfqiYxcd279telGxdw?=
 =?us-ascii?Q?x7yapIme5d1JctZAxu4/7MQPOSGswjpHmah4t86qFqU0b6SjAWFkGdTByGoO?=
 =?us-ascii?Q?Kl54F6wmppQ/wxbi/92kR73mHlwQUfKV3tPRGB5pDxic5U2qCTjzBbHuANIx?=
 =?us-ascii?Q?vwrqp98Yr9SMJumkyvOQdViDIvRnTGGuwXaRqmHeVqeYHMiFghq8jBSbAF5B?=
 =?us-ascii?Q?e/DCBcCL2ynNCJf+U/dZxyHkHQKaYbE92RtaKq0gKEAohI1HURr9MfwCaiXI?=
 =?us-ascii?Q?IwEPTeYZs2jkwtFMVrp8c8BMzSKQbNwUrwc67x41kZp+RtvmH75j38foyilb?=
 =?us-ascii?Q?JqrJAwKTjFG2ssHoQ4I7I+FL9M3FB0H7Mx4IUMCEVSwUci1OttutfyOKMfth?=
 =?us-ascii?Q?r0EDVjobs8BOOCdtfBkxzHLRKnWymCSXtMEBn/yU5iH3WHr28RKhrQnDhtg0?=
 =?us-ascii?Q?yutK/pb+z9diaquBjBZApSXoCMwSHcem9OOzFB6/0oUcC6R+iHaOuxy4SzV/?=
 =?us-ascii?Q?kJXTh9xLgAQgnHc9GEROaIm1oOI/fChRMOIQLPGmC4jDHKxC7jhbbOXPIBWx?=
 =?us-ascii?Q?7tCin4Rk8kbMin+K3oRsDwAdBCFg5ygk7slySCzSU6bQkW30rfWgAh1diH7F?=
 =?us-ascii?Q?KzYRcpz58ho1Z9kawH/TAuzCL0CnuqRdHsJowCQdzBTK9UN+Vahkqfd09wIa?=
 =?us-ascii?Q?DR2soE0MwSxYXtdrKRv/VlrkIswICpaOXveYUgOPBZCufjte0QULqBJtn6No?=
 =?us-ascii?Q?tJnkQVjq9tiw51+66PLAjT6KXMSx6P+vq2VVvtGdHecjtds6rugAj6jqx5vq?=
 =?us-ascii?Q?dQkOGYNda+xoHe5zPFeWm7ipHcHQDGVLTrjyzGaDsk7Pbs7P72FYS5uSI/SY?=
 =?us-ascii?Q?k6W/cSlOhqiXX2OZnO+qnOnK3LUllHrQlNPhC0xR41jhEALWXbrlZ3CqPlWT?=
 =?us-ascii?Q?1UtERiVqkIXdSnd7Z657pIwFilEQyWLBZzN75/tssbAEaREVxnbvRkfw5DzO?=
 =?us-ascii?Q?UWHnCZw0xAMeaa4Gi+skQQHhtAa/0/0RJJZjQUNf0bSamJSlN35/7G3RhCMm?=
 =?us-ascii?Q?EVWxI3Atp5RdOtNsqHRv8Rl08KoG858sRI7xOlgD6M+zCKr7NyXadjfxJ3Jz?=
 =?us-ascii?Q?4WQ7f0EkbtaMUwfQlqezQ8ssJjfT+7m4MJopdL1KLlDe5I4lcN6swtCfQE8Q?=
 =?us-ascii?Q?TFc9t6G8qnF0xESzHvI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL3PR12MB64254554ED9CC41B79B5E96CEE7E9BL3PR12MB6425namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efc61ec-b6aa-4146-f087-08db5701db0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 18:09:28.4423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3mIl7Ur+p2DGp4WnRAT/waVUhTNgBEeOp3cjqxkI+yZ1Mz9Z/ctJbv6THd8qGzyyDgbLLXE+HxIP/nlJjzijA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL3PR12MB64254554ED9CC41B79B5E96CEE7E9BL3PR12MB6425namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Wednesday, May 17, 2023 1:17 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition code

Rework logic or use do_div() to avoid problems on 32 bit.

v2: add a missing case for XCP macro
v3: fix out of bounds array access

Acked-by: Guchun Chen <guchun.chen@amd.com> (v1)
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com> (v2)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  9 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 11 ++++++-----
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 739eb7c0d133..5de92c9ab18f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -794,3 +794,18 @@ void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *ad=
ev)
 {
         kgd2kfd_unlock_kfd();
 }
+
+
+u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
+{
+       u64 tmp;
+       s8 mem_id =3D KFD_XCP_MEM_ID(adev, xcp_id);
+
+       if (adev->gmc.num_mem_partitions && xcp_id >=3D 0 && mem_id >=3D 0)=
 {
+               tmp =3D adev->gmc.mem_partitions[mem_id].size;
+               do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
+               return tmp;
+       } else {
+               return adev->gmc.real_vram_size;
+       }
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index be43d71ba7ef..94cc456761e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -333,15 +333,14 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_dev=
ice *adev,
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
                 uint64_t size, u32 alloc_flag, int8_t xcp_id);

+u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
+
 #define KFD_XCP_MEM_ID(adev, xcp_id) \
                 ((adev)->xcp_mgr && (xcp_id) >=3D 0 ?\
                 (adev)->xcp_mgr->xcp[(xcp_id)].mem_id : -1)

-#define KFD_XCP_MEMORY_SIZE(adev, xcp_id)\
-               ((adev)->gmc.num_mem_partitions && (xcp_id) >=3D 0 ?\
-               (adev)->gmc.mem_partitions[KFD_XCP_MEM_ID((adev), (xcp_id))=
].size /\
-               (adev)->xcp_mgr->num_xcp_per_mem_partition :\
-               (adev)->gmc.real_vram_size)
+#define KFD_XCP_MEMORY_SIZE(adev, xcp_id) amdgpu_amdkfd_xcp_memory_size((a=
dev), (xcp_id))
+

 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index ad664ef640ff..34724b771ace 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -818,11 +818,14 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdg=
pu_device *adev,
         struct amdgpu_ttm_tt *gtt =3D (void *)ttm;
         uint64_t total_pages =3D ttm->num_pages;
         int num_xcc =3D max(1U, adev->gfx.num_xcc_per_xcp);
-       uint64_t page_idx, pages_per_xcc =3D total_pages / num_xcc;
+       uint64_t page_idx, pages_per_xcc;
         int i;
         uint64_t ctrl_flags =3D (flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
                         AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);

+       pages_per_xcc =3D total_pages;
+       do_div(pages_per_xcc, num_xcc);
+
         for (i =3D 0, page_idx =3D 0; i < num_xcc; i++, page_idx +=3D page=
s_per_xcc) {
                 /* MQD page: use default flags */
                 amdgpu_gart_bind(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 938c8dba9057..d559e7bc0f09 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1919,9 +1919,10 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *=
adev,
         adev->gmc.num_mem_partitions =3D num_ranges;

         /* If there is only partition, don't use entire size */
-       if (adev->gmc.num_mem_partitions =3D=3D 1)
-               mem_ranges[0].size =3D
-                       (mem_ranges[0].size * (mem_groups - 1) / mem_groups=
);
+       if (adev->gmc.num_mem_partitions =3D=3D 1) {
+               mem_ranges[0].size =3D mem_ranges[0].size * (mem_groups - 1=
);
+               do_div(mem_ranges[0].size, mem_groups);
+       }
 }

 static void
@@ -1953,8 +1954,8 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *ade=
v,
                 break;
         }

-       size =3D (adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT) /
-              adev->gmc.num_mem_partitions;
+       size =3D adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT;
+       size /=3D adev->gmc.num_mem_partitions;

         for (i =3D 0; i < adev->gmc.num_mem_partitions; ++i) {
                 mem_ranges[i].range.fpfn =3D start_addr;
--
2.40.1


--_000_BL3PR12MB64254554ED9CC41B79B5E96CEE7E9BL3PR12MB6425namp_
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
Reviewed-by: Mukul Joshi &lt;mukul.joshi@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 17, 2023 1:17 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Guch=
un &lt;Guchun.Chen@amd.com&gt;; Joshi, Mukul &lt;Mukul.Joshi@amd.com&gt;<br=
>
<b>Subject:</b> [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition c=
ode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Rework logic or use do_div() to avoid problems on =
32 bit.<br>
<br>
v2: add a missing case for XCP macro<br>
v3: fix out of bounds array access<br>
<br>
Acked-by: Guchun Chen &lt;guchun.chen@amd.com&gt; (v1)<br>
Reviewed-by: Mukul Joshi &lt;mukul.joshi@amd.com&gt; (v2)<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |&nbsp; 9 ++++-----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp; |&nbsp; 5 +=
+++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
 11 ++++++-----<br>
&nbsp;4 files changed, 29 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c<br>
index 739eb7c0d133..5de92c9ab18f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
@@ -794,3 +794,18 @@ void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *ad=
ev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd2kfd_unlock_kfd();<br>
&nbsp;}<br>
+<br>
+<br>
+u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)<=
br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 tmp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s8 mem_id =3D KFD_XCP_MEM_ID(adev, xc=
p_id);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.num_mem_partitions &=
amp;&amp; xcp_id &gt;=3D 0 &amp;&amp; mem_id &gt;=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D adev-&gt;gmc.mem_partitions[mem_id].size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; do_div(tmp, adev-&gt;xcp_mgr-&gt;num_xcp_per_mem_partition);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return tmp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return adev-&gt;gmc.real_vram_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h<br>
index be43d71ba7ef..94cc456761e5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
@@ -333,15 +333,14 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_dev=
ice *adev,<br>
&nbsp;void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint64_t size, u32 alloc_flag, int8_t xcp_id);<br>
&nbsp;<br>
+u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);=
<br>
+<br>
&nbsp;#define KFD_XCP_MEM_ID(adev, xcp_id) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;xcp_mgr &amp;&amp; (xcp_id) &gt;=3D 0 ?\<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (adev)-&gt;xcp_mgr-&gt;xcp[(xcp_id)].mem_id : -1)<br>
&nbsp;<br>
-#define KFD_XCP_MEMORY_SIZE(adev, xcp_id)\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((adev)-&gt;gmc.num_mem_partitions &amp;&amp; (xcp_id) &gt;=3D 0=
 ?\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (adev)-&gt;gmc.mem_partitions[KFD_XCP_MEM_ID((adev), (xcp_id))].=
size /\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (adev)-&gt;xcp_mgr-&gt;num_xcp_per_mem_partition :\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (adev)-&gt;gmc.real_vram_size)<br>
+#define KFD_XCP_MEMORY_SIZE(adev, xcp_id) amdgpu_amdkfd_xcp_memory_size((a=
dev), (xcp_id))<br>
+<br>
&nbsp;<br>
&nbsp;#if IS_ENABLED(CONFIG_HSA_AMD)<br>
&nbsp;void amdgpu_amdkfd_gpuvm_init_mem_limits(void);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index ad664ef640ff..34724b771ace 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -818,11 +818,14 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdg=
pu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ttm_tt *gtt =
=3D (void *)ttm;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t total_pages =3D t=
tm-&gt;num_pages;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_xcc =3D max(1U, ad=
ev-&gt;gfx.num_xcc_per_xcp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_idx, pages_per_xcc =3D =
total_pages / num_xcc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_idx, pages_per_xcc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t ctrl_flags =3D (f=
lags &amp; ~AMDGPU_PTE_MTYPE_VG10_MASK) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGP=
U_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_xcc =3D total_pages;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_div(pages_per_xcc, num_xcc);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0, page_idx =3D=
 0; i &lt; num_xcc; i++, page_idx +=3D pages_per_xcc) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* MQD page: use default flags */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gart_bind(adev,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c<br>
index 938c8dba9057..d559e7bc0f09 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
@@ -1919,9 +1919,10 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.num_mem_parti=
tions =3D num_ranges;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If there is only partit=
ion, don't use entire size */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.num_mem_partitions =
=3D=3D 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mem_ranges[0].size =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (mem_ranges[0].s=
ize * (mem_groups - 1) / mem_groups);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.num_mem_partitions =
=3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mem_ranges[0].size =3D mem_ranges[0].size * (mem_groups - 1);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; do_div(mem_ranges[0].size, mem_groups);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void<br>
@@ -1953,8 +1954,8 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *ade=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D (adev-&gt;gmc.real_vram_size=
 &gt;&gt; AMDGPU_GPU_PAGE_SHIFT) /<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; adev-&gt;gmc.num_mem_partitions;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D adev-&gt;gmc.real_vram_size =
&gt;&gt; AMDGPU_GPU_PAGE_SHIFT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size /=3D adev-&gt;gmc.num_mem_partit=
ions;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;gmc.num_mem_partitions; ++i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mem_ranges[i].range.fpfn =3D start_addr;<br>
-- <br>
2.40.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL3PR12MB64254554ED9CC41B79B5E96CEE7E9BL3PR12MB6425namp_--
