Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA68C25B78
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 07:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD47510F42D;
	Wed, 22 May 2024 07:41:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GUtJX1Jd";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A0B210F42D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 07:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoC2k8jofqkUVVTDfcTttTyGVPFXA62k7cQHwmSNrbqlZtQitUkgsiRyqCMkXXLEzfb2koDSad7JBjQrB9UfDcOTx0IUQUtZXlOWg8zTheplucmn8AdS0Z1RF3Z2ME/PxV0YnVv1UiOEtkdx23MTu7ZOQ3xH9uI94lYC+Oq/BcFwo9smhUmDAdE8Zh7zH3B6KfLWqCuPx5SEHau1U2SCgPLgctOv/O0yQnc9sr1mcSFrtON0AiB6mTIwsBs7Ac3OZ9HD1U1OnzPrjBnSXIIznxMB68KzSmu6nSnVNy6vo6dvnVsDryOFIUg+3WAZDRVQ5/dFz5YyFmHybGoavCWodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLU7sT9y+VhVWz57Bt9mWXrdosRoIj09dYPenz1HBFI=;
 b=oSky9w+qL2HOigr8UCwj2/h+Vuqc0fsYrifwfgCnTnNahgFbxcZoF1Eot7N89hNTbO9UB+RFG7+ESbVuuoGwtcOJA04YY9MmEAD4/x1gyei/8cJceEtO3escevp4onkKqqp6t876Mo6IDWzOWiBwJM47l8ydyM3OqbVDC9J6ZOIgH0Dzp9AbnbgEXb270um5UOzG9ooBQpTWrc/EvjzgwqdABYKIUThaqauoPg0bFCaWUwTVBzGt0GBDnnhPfoaT3TbM+h2jqR1PFYxkKR77omzfSrf1+02kx4GSKbRrsnlIkE1mg28FFagCKw21CsMIXdgkBUFqPsGvER7UdlkOVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLU7sT9y+VhVWz57Bt9mWXrdosRoIj09dYPenz1HBFI=;
 b=GUtJX1JdCr8XSp/syeqC2C2sAu4FuxPJ4kIaZgW+jTwpXhqyH4++O6ybcBZ+dJ8aHrGMJGzlLdBSRpjzteQC1OfohlludA7bjX02PQBMrXWdObRw88JpjkH/5JmtUZckaqkJyuhSjdDBqtQxKVaQgq8QY4rDPXFNFg7k8K88/5Q=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Wed, 22 May 2024 07:41:40 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::bcdd:c459:3f9:5bb4]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::bcdd:c459:3f9:5bb4%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 07:41:40 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: fix the inst passed to
 amdgpu_virt_rlcg_reg_rw
Thread-Topic: [PATCH] drm/amd/amdgpu: fix the inst passed to
 amdgpu_virt_rlcg_reg_rw
