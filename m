Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F20C19776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 05:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 633D910EC04;
	Fri, 28 Feb 2025 05:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ghklwTYN";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FE4B10EC0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 05:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snBGxDEDWK7LyMEZmZsfKRj2pR73l3K1FNf8ry1AC/eLST5eKl+h6poZNWi5UfdceDGuv1gVn2vXCpIgDhXu2t9l9IfprmfdyiNJscYjbnA5r/yATRD8kDQnBCRZSd2kMfV517tL/F3yfKrzWx0PakgkIRYYpjxPMV2Q2jPtYMGNCd/funppv6L36Bjlf0+24feBJT7q6yXdGiZIeRMqSsfN9AUSa7YS7ODqjcyjb6Y+qB8jGMFiCW6T+zQf0wtIxBTlaUr8Dr+ETuT6c1U2vWkaK2JSi9/52XnuMUkWlwCEbROjS10FCZnmPQ9Na+7yvUw2aVnFtkez59VlrFqPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DszUon5VHtZUYc14+Jiocs2CgPu2kuF2f3gB2wqOI4=;
 b=V+34bw96M1xl4c5j2KeaUpBNrMSOhORS34joKe5wSUdUGSlmUazqu4ES6Yc5mKSF+QwEeJoNn5tIZ5X6Gvm9ABb0pRCNc9m5FKn6TM6S1Cgk1a3nUVngDhGuk9HGuQT7nOODXVbelGepX8HpdFrFt4EfQCrYwfZ942maMAtZoZb3lzS1uWZ30p8hSk9owUvViZuov42y+8/sbSpn0mc/8SHOK2NTmd+5mKAikFYkHEyn9ffi6nIZGcnz1VHFCS37MGrPZL0vboXEpEQQLHGsFu3YNnXdnI83ocmS+Scs29C/kbUOSKwHloElzA8fUWaNcXmegzTG9CYDpQ20FOkNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DszUon5VHtZUYc14+Jiocs2CgPu2kuF2f3gB2wqOI4=;
 b=ghklwTYNR9jDTb7qkaRsSJGH834WwWWrWAg/tCXUIRs9EgNfxbiAL572jYTjo8fynz9fDFWWMjqYQ14xfL1rQ93KTTd6SINspF85eHNb6Cz/YbgcNfBl5prfX6W2bSBVLSwLnMGLAUrm1LC/t5STfk75EHqxPG1EVLcLi1QoLhc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6db) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 05:43:05 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 05:43:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Use the right struct for VCN v5.0.1
