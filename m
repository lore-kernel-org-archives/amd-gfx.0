Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49839C25B78
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 05:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6559210E3F0;
	Wed, 22 May 2024 05:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JtQ7rOnx";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E75DD10E3F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 05:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFpVc2zdbxGg8hS3EuKpulG8Kw5CWTGzQUZpz1ShCG0FqyEhZ40gYnQegnpO7xPBf1kUmY5vLWiGisx84bwefeTVWnFS9b8sScutm9xZ0nA/5zIZnWFFP927riYxLsARgmoGjPRILxHhbwC7pTZ361djUzbFNK23A52ZAnbrxia9xZn53CnhNCwp2TeyNbmh2BJAio/lGv0ICxtnCmrTILwrCrIGD1iXUVZWPTO7+yrMgbhIuaOLhSYjuOjuPApgZUQ3QE4zf1eDTRYN6lFG85W27TmOGAIRx8UuHaZ4amYtssQOR0SXe+PhGapEo8No3D8YV41uSUHXCbLn5QY39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oytnjj1CKPFXbzAVl7gQTrnSLicK5RF4V+9wGS2uD5Y=;
 b=SoxOynt18U54gjy2fx755fugbYFh2zisBGtOojpOlL8ubUgOn0iF66edTNFpxIOgJH8j0kOKUIzvOWwMDSPLkbssDuCK9ubE9E+eFN2cpoJHsp0+akIqDhGOvkpKzzflhrDczn4i75gkTxiHM2b9+ipmzZaFN8EQ/npnRunL1WneV7G7uO8dyaESBOus+pS0uqabq80YB6Gfuwfju7Juqthp++7D1weDdYCFCLLB0ucMi5deaWgxhxtixYOmPMZt1tRf63a/6NyHrY5tVco+Eq4bamwioSppV9/R1fzlKcNltORUz5Tt4ANzvFK1VhJtUA+gabTp5SW7ofwZ/NhfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oytnjj1CKPFXbzAVl7gQTrnSLicK5RF4V+9wGS2uD5Y=;
 b=JtQ7rOnxJUh0jjHXfKdfK1OD3sAcOWsi+tQw7JSsAYph1s3oTyscBRj42hsVgR7txvX0Wi5fyslFVldwo0nK0/llZwdSZjYFGMLYNwcODZ3CKprYKxNLkzlO26gX7SU8KPrt4Zcm/yHUoYndMHY0XRXsO1opgL1ure3AD3mqESY=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 05:43:29 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::bcdd:c459:3f9:5bb4]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::bcdd:c459:3f9:5bb4%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 05:43:29 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: fix the inst passed to
 amdgpu_virt_rlcg_reg_rw
Thread-Topic: [PATCH] drm/amd/amdgpu: fix the inst passed to
 amdgpu_virt_rlcg_reg_rw