Thread-Index: AQHaqs/t00H+XKN/50S/NdMMtJYKOrGiwBvAgAAImgCAABVBwA==
Date: Wed, 22 May 2024 07:41:39 +0000
Message-ID: <DM6PR12MB43403D6DB0CE7536EFABB44BFAEB2@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20240520160757.2557051-1-Victor.Zhao@amd.com>
 <DM6PR12MB43409CC6639FE333B7E424D0FAEB2@DM6PR12MB4340.namprd12.prod.outlook.com>
 <DS0PR12MB7804346B9171556B29C8B9D097EB2@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB7804346B9171556B29C8B9D097EB2@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
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
x-ms-traffictypediagnostic: DM6PR12MB4340:EE_|CY5PR12MB6106:EE_
x-ms-office365-filtering-correlation-id: 0963a550-c4f5-4da3-2faa-08dc7a329e34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?3DGNbs/vNeKA2BPQYIbBosr3FHpyBa4/AHNLuUtfMROYQXVJoBKfoCA+2E68?=
 =?us-ascii?Q?bjZPYlYjT12kJjCGV4GGm31i0uQD2iBnGZQ5vYNczMTqwfpSGlL5z0sZpzaE?=
 =?us-ascii?Q?Bpdq2WjV9GZhVoLU0MadiRRYLSOjTsS29U3X0X4Xk96snASF1RKsHzzc6XkY?=
 =?us-ascii?Q?/4Nub/smNW709LYCK9MWBIasaJ3BgGXo7Rz7yYrKV6U8jTw/Id6j11HptOpE?=
 =?us-ascii?Q?sdgWsL/v0qVD9bphs7Ii6YgQqa+6R4naMdl+xZAsL25uVZA226PDCdO0xtuB?=
 =?us-ascii?Q?mbZDV6h6p1Sqzja+bSSzcYvEF9bM5y6S37Co/tvmb/M0FMr6DE7h1gujJaKV?=
 =?us-ascii?Q?/jeceSzJh9Rxgovh4R2r1lS2TV7VjjVh2WWmNWcj+wFwMaQZgsCbNThiz+Oa?=
 =?us-ascii?Q?U378hMXt160qznSETfWA3gv/xITvCYPX2Zug6YJTsP/3ZevDJ4ANJTHf9DzX?=
 =?us-ascii?Q?gI6Mj56KgSjVt4hbSJJ3IbNRR2ZjHm4B/Jxpo2+kdkn8OSuXSwdVMQNALN4b?=
 =?us-ascii?Q?Th0yf6V/j3xJGzHawoUdTuRiLrs8VSVgnyBqDGYQ8Dv9on5zah/T8K7vA6rh?=
 =?us-ascii?Q?1U2dwGJJYZ+WmWkW/4I6eS3ZuE4/Ey/afvlaFv7YdVMdvf+UoLuxU5/PHmbJ?=
 =?us-ascii?Q?CqPKNDXfPvW9Ft7LDL8MWyRLy0OstUfQNSZqhPFedpfnHwUrUcmB/w948ml5?=
 =?us-ascii?Q?aU1e2K2b4q6x7ozHWUfittxiJ9VCYrkr4rOIIhPVvH0qcsIU7c9zQTgoeYVc?=
 =?us-ascii?Q?FRVRMEHz9d4a9JILkZXTCWsKxCeRRaLefUkFv04kDgMvRsxJ16zPLRiWEJ9a?=
 =?us-ascii?Q?AYwl7AOspWQNaIyCKfIlIJWULmTvjKhMEdQ7uJE5Q6oCrK2Blp4CvaQP4KEi?=
 =?us-ascii?Q?sn4hbwXhQKQCd2vxvhGB4NJGf022gXXvL85KhJ3Lrp9S/5oXxNue/Mxbbr7F?=
 =?us-ascii?Q?Uc+bplSWglCkrMLfEm630uq1I/tu//3OO3n3b1PUZ9ImBNeRfNSnehZ1DhOW?=
 =?us-ascii?Q?uNpyPkXSuEMj2L5b1MYp8znhXDSB7s+ZyM1zg5mX57jU0SRO6xEJk8+gGrEx?=
 =?us-ascii?Q?T1nJtjCX22yMjpWAF5UkAxZuOWloldFU1tuYXH0w6aKEEjW7z5S/AWH5aBW0?=
 =?us-ascii?Q?31tz4sIeYkprNP/Ups8L+gwE1THpxFtNwZH3fp2BU0SpEFi06me0GEvUTPej?=
 =?us-ascii?Q?55/Cers7JYtfkXdstfuedfK1Unt/SnB+x8Lw9l3FmWuWwZD7nD9h4URfbMMR?=
 =?us-ascii?Q?mPsxD891HPYXUY2LsaAE+MyP5D423LiTCBqp2l5TycmG2aozUEJhQBilMBfp?=
 =?us-ascii?Q?KoX/FfIMj64OTq7d8qtUGM80JGFn7NXKPPToZukoccUufQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UMk99pAKSk0xTKSLbz7i9crBeGoiZp+wmrsm63YuPs28faGy7nsQDGYN0tX/?=
 =?us-ascii?Q?aVumpzgPzT9ivZokCMeSCTGlMwA0m28RXi9upu7hSwGqzANGBH/XztsiDFex?=
 =?us-ascii?Q?y7mdw80t/fmFlP/GEhya253YgH/g+4rAAqR30wQ4wreyoGcm61BAF+0VR1YX?=
 =?us-ascii?Q?Hj65yh97Xk1Ax4Mz5nYtAC59yYgY6s8BZcy6HlIqPsriAHsNy38WUGOoHLfG?=
 =?us-ascii?Q?I8b/XElnlpnpAYRN++k1LlqgDlw4s1E8dtmNb0FqbeGPeQjTCaClUq9v0rDb?=
 =?us-ascii?Q?mpkKMw1adHolJEBRDEFVa5gia4rxjJcNx6ln1iWbIra9iENEAWEoRhRp4F1a?=
 =?us-ascii?Q?YLzvyLzxqAKI4hAo0d/DbEZFcDpZO7xZWVIuwHJfRiiqntEVyQU6/Ve2OrdY?=
 =?us-ascii?Q?1GkBf7nFiBlNHrZnaWB6asF1R2m774s8P8vsnCi2C8CJVLjKPWzYJlAQH036?=
 =?us-ascii?Q?wTTbi2EhfWA8tb6roRgQFxUjwL/BKbDD97vGzQPuFSWNOhu2YGIvsoq/Xyvu?=
 =?us-ascii?Q?Y5k31nCbdmoQEqj95zMmMD7uckmw6ZYITyJO7wFAtp8OdR3ZPuylpOr6NdlZ?=
 =?us-ascii?Q?tYtTWNL/dqAqrJ5bdafbIWHV50otCpgOw/gghJO0zZMQ3EKXXDDefXfi4RQT?=
 =?us-ascii?Q?rp4Kct5oyjlT8FhPgW+iIJxki6MDO5Jsffd0CNhCUFN5CBZtkdL9cDY/Dmcx?=
 =?us-ascii?Q?et/6Xh0D48R5ZotKYEInk9JI+2b9f1D6YObdccWvdmHeW9A35Xzza8iKuuww?=
 =?us-ascii?Q?rlV6lsWFPsdUDD7Fw0X+tD4p92ZrlFSbrFxiKV28qHl7XY1FONBhIhqi8Qne?=
 =?us-ascii?Q?9EbXVN4YbDcSAYLGmzsna2Hh0Y7iPRwvvBH9S7qsOKDEgcKGaSybJhA/X4F+?=
 =?us-ascii?Q?+wL5eqGom0XrjEZjUv7wedxqMnl4r7K/53+3LqEvyQW9gCH3zH374NLpgf28?=
 =?us-ascii?Q?JsYfgEV4FnHo99CXkt+V+erFWimGiXZIBa+KG2LeJKqVrqqSU3O2sKltnUP2?=
 =?us-ascii?Q?9X2pcQUt/xrNb4CwYteDjFy2VKlrHA/TJYURgVK5GYph5RYiVZEQLFeV2OL+?=
 =?us-ascii?Q?IK23kg/iJeI/Rc8yRrsANZE1LvHbKjNGtumIlHZck3HRkNZ0gYWhbTl2ND3S?=
 =?us-ascii?Q?bQNkyDyzxrpM2+er0jk52g3xkJTGBuYO3MykfmVzbvAWZGD6DbTg6IzTMczt?=
 =?us-ascii?Q?2ucTujqIT9gkgb5vj1bWrvqD3bjNQxD7gjPUmLP9belYQ3uOr8xqAUtm3R48?=
 =?us-ascii?Q?tsXR36oQbS4GiFtbf+xIJajm37pfzquzB99FDJb+A4T1+iXIrbP8D+rqTN5F?=
 =?us-ascii?Q?HGPKgSzwfCCjudQUvjV8V2UuTPJcahEMoqv8Ue/nEVhOlnTQcDP0o96Up2hj?=
 =?us-ascii?Q?j2ZLcZUVbYRqcLUymQSS3yvd680vwEbg2Z3972h/tw/TTxpDgVxJ4b9M+oMj?=
 =?us-ascii?Q?t3ynlpPqURJPMPWHzHZPyXkN1BGGW6+SoOeXywnQSXGUcLQU8fnRA8Lrmwbc?=
 =?us-ascii?Q?WIL2aH4SwoxzDOUqBh2SXILBcTaLRTbVBvwF5jNiTsJkR9HcJ8zMl858uGAS?=
 =?us-ascii?Q?qXpg5nSAmcxusu06KwA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0963a550-c4f5-4da3-2faa-08dc7a329e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 07:41:40.0463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2cZ2o5EAIxJaZN5vk5zJ9Fi6ZKpTHLfIM+48Kpo9yUzRwi9ZcMCgEqp0WDl6GYS7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106
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