Thread-Topic: [PATCH 1/2] drm/amdgpu: Use the right struct for VCN v5.0.1
Thread-Index: AQHbiCCgLNdq1nvgA0e8nYOyquqPF7NcNuLA
Date: Fri, 28 Feb 2025 05:43:05 +0000
Message-ID: <BN9PR12MB5257F168904B252DCBFD5D6AFCCC2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250226073132.142539-1-lijo.lazar@amd.com>
In-Reply-To: <20250226073132.142539-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3e7f52e0-4db5-4988-af8c-17bef160e028;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-28T05:42:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BN7PPF9C6E5285F:EE_
x-ms-office365-filtering-correlation-id: a5c427ef-64d3-4d7d-9cce-08dd57bac5dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?57jt9tK8e9B6V7ALD2XcJ9tjl4ExkjJpEjIUp9/SXSNK+1oGNKeeeBhXIyDa?=
 =?us-ascii?Q?AZhzDIVvWbICM9lky3EINabqmOjWKNVh46K3TZnI039o7aO539G2G9dcaJnU?=
 =?us-ascii?Q?mMH4VlBDV5UWky+TsoW4nELBqvkjtLD+fXJ4wj82Ef+1q+7KX/VukzNoDm/r?=
 =?us-ascii?Q?FVhLbwdmlDyGv1kDIYTvTlk2teUuqSiXesZHkWI6eCRX2gU7dGbGUYG4757n?=
 =?us-ascii?Q?E2FS2cQwRBFFhco2re9WLen+/7JfNDleMBQSsBiJqYjZmJHckW5MUasjSxV/?=
 =?us-ascii?Q?FaiXa8hWzE41QxfpP/3hekZDlOJPS+1FUugf8A8Za9bLRkMsVg3ZcUiN7DIW?=
 =?us-ascii?Q?HEIYUPZ3OaYTJiMUopJbqhv8zfqSf6ygUmtHd9vFhGPXw4XqjCwxvhJnICHI?=
 =?us-ascii?Q?t0HGXGc8dzNgf3WekxLY8/mKm9vXSgp8pQKuvb5pefcWuj81aqClXpaecXpm?=
 =?us-ascii?Q?avrTjtKpIMV/bvPfWJ7RNsbo+Q2/COTK4Fc6gevTKYSpF+2HmegTJzWsvpQP?=
 =?us-ascii?Q?5OfhRjk5ixv+Cv8DmbH7ABEhTKYahWV39h99HcylXMkbSvydtUja0xlHfp0H?=
 =?us-ascii?Q?pbupR5thF9nk1rvu3BqdzwBy3U9msh7NBGl9ChCj0n5XM5NoipcwgpcUXZzk?=
 =?us-ascii?Q?2dTibsgsrBcLa+pufBhGUY0ISUluXYvHvV8+5wTPrhq05+8Wbzq/a/iAXP/y?=
 =?us-ascii?Q?LhXavNpl3Xp0kIq5aVQKHXsbUTjXpmnhaC1DrjpAA/LSWRCWuJCDGPtBcb2u?=
 =?us-ascii?Q?iCmAlWd25RPkjQNHmwqMne9/TqcQXUnQY/JatTy5PbFpzFKyLZmCTplSUkbS?=
 =?us-ascii?Q?Q0GLS3Ab92ceAKVyLVpHjDuLrNXYA/YaU8RjSRHF7MiDTVTuB8k+wXruGJHC?=
 =?us-ascii?Q?hnsw1RT58wjSSMMjxtkBO5GoExMf1f+b9U+Ov4AclVSaqfZgVIVxpgn8TW/w?=
 =?us-ascii?Q?uHwURXdv9bLOAqwsMkQrN/h0wvk8YcL+IVQ4MiQKtZe95h3ZjHd9yqAOSwqb?=
 =?us-ascii?Q?phUWp9Vxs1+Cg5KxHbPcXp4kDT8BevmATXM0z79ckzy3Q8e/At3XFoQd6ZF4?=
 =?us-ascii?Q?S3iUm+Ae1/Dgv+kVlddeqZc5X5mQPFyGjOiA8hvofjc+R+4t56L9A2VFNFqT?=
 =?us-ascii?Q?CMckiqwaMczrhlFfnH9botTIlxKFtKIETVxcBb9IrwcSfUaR+2FCXTt/4gZq?=
 =?us-ascii?Q?MNatHY/lRIe+UNBjICeLQIBUd/I1JtxqrnXWfXflDvo9xIis2MtHyX4hdRPp?=
 =?us-ascii?Q?RbVQXRjCo3OaFZM7wN3ie8Zn10nIRxdqSC8s01LGJHghH1YIBkBzyu9HY8fi?=
 =?us-ascii?Q?VGk5SHuhuwYRISG4v5Cm0D6hGdz3ucJJ9Bfa6S+6w4ArBluL9lN4HPAdbbFp?=
 =?us-ascii?Q?AiMsFrRvI1dBlk9/iZpzgUaPEbjCXCwNMZLQhozXd74R5ToB9EdfstwD0RkI?=
 =?us-ascii?Q?1smA9Pzm4HotqzrxwiERmY+uq4z2VhAW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fPmj11vkF/JCnyizNhvlWbAzzprRT/m4JW/faaFeWNMJ2XbtAbJBs4qiQ+ff?=
 =?us-ascii?Q?S2+oPkr2d5a/HxPUY9ZBqfE188JMteP+AUXFcHL4tcbMQV5XJjdAzkt3YIBB?=
 =?us-ascii?Q?VIW7Ln3c4Ev6VQDn2VEFNE9jk/s03KnSFNODJGBeFHymVU3mG4/JMZb+PdKE?=
 =?us-ascii?Q?q6cBSB0yIkpVMpv4T+hdSKLZ4u/MSQkspyKXQOCEqkvxO0xqyGacwHEJCMF2?=
 =?us-ascii?Q?5X+TaAAHzoEI1QNiCRR6fQ69Bh5T39g6OQi4imWkX6qyZAGtbD6JhzZ3CSbe?=
 =?us-ascii?Q?2G50TuKlALODoaDqqHn2n4h3LLJ8+lVjhgMPhj4LKcrVDXF7QA4ryvMZbt4Y?=
 =?us-ascii?Q?set3tjPRs5iC3Mn4IyoG8UoibpbzcW4DBgajZbcOAVVAgyxjlolz5ui2dhQW?=
 =?us-ascii?Q?4IkBW+c5urKiI/rDfaY+qgGRRpq4EKweQT0FnOmBF7AELuM9moC9jJCyMG95?=
 =?us-ascii?Q?T+KwJ160HwavNiScEQyeVmB24fL8zaoWpQW1HkQ6ZcG0hok9X4ohyU2rG3b3?=
 =?us-ascii?Q?NEay8zM07YkC2WeUwwnx74864gMM9Kj7j3LXz4biLReGlHt7fNF+Pfbofoe7?=
 =?us-ascii?Q?mqt3MMR/N9hpWs9CJWD+XD9o8XkjISe6MNpjQt/Zdc81IxJ4MiN8HfA4/T25?=
 =?us-ascii?Q?u1ORZm6aWgY/Il+yNkfdyjcOuQwRKQKY8Lx+SEQ1IuzQ4PhBaCp0yunr/Rhu?=
 =?us-ascii?Q?zVcJpHlktMwHjz26x36Y95+5r+cpq6104NwO39tVQxbP92qcbwiFbxK6TlTN?=
 =?us-ascii?Q?sA9dNLnxGRlnDJ8LEvaL0EYsQrpJ+IeQ+UhaFUWpdXaUvbhGs/dhWZoc/4fA?=
 =?us-ascii?Q?sZAfLwRsnnGG0oJ4WbPXc8cqfiUvJ5nFAaSdNMoo3VUNaGZ8XofcrBjjiMgU?=
 =?us-ascii?Q?8LYaenrKDh2cUY56fjrf68kN9mRBQz46Cu9Kiqrn9af6xYbCqVYALM6LpkwS?=
 =?us-ascii?Q?4J4EB+eSioYgqWKnmJLmyUcBi1tBBaUqP2aNf1svqpkOpFe1QNHbnRXT+4bJ?=
 =?us-ascii?Q?dCFikQaxqMBlnQvdB7kml+S1uWKqNfnwt/ivNu3I/me9cyTpXku7mh/zxU4L?=
 =?us-ascii?Q?Hwnr4q5Ggr1E3wRpU2i4vsrOwx2xpeYoJ8qMPnhQkwtbtpv+2mkmpzMPBZig?=
 =?us-ascii?Q?bEJq/Dv1fSxdo4h1LRJrJK7e0U3Zg9+tCIirz+A8Yg4LaRka7aVgo/Psi1+j?=
 =?us-ascii?Q?Jfv9xi1h/r9X3YqcP1wm5f4S4lcqdGsuJzgZURRv4DuxqHWoxsK0VtJkF1/u?=
 =?us-ascii?Q?63/5QQp8WhlHpHN5wHthW1+secF3UwNOlW+MuK9t4MzeUhVu6ah9GozZaPjd?=
 =?us-ascii?Q?sCulnop96/uEY0JRmqvMhjsa5+8CJxMp7haM0Yk1ArijhCGhncBXE9AZGWxL?=
 =?us-ascii?Q?kZEncylloaXd1fpeGsG/Yc46pk2/KGbYu/iZcGxhGv5rElLQR/kjrbDIQIAJ?=
 =?us-ascii?Q?VOTKbdxg6U6QIQgOKAQ17roF8eaL7LTZFdd0wcgk70CUpay3TDqBFDm95aW/?=
 =?us-ascii?Q?MK3Y4tGps6WQZ5m3IIvQTeSmYozc9dfsGg7kgWT8xVg20+7J1ReZ3jVo5nhZ?=
 =?us-ascii?Q?jUxeH6j0iIJrTkEXUc7Kl+tIgJ+n81cGwMFMMbJt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c427ef-64d3-4d7d-9cce-08dd57bac5dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 05:43:05.1386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UI+4sWUyPs7FZs3dW34chwmuACB+Kp0VgW5s9+Xz0uu3NVE4EcBZBR5IPlGQOX1jToO3658GrVr2eAdWn9bsQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F
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

