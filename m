Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E11F4181F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 17:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78E1D10E571;
	Mon,  9 Mar 2026 17:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xieLtu1h";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013025.outbound.protection.outlook.com
 [40.93.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6379A10E571
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 17:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faMbn9oAqV4M8JkAzVEz652tiMF42UWqVom3b/S4xx4IEBKkpW9lbCCAXZRSEDTCdUHmv/aBCuqe7PRxH/AG4AIe536m4LCT8NCigHCN4ejKCQZVKYMf588eQrgZJkJhyDum0nGbZIaFjf2D7dWOayDBWn6TDI/G/1JXxhh0J1rNQwKXqt6XKN/ys1EZr7fyasGKqhYhqa/pSCzy1bgCDIzRIgBQN0CSzlUYPWYgZgw0Vas/jwf9pNP7n8lVu32tuVpmZy/ARvtUmWY3/ol9EYq+lzURoidrn4nWr0JWMZk67BJHNBJyrtID+RFAqPYqBEjUcpXEhDJYAEeaA3shWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzaItPK3bJMMoyattVKU3ENZog4X3WeVwxuCLhTp1Fg=;
 b=qT9rzWcm8zHC5BQ5sYNmuodL6iW/262qXCuSpTsC/cYG0zw25VsQitn46kARBLzr6zrzEBKZkYJQ2njXBOggjpCwrCXmrxz/6RMtvsZxRIZWjiY6YX8GyY2UhnM6XC7Yn2vW+ZIkyDEkH9KlYHdG7zPzaqmfGbMW8eSoJyO8TLJxiS12U9rCdtGOJurFuwp4yH7lAcLUqRzG+oTYOdq+FA3niX34brIwmJmoplYLDRtTkT69s1/27lQnO6AIR41S4FGjp1OgTesy7RxYBZ4BgXsHGd22y7p47U5amJtaUiZw+/771ip9Mv6wRkXKQGHlPpGOPSJ/MKkRbdVEuDs6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzaItPK3bJMMoyattVKU3ENZog4X3WeVwxuCLhTp1Fg=;
 b=xieLtu1hsDvPovKFOIyq/D1XKljm3Q3BDJfacuLgEBgO3iLGYL0oUkvmhZR152AxUs4E/gyvmC6sqkIwo/IDQ3hGkCwC6y3OGD5WS4hjiv3pgEu/s9IU5iYMxqdmDMUv7TF5lcOTMd2hVrpuc+FdoxfJQXuJb0NlRLAqQKNGy2E=
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 17:12:38 +0000
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67]) by SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67%3]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 17:12:38 +0000
From: "Xie, Chenglei" <Chenglei.Xie@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Avoid KIQ ring access during GPU reset to
 fix fence timeout
Thread-Topic: [PATCH v2] drm/amdgpu: Avoid KIQ ring access during GPU reset to
 fix fence timeout
Thread-Index: AQHcr+eSouiW8es7QEejVdRZt8DW67Wmb3pw
Date: Mon, 9 Mar 2026 17:12:38 +0000
Message-ID: <SJ1PR12MB61211876A96980487E022F118079A@SJ1PR12MB6121.namprd12.prod.outlook.com>
References: <CADnq5_OCRm7oVkr7TY_OCyfSnkPJXAY7ZhjThpEbAauQNz_T_g@mail.gmail.com>
 <20260309170950.1982724-1-Chenglei.Xie@amd.com>