Thread-Index: AQHaqs/t00H+XKN/50S/NdMMtJYKOrGiwBvA
Date: Wed, 22 May 2024 05:43:28 +0000
Message-ID: <DM6PR12MB43409CC6639FE333B7E424D0FAEB2@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20240520160757.2557051-1-Victor.Zhao@amd.com>
In-Reply-To: <20240520160757.2557051-1-Victor.Zhao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-Mentions: Lijo.Lazar@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a08673dc-bbc2-44c5-9a91-fa39bc6284db;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-22T05:42:42Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4340:EE_|BL3PR12MB6595:EE_
x-ms-office365-filtering-correlation-id: 85eb66e0-65c0-46a2-848e-08dc7a221ba5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?cZzWMuhG9ZZAEe562A2PtpSnqKEePUkzL071xMcXQoVhTg+vdeeUsHQ6Yj0c?=
 =?us-ascii?Q?DN60tlKXTLrGwGygHhcvsZ5CQE1H6pZFL0bpgfDeU7NvdX1AlpMfOzz5hmPA?=
 =?us-ascii?Q?I2xaC5/CpCWOw66CnSHUNKv4D054MUSt5YIVgJTPhtC0hljrkqGU+1f6pNMj?=
 =?us-ascii?Q?qnFTPsST5DRNNA8SZxNxw/ideEXVm332U5ypDVMLk4GzpH4v0EbqGLUu37Zk?=
 =?us-ascii?Q?kOTSPUABtHbw/0zh13C9IA+xvJ3lu1VA/Q5edVz3ZEavl90GbRT1ejsR+D6B?=
 =?us-ascii?Q?xFJxTuaWjHzgiz/es5lJvdn3r64xUtYy74q5Yb8yt8j8oQysYGmf8qT9qjo7?=
 =?us-ascii?Q?mjQbcOBUCSGxYhl1ftxsR7nyxoyldjBt9YvfQJAkMtkKbM2/KzPoHGrShClF?=
 =?us-ascii?Q?wn3dCmYFsJFd0R10lgHjA+5pRY6a5xRVBVZm4NitfKOoLlZJEIJjMeKrWI6A?=
 =?us-ascii?Q?A/BGv41ckwga2gVWTzD315cHpF6Gs6V3vkx6WmW8zM6XY1u1vKC6jgmMt7zj?=
 =?us-ascii?Q?B3vMcMN1CxTbETXUylW8Qaa8r1t8eE+JWF1H1Kf5aZUJ/UuOuLppkYZAfDrq?=
 =?us-ascii?Q?B2hw2h7uyKD4cUInSdwNU0SQ49/joGQAdqvOG6vfDD3/A8q6oRRT+WbxY1rw?=
 =?us-ascii?Q?O9ZJBFJPWKJEHFetb0siLI8sX4zCLyafOrYxgg4G7uoap+/O1MqMXkIglr2a?=
 =?us-ascii?Q?Qr9p79rUH0C9qSDNvWOYZn3KTuCAAS0v8H+5k1NI4pdT/fCzXZW2gtdZwe+c?=
 =?us-ascii?Q?RntFdKGo986Ni+Z3ArdgLfg/kNCygIvQhvGYf8H/hIobtdllnLUjHeIdeteP?=
 =?us-ascii?Q?Y9gfnnpry3WjZ65KQgV2ykb/Ky0FCUJYoYjo/XSakzPSzlb5dKvoDGdgMWRu?=
 =?us-ascii?Q?x9LgQGuPnq0xzLkCY9M69r9ljBb3UzTHCxJuX1Q5xbp+OLnBC+5MKOOrGzzy?=
 =?us-ascii?Q?dgmVNYdyp/ybPkc2P2c2fXmJe3tlJ5tK1njKtYeV4u9LLXhrWuFe19heNcTT?=
 =?us-ascii?Q?EAmvO0Xc6Bj6ENWg90p7P4gxm+L4VkKe52YScDAX96yJa/0FUmB44AfZNsYZ?=
 =?us-ascii?Q?6PGCyKeCaJ9pxjC0VaSafZpbWXTlFrE1brkiBs9Xr/DL377rk+fZ54hsZyhY?=
 =?us-ascii?Q?ARbS/bgWcDl+MwNLAdRgGp8IWBnecgFB0PDhppIUOZyqwIkj1LRTdZxALWMf?=
 =?us-ascii?Q?1sJakPHckWPOSpwfG7OaRiCxEMsYDecB4P6HzwPhcj7DqV0yFmWfQK9jitaa?=
 =?us-ascii?Q?6CFkhrm+lk7+yq0pGxgplVlo2s1IH5xNe8JD20OdJiKfxJFRBYtfEPiNy+31?=
 =?us-ascii?Q?+mAvwvOjqylaIhK9dFQEbRMrhdm3zM1sBrbeROCbPkKZxw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iU7r4A3ivaH/woautqa7JC6xQtmZIl7MFhjc59DOOeQk3L5NWtd/bHEblFxD?=
 =?us-ascii?Q?MjGqYpws9DzUQW64WQK7OvOVvP2EV+8gQd9yu4a9mDMZi7TF3oH45e4EX5xG?=
 =?us-ascii?Q?UFblqtp/dmR1rrwqFwQ7BCVU4YT42YD4FN/SwY1SCuFwAI6Oep9cZgeCV16K?=
 =?us-ascii?Q?+YPXqX50KDb8HGhH1odGWihR2HwzUghSTFNsHYOZ57SRjHxPwmWfWu5dAgcL?=
 =?us-ascii?Q?1GcOBEDYE8Zah+CkPlQjRj0VunY+G/cTKe2FJ7hHLn37XF6BV6Pd+J3F3tO9?=
 =?us-ascii?Q?6GC4rLLMqGCv02bOl/4OF4gwXrTxa4EawvKwZDFac1/zyRipdCsNnhh7/pMB?=
 =?us-ascii?Q?Uu7q+xxKwNgRWTY2GicG2kf17flBCojJC+RqU4XM8MXLk4kHZp++vWZmyZ3T?=
 =?us-ascii?Q?NLtbHKCyiCA39XivQsc8puBzGXoytoQQeFJ7/duFmbrlfY66H3E5ty4PKbYn?=
 =?us-ascii?Q?5DmO/Mwu0oML4+TR7qvJC7qwz7Jj7CH+lG25y63Qq8SnaCiYvYuUYCUc1/+O?=
 =?us-ascii?Q?EJJ+voRVsnGp5sE8VqcWVRz7fcnIOCkJMPdF/7pFjEIR08Yjoq/cyz9FS+Mh?=
 =?us-ascii?Q?L2p7hv1DYRaZwrCz6sCk8iBTvd9CPNnjgyobemv7kkUIx2ofxdEshd17xZY3?=
 =?us-ascii?Q?QXhQ7CBQlnNCrPuA4JQyZE6tXrbFTYiQ8/w0c8A5J7TbHA13i8IG1EhHleCz?=
 =?us-ascii?Q?ELlklJxUOxZ5xBtzXIX0dxBd8wJRt8o1p3EMEa27z8Dp1L3uza+ftp8blPb6?=
 =?us-ascii?Q?K2XScqTa7lB1yBFZXRCq2WpQWMvU5B1ioRHoep0bAn7byEd2vk+3dBP7oekm?=
 =?us-ascii?Q?3Kc1sVcnZ4Gtq5WFJ5WyX00pSsobzDWwhQBbXvYOaxZGSNXzZVSVVpM871w+?=
 =?us-ascii?Q?E4LfZ/HqfP69Oi90kU+G3qDSHJTegWC/Tgv+LWo1RmNwSJlY0hWIOYwoeFD3?=
 =?us-ascii?Q?EPsh2BdOcBXRiEB+qzhDzKRX0HSpEFrb3bf+s3u7eklLuou3601AUm+T7CyU?=
 =?us-ascii?Q?x0fpUlFNHeALt7NlsqjkTs9cyQK4EkzMSuwOemigPSi5WBHduNTM7bb2fSGz?=
 =?us-ascii?Q?XJjJZPPgdwTUW+YKwuvo/cyHTazjXty678bPTm8yHivfPb76sG6qvZY4ePDG?=
 =?us-ascii?Q?3k/g1KXqnUSkT57bOu3F3Bjgq31iuFiEiqjKRY8g7knBe4lwMBM1m9gS1kcf?=
 =?us-ascii?Q?bSvw1rvFIKaLL8xOJvfTWseVUdRYRJXB8ZR5mmL9xPTLc25JzjqDZJNn765s?=
 =?us-ascii?Q?/61S2vW0tA/3xRNy8HtYPpoAZ/eR6NdCc0Ri1pLg7/mn+RR7jHiLnsUzCO8k?=
 =?us-ascii?Q?88bUdW0iEdNKtzKZ5h4F2V3Ngnpeb1Nx40rmWsGCJiXlgBpVAD590CKRjvVp?=
 =?us-ascii?Q?i97qinb38/giG0CHNWzGbW0n6e02tyBZtBWgJ+vVM3tb534WAfbfIXgAh1Jk?=
 =?us-ascii?Q?uy8sb7tgjbkbU4Zbijh7nOLpuLjqLzAzDccCAZe7u0DCMwh6oSxPUfdhzKZA?=
 =?us-ascii?Q?20xSZEsMhEooD8lwJPRu4i1Nblb8dUE9RcNEtezWzvVzNimgZ3yS9+PVm9N6?=
 =?us-ascii?Q?9tF1dQGxC6iQT6btzAQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85eb66e0-65c0-46a2-848e-08dc7a221ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 05:43:29.0560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8XVjC4KQd1ffCyq0Z59Jy4MO/1etZkC1Qx68lispkLmCC5oOrC9RJlIl6C2y2+Ul
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595
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