Hi Lijo,

This patch alone is not working.
Since in your approach amdgpu_virt_rlcg_reg_rw is taking logical xcc id, so=
 all the read/write calls need to be fixed with it.
For example, WREG32_SOC15_OFFSET. There will be bunch of places need to be =
fixed.

Thanks,
Victor

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, May 22, 2024 2:14 PM
To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amd/amdgpu: fix the inst passed to amdgpu_virt_rlc=
g_reg_rw

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Victor,

Could you check if an approach like the attached one helps?

Thanks,
Lijo
-----Original Message-----
From: Zhao, Victor <Victor.Zhao@amd.com>
Sent: Wednesday, May 22, 2024 11:13 AM
To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org; Laza=
r, Lijo <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: fix the inst passed to amdgpu_virt_rlc=
g_reg_rw

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
+                       ret =3D amdgpu_virt_rlcg_reg_rw(adev, reg, 0,
+rlcg_flag, GET_INST(GC, xcc_id));
                } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
                    amdgpu_sriov_runtime(adev) &&
                    down_read_trylock(&adev->reset_domain->sem)) { @@ -810,=
7 +810,7 @@ void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
                    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
                                                         GC_HWIP, true,
                                                         &rlcg_flag)) {
-                       amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag, xc=
c_id);
+                       amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag,
+GET_INST(GC, xcc_id));
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
+                               tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, sem,
+ GET_INST(GC, inst));
                        else