The series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, February 26, 2025 15:32
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.=
com>
Subject: [PATCH 1/2] drm/amdgpu: Use the right struct for VCN v5.0.1

VCN IP versions >=3D 5.0 uses VCN5 fw shared struct.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v5_0_1.c
index d29e8d685194..7ef83c9346e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -153,7 +153,7 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *i=
p_block)

        if (drm_dev_enter(adev_to_drm(adev), &idx)) {
                for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
-                       volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+                       volatile struct amdgpu_vcn5_fw_shared *fw_shared;

                        fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
                        fw_shared->present_flag_0 =3D 0;
@@ -341,7 +341,7 @@ static void vcn_v5_0_1_mc_resume(struct amdgpu_vcn_inst=
 *vinst)
                upper_32_bits(adev->vcn.inst[inst].fw_shared.gpu_addr));
        WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_NONCACHE_OFFSET0, 0);
        WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_NONCACHE_SIZE0,
-               AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared))=
);
+               AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared))=
);
 }

 /**
@@ -451,7 +451,7 @@ static void vcn_v5_0_1_mc_resume_dpg_mode(struct amdgpu=
_vcn_inst *vinst,
                VCN, 0, regUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
        WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
                VCN, 0, regUVD_VCPU_NONCACHE_SIZE0),
-               AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared))=
, 0, indirect);
+               AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared))=
, 0,
+indirect);

        /* VCN global tiling registers */
        WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET( @@ -493,7 +4=
93,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,=
  {
        struct amdgpu_device *adev =3D vinst->adev;
        int inst_idx =3D vinst->inst;
-       volatile struct amdgpu_vcn4_fw_shared *fw_shared =3D
+       volatile struct amdgpu_vcn5_fw_shared *fw_shared =3D
                adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
        struct amdgpu_ring *ring;
        int vcn_inst;
@@ -602,7 +602,7 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vin=
st)  {
        struct amdgpu_device *adev =3D vinst->adev;
        int i =3D vinst->inst;
-       volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+       volatile struct amdgpu_vcn5_fw_shared *fw_shared;
        struct amdgpu_ring *ring;
        uint32_t tmp;
        int j, k, r, vcn_inst;
@@ -780,7 +780,7 @@ static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vins=
t)  {
        struct amdgpu_device *adev =3D vinst->adev;
        int i =3D vinst->inst;
-       volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+       volatile struct amdgpu_vcn5_fw_shared *fw_shared;
        uint32_t tmp;
        int r =3D 0, vcn_inst;

--
2.25.1