Hi @Lazar, Lijo,

Can you help review this?

Thanks,
Victor

-----Original Message-----
From: Victor Zhao <Victor.Zhao@amd.com>
Sent: Tuesday, May 21, 2024 12:08 AM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amd/amdgpu: fix the inst passed to amdgpu_virt_rlcg_re=
g_rw

the inst passed to amdgpu_virt_rlcg_reg_rw should be physical instance.
Fix the miss matched code.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index e72e774d17e6..e74789691070 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -679,7 +679,7 @@ uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *a=
dev,
                    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
                                                         GC_HWIP, false,
                                                         &rlcg_flag)) {
-                       ret =3D amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_=
flag, xcc_id);
+                       ret =3D amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_=
flag, GET_INST(GC,
+xcc_id));
                } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
                    amdgpu_sriov_runtime(adev) &&
                    down_read_trylock(&adev->reset_domain->sem)) { @@ -810,=
7 +810,7 @@ void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
                    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
                                                         GC_HWIP, true,
                                                         &rlcg_flag)) {
-                       amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag, xc=
c_id);
+                       amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag, GE=
T_INST(GC,
+xcc_id));
                } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
                    amdgpu_sriov_runtime(adev) &&
                    down_read_trylock(&adev->reset_domain->sem)) { diff --g=
it a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc=
_v9_0.c
index 094c08cb98e7..350f6b6676f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -844,7 +844,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
        ack =3D hub->vm_inv_eng0_ack + hub->eng_distance * eng;

        if (vmhub >=3D AMDGPU_MMHUB0(0))
-               inst =3D GET_INST(GC, 0);
+               inst =3D 0;
        else
                inst =3D vmhub;

@@ -876,9 +876,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
                for (j =3D 0; j < adev->usec_timeout; j++) {
                        /* a read return value of 1 means semaphore acquire=
 */
                        if (vmhub >=3D AMDGPU_MMHUB0(0))
-                               tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, =
inst);
+                               tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, =
GET_INST(GC, inst));
                        else