In-Reply-To: <20260309170950.1982724-1-Chenglei.Xie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-09T17:10:35.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6121:EE_|CY5PR12MB6369:EE_
x-ms-office365-filtering-correlation-id: d579d568-40d4-4b31-97a4-08de7dff10b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: qHuol3oW6yMVvZnqkZSKSfxiGBbDmwIpiENZJnrr9wO/kYr+a2/2UppzZxx5mifsAnYgi+/cMPyFzgieokNf/WsZ0sgAREdwHz0tJ9byj1DwYDQiUw8CcEGn6rD/tuIMNsM/9Ae/hEcGdv20erUJVb1bkFXAb/6kgwdKmXLhI01TH2a0b8u3M7+AeeCCoEhpVGKzodw7gWhmK0Q/O17DWJedj/WC0F6NxBfqxzLMkKyVLg3aZ7aGUTfBBoDVz0n6b3yDbOJzg24ii3rqy8Bz1zxRDilJOzQhJC3FdMe88WQyarywsNexEEWr/5RMzC5HuKhn6fvy4sB0zpxutb7WC5w567vXi2+ZDworr6faNJKmmfXRM5hiVZV2kzO3YpKmrdP83JmgRZDt5zThF51Vr9OHqpk259b66hgzuyPwg0AJ5J7vcKT3BmCSrCKoABhpWbV34VhdWWODHZEKgDtP1q97bRQSSVgCMsbLaQubv2Vhv/kA7xP+vw/kXgFSShRIYBlyeKEyLzJOW5B8hRSlJDDKC3zcC9yoCeNS/799GEJf9vjGcxVoxO01H9mpZOsmDAgEj11z4YmiNAyJKhKB/Qns+AbHy4XCfmqKjQ6JV7sSl3eiCltSxlkX0BxaGYxU6JowPbwRz3sHqXi4SjKOd98B8cBXS1v+Q233/3nbS1DKnFFprFwRcR0HNbpiVDpfIwbSJChd3mE/bKlmmFnIdM6twXdO+6UM2vV0YdMEhn4moxNF77576od9Pl3iAAREbp5do6ZLdzyMV6mirlCdt+ZagsfGRZw6Ju/mx/eCTiY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?STmglcZVFuhoVMALGdAYfyZW8PAhygkSUbhJK2CB8OxIh1sYZkWfiganJUuM?=
 =?us-ascii?Q?1t9OF0gKhdogW7Oyas8cp0rg5b7CPZUOhkPhbjOONp7LuZkyoCkMqn+5/iTP?=
 =?us-ascii?Q?XEpfNOxhUMsuXm0KOm2d7rgfCk6pQXyCVDE6bYAviZe5PenwgqOtc/qncG+d?=
 =?us-ascii?Q?7EAcvuTKarofEQOAhwygLw0Wk6zsWmYZPendogEbFpS5lHy8mLLUWifICIrW?=
 =?us-ascii?Q?7LsLfiNKQ00vStpKHhtrUMFeHDRQ0wjjLuDR/dYnkvq/qQ06EoNdII91bsB/?=
 =?us-ascii?Q?p9dsiPz00UOGffUG8bQl3JyPXu+GV4Ch5Uu/VvUTxm9tBNl0sw15rLfHO05M?=
 =?us-ascii?Q?bXXpj5FiMt2IO2k3nWWkMEtiLtAmz2pROBpczoHFotB/nFvvegEZQQK5YbDn?=
 =?us-ascii?Q?KFWpQXdyC5elmkwGDGm32uoC4eYqHsf/ZW+i7cqBVdbCWWrZ7VV34ZZb2oKc?=
 =?us-ascii?Q?M+kvFK9Lx0KBWPt6+C2ZZL3NklexQ8WXH38b0jOysCIxXEhyc7dLW0iMoJ7Y?=
 =?us-ascii?Q?+GZqk1EkNmKaYY35zsmFC5vPy3zaXwtkbPYQVXya2JJCvzp1x4MekFwJeFdK?=
 =?us-ascii?Q?uq6CWPwzhEzS0rdv1D5Lhste0tA7i0Z6uqmKOUGWLwEaSyf+qmnOyIz5CG4d?=
 =?us-ascii?Q?q8gi1TjDIFOEwcA8HLx7ou4kl4K90Hy2lzm5bYOoUu/pdSLJ9VagQ+00pRua?=
 =?us-ascii?Q?KLq9oap7Ukl8OF4zb2WIndKTOrzWkNZAGuVMeiNCd6PuFdnoRgffI19ss/62?=
 =?us-ascii?Q?xECaoScTgMxTjOcSl1QecDiXpPWZx3gc44eEb+AUrcSLltgJKktvjJBEEus/?=
 =?us-ascii?Q?9BEz/3DYtW8bFOy2zEDdexqYSbklwdS3DEXI0QKNVAKI6n8dAprL6MkEV41x?=
 =?us-ascii?Q?0z0l5hlwGEvsIkG9R6tdEyOuPSR1xRb7ZqNW6CBNOH/of6Mlz0hOLZ/Jlv9Z?=
 =?us-ascii?Q?d5PHZSTH5bbKyFJiddfKbl4P4C8dz/atm6nf6wqn6UuU4TZIKYrXfLZ9tJCg?=
 =?us-ascii?Q?ufo6uI6+ROLB9fN6/8iJAqgQReCp7P7cco7qrqK6lpjSWppQjfHFvz4oLU7S?=
 =?us-ascii?Q?mrU0LE0Bs0kri64vNAeclgxTUlC+/y6xUrcVnNZkoeNDLTJ6PKo6Wz+78R7K?=
 =?us-ascii?Q?xIjNfp2c/oZjpwsDHFyxvRCU+2Fch5iUy85444HThkCFIw6eZx/xgysqoly/?=
 =?us-ascii?Q?S1d+1cmiGRm86+w7Xc0iC5BvAP/AI2A2wsllZdxaFXODv0HGRgnBN8lC/q0A?=
 =?us-ascii?Q?DAirTAPFe9U06ABTPr34dkkVXWwo2zrWtNK2uBtdksqsa2mEsOAe+zd6uOis?=
 =?us-ascii?Q?q27lKxGCzM7AAOimYaCAVZLMAG+eF94JseqKUm6NuxxOMhoYboTTKjICRukZ?=
 =?us-ascii?Q?YRfbsLHWXC+NCOZ+oX9BUfpEkMPbeBimun14UAmn8nH7dZ/RiGfAYUu1M6sT?=
 =?us-ascii?Q?x5qHuOCkVDoR0aXR5z+zYSPKzDPoDi+ZlBGabJcXVPFGLNGgtLnIp2zdAJOa?=
 =?us-ascii?Q?ocFuidzqawM2eVv3zHtOiYynEl/XlFAg49GLetQRCadCAcDDDaLwZ8L3WkX/?=
 =?us-ascii?Q?GdzyoO2phxPmsYj0NFCc82l+d7CQYlzHr/CMtE27QKaVjYKKZHIVZwOxK911?=
 =?us-ascii?Q?YNFn7tXcFvNp0opaEver6SrDzYNccjN2VeSVXRhdeCQ9GjgVBGnO0GhDTpG+?=
 =?us-ascii?Q?yTczX0cdBGiYIeJcbb800G3wEoLaQSCDqlZtzzsbVm4lSHSD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6121.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d579d568-40d4-4b31-97a4-08de7dff10b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 17:12:38.3306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ncrTFZLdXFNyXbcyENwk7ZAXBwcohqpr+ISawOHiQgQxwjDbC1s03HWt1GTPV1+fTl6dam5nW8rPnRBCEaOdiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
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