-                               tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, sem, ins=
t);
+                               tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, sem,
+ GET_INST(GC, inst));
                        if (tmp & 0x1)
                                break;
                        udelay(1);
@@ -889,9 +889,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
        }

        if (vmhub >=3D AMDGPU_MMHUB0(0))
-               WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, inst);
+               WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, GET_INST(GC,
+ inst));
        else
-               WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, inst);
+               WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, GET_INST(GC,
+ inst));

        /*
         * Issue a dummy read to wait for the ACK register to @@ -904,9 +90=
4,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint3=
2_t vmid,

        for (j =3D 0; j < adev->usec_timeout; j++) {
                if (vmhub >=3D AMDGPU_MMHUB0(0))
-                       tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, inst);
+                       tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, ack,
+ GET_INST(GC, inst));
                else
-                       tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, ack, inst);
+                       tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, ack,
+ GET_INST(GC, inst));
                if (tmp & (1 << vmid))
                        break;
                udelay(1);
@@ -919,9 +919,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
                 * write with 0 means semaphore release
                 */
                if (vmhub >=3D AMDGPU_MMHUB0(0))
-                       WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, inst);
+                       WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0,
+ GET_INST(GC, inst));
                else
-                       WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, inst);
+                       WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, GET_INST(GC,
+ inst));
        }

        spin_unlock(&adev->gmc.invalidate_lock);
--
2.34.1