-                               tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, sem, ins=
t);
+                               tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, sem, GET=
_INST(GC, inst));
                        if (tmp & 0x1)
                                break;
                        udelay(1);
@@ -889,9 +889,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
        }

        if (vmhub >=3D AMDGPU_MMHUB0(0))
-               WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, inst);
+               WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, GET_INST(GC, in=
st));
        else
-               WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, inst);
+               WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, GET_INST(GC, inst)=
);

        /*
         * Issue a dummy read to wait for the ACK register to @@ -904,9 +90=
4,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint3=
2_t vmid,

        for (j =3D 0; j < adev->usec_timeout; j++) {
                if (vmhub >=3D AMDGPU_MMHUB0(0))
-                       tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, inst);
+                       tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, GET_INST=
(GC, inst));
                else
-                       tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, ack, inst);
+                       tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, ack, GET_INST(GC=
, inst));
                if (tmp & (1 << vmid))
                        break;
                udelay(1);
@@ -919,9 +919,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
                 * write with 0 means semaphore release
                 */
                if (vmhub >=3D AMDGPU_MMHUB0(0))
-                       WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, inst);
+                       WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, GET_INST(GC, =
inst));
                else
-                       WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, inst);
+                       WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, GET_INST(GC, ins=
t));
        }

        spin_unlock(&adev->gmc.invalidate_lock);
--
2.34.1