Hi Alex,

I updated the patch that skips KIQ ring access during reset to fix the issu=
e. Please help review, thanks!

Regards,
Chenglei

-----Original Message-----
From: Xie, Chenglei <Chenglei.Xie@amd.com>
Sent: Monday, March 9, 2026 1:10 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.c=
om>; amd-gfx@lists.freedesktop.org; Xie, Chenglei <Chenglei.Xie@amd.com>
Subject: [PATCH v2] drm/amdgpu: Avoid KIQ ring access during GPU reset to f=
ix fence timeout

After GPU reset, the hardware queue is cleared and all pending fences are l=
ost, but the fence writeback memory stays stale. If the driver keeps submit=
ting to the KIQ ring during reset (e.g. HDP flush), sync_seq advances while=
 writeback does not, so amdgpu_fence_emit_polling() waits for lost fences a=
nd hits -ETIMEDOUT, blocking further KIQ use.

Fix this by skipping KIQ ring use when in reset.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I717df52ed0ef0bb51a6901f218191d9837a77f6f
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++++  drivers/gpu/drm/a=
md/amdgpu/amdgpu_gmc.c |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index cab3196a87fb1..0021e763b753a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1124,6 +1124,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, =
uint32_t reg, uint32_t xcc_
        if (adev->mes.ring[0].sched.ready)
                return amdgpu_mes_rreg(adev, reg, xcc_id);

+       if (amdgpu_in_reset(adev))
+               return ~0;
+
        BUG_ON(!ring->funcs->emit_rreg);

        spin_lock_irqsave(&kiq->ring_lock, flags); @@ -1202,6 +1205,9 @@ vo=
id amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, ui=
nt3
                return;
        }

+       if (amdgpu_in_reset(adev))
+               return;
+
        spin_lock_irqsave(&kiq->ring_lock, flags);
        r =3D amdgpu_ring_alloc(ring, 32);
        if (r)
@@ -1298,6 +1304,10 @@ int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev)
        if (adev->enable_mes_kiq && adev->mes.ring[0].sched.ready)
                return amdgpu_mes_hdp_flush(adev);

+       /* Avoid KIQ ring access during reset; caller will use amdgpu_hdp_f=
lush fallback */
+       if (amdgpu_in_reset(adev))
+               return -EBUSY;
+
        if (!ring->funcs->emit_hdp_flush) {
                return -EOPNOTSUPP;
        }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 20e1395b39882..f9db2b17105b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -876,6 +876,9 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_dev=
ice *adev,
                return;
        }

+       if (amdgpu_in_reset(adev))
+               return;
+
        spin_lock_irqsave(&kiq->ring_lock, flags);
        amdgpu_ring_alloc(ring, 32);
        amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
--
2.34.1

