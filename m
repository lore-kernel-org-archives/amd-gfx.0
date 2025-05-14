Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2216C3ABD9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 10:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62F5E10E60A;
	Wed, 14 May 2025 10:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fuksIcgi";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A3D10E60A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 10:07:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQE1ihMpCqc3xNz6fcbIhYxJE0/2xJIY5GoLzfCWxetYlYNUaUua/smulIr+ys5y0erMKW+fJ+HdhDuWc61cfG9TMSJBdeApucFIpgPuZxRHChGePB65E3Jji7M3sQ8GWzLBmeLMsSP3xrcLXnPWsemvIY121oAW7DkFTbaLnkPn/kssNCUpp6f6o5qB7TZ5dafmSla1hS8SrHXGKdk3Dn44VHk8TuF2oYWthQ8Pg+ER8H6a/+9x3kqR2JrMRls94msjQRJ7OiuvGnXwqVHaCFoNSOtsXYjha7nHOkqQjRedRBu77CHaxnXgNE6gQ/YHxpkOv231gf6LELjPUJyv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvQKFaHZD+0yKFQZEEaLN+ujVx8mqEIMOOToNIdmMQQ=;
 b=mlImNTANZoQHblnSvBlXmHOQRLza23NcNHNSXQveSQIi0ivteJLklCYuLdV5Wr3XJ96x/EWz7czd1+ze7rKDERbm7Sg6oCKX0gA6r9ix0G3uD+8p5K/52102gyOFRMUaHWMipCHH0iLa0QrqWhF1sVW2hiUw22wONRZoCnmg8nhUdqTtDuTVRfkqyL1s8mHXMgByDonSY2qQ7cslt4TyqdaQIdnWZF6UAU/L6X+C13e/vKcOpzvnRE/OFIJB7rvsXe2xT+bH5loJs8cOulreLvyo+z6+f3KoQjXHgSk9vIaQtDa55Tt/e82mDxI04at12K4h7Oj6y+d8EfN+USNnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvQKFaHZD+0yKFQZEEaLN+ujVx8mqEIMOOToNIdmMQQ=;
 b=fuksIcgi08W758CwSRzg4RSE/oG5pFqy/8tWB8+9cpf+DCHzB0Nf4nw+R6y8+xfPGs/ASt4tJPwASFTrSydg4cXGVC5PCO7fJjzh7+zvJt6WT7E1uBmdISR6ZS4ZTOQeGzfDuTO8nl+pqI2aDj88Y/zeOA5NRGjTjzEYAYsxLe4=
Received: from IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 10:07:41 +0000
Received: from IA1PR12MB8405.namprd12.prod.outlook.com
 ([fe80::2b09:e2:1ee1:5fea]) by IA1PR12MB8405.namprd12.prod.outlook.com
 ([fe80::2b09:e2:1ee1:5fea%7]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 10:07:41 +0000
From: "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, GuoQing (Sam)"
 <GuoQing.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>
Subject: RE: [PATCH v5 0/4] enable xgmi node migration support for hibernate
 on SRIOV.
Thread-Topic: [PATCH v5 0/4] enable xgmi node migration support for hibernate
 on SRIOV.
Thread-Index: AQHbwwj/X3wS422xO0yjnZHuHlpX5LPR6VVg
Date: Wed, 14 May 2025 10:07:41 +0000
Message-ID: <IA1PR12MB84051BD5EE2F63AB227C6F01A891A@IA1PR12MB8405.namprd12.prod.outlook.com>
References: <20250512064141.387079-1-guoqing.zhang@amd.com>
In-Reply-To: <20250512064141.387079-1-guoqing.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com,Lijo.Lazar@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=06e58feb-d9b9-4ada-ae43-97c3ce0d3712;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-14T10:05:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8405:EE_|MW3PR12MB4428:EE_
x-ms-office365-filtering-correlation-id: 7687f75c-2266-4af8-6993-08dd92cf29c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?csvunhioV8uij6Zr24mVbqgtVGQYMoCkCxIXMIoq+zf3VyQDpHBDecwdnv7D?=
 =?us-ascii?Q?w94MW+skPO+60ozPqZ+tL4THBp5KjMNxXr+poVZnY1R9Id/OtTeAjNt+I2K7?=
 =?us-ascii?Q?ZjTjmUQygu2yTmwp8MeMeAng++5MK0q0uPmfBG4+q+7xskOHaKCO6ZHAkYCH?=
 =?us-ascii?Q?XpkSxnC9VBrHiTZuydBRHxqFZGG672Jd0n5/Hs8rWqyHtD1utcbzlZ/dlxhK?=
 =?us-ascii?Q?4QcAamh7n/Lf29IZPhCg8w03gIk/G5nPgWK848VK6gEk2A1OECOFfQA6gDAh?=
 =?us-ascii?Q?Dve2MjN8jxb/MRNLVonylTILSBiFIV7/nc/BM8lTLw1TAD8p89LkvdR5B4kn?=
 =?us-ascii?Q?Uc+8soP3L5iiTrmefL6La4kMtumiX5LgPL+YMDcMa3x7RmrNc7Ug8+Hk1jWG?=
 =?us-ascii?Q?wlaVihmWB9pFnGTGWCNZH4KScwsYUcBqr3YxIvq4vGPHBztjsqZWvHqWxJAO?=
 =?us-ascii?Q?Qf0eJyCrplhYaFPWUmLKfNnjQBe5nk6gyMfhAI6Qd3L9+E6/XqGRs27K6dnt?=
 =?us-ascii?Q?It3dlcIWnflNbyZrnl7zcR3feizEW4IuxIotRFMRPKh0sbeopaMpI58ywFMr?=
 =?us-ascii?Q?hdqc8TqkH5c0fHTuDAWfYbdkSn4n3YdV3Ni9+wNzz8TxAswOmxJUjuKO1/Ep?=
 =?us-ascii?Q?Z7SvkAa2eCBnJFqnOfFhdqOKESP9QWlPUGTvl/YKASHR0Hmade2mEk7ZWSk+?=
 =?us-ascii?Q?EakdjOHBTBdH8tYNg4cS+OKbtzq3E9y5rmHCjKxoMs4y0iezsEGjLVHUJqhO?=
 =?us-ascii?Q?af7XmU8I9GT0lUW4FyEpl3PPrnX8GWwP7ZAS652zdCJ5qXpPooAaR5KGSdld?=
 =?us-ascii?Q?DiG/fpbO2ojRGJxmLAvRpZuw+IW55ef0MeKw6ULEaUTxlC4tz2aWhIKbmWLU?=
 =?us-ascii?Q?8ynn5Q2a3FB3Y8ifm19IDEAR+ZLkyqCmkRn0sP328/vlCpFtSDq9nWfOyZJn?=
 =?us-ascii?Q?oEzvvSlODbKqrvkmVP1eLJFBJl+mbmlyfh0ISU1SGDydC0XVGptRl3pPJgmy?=
 =?us-ascii?Q?/4ID5BYLHH9lntfbxbbimepUhniV304D6MHz2q+GLYPwW6P0oVut6u6U0Rc5?=
 =?us-ascii?Q?zyw+zfGlLV8cp1F7FStAw20lW+F+ArSUsZwjxJcEqtGpEKQhHQAKcf1BYTbj?=
 =?us-ascii?Q?arJBEvh0p/8cMWmXtjEA37s0JkKjDcSO2TgU2Wz1tMr2uJcKIK84PZeeqFGc?=
 =?us-ascii?Q?YxcNYtXSABQ59z+vSO/CDYlae8eD/yNl7XTN175u8tmJ2x/+KS90oq5giR7k?=
 =?us-ascii?Q?BHqap/mmmYnb6bcxcILDMa58QwCUTKEysQxuMtOzGTOoJ7gmrcGfZA8WxzYi?=
 =?us-ascii?Q?zDCnvOVQ9AFbew0fAlIsZV6Dy4YOPTeKSlPkTYguBg07M/Jb3daznE/aAMpD?=
 =?us-ascii?Q?XBz1couvX5qELyanfGnbOJaduDmY1k/85r1WqqzeL0RjUuuDgc26DgdxRXON?=
 =?us-ascii?Q?+JXYO+vs+zbD++dsYnXCuaXpb/aBYpR7gHV2Tdpqtmzan96Szi6jsQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8405.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nJMGS5TkxTDEcU132MMP8np9pIYu28Vw+F/rNcVdmiGIsnu8dPFkCifpcBJZ?=
 =?us-ascii?Q?hgKOt03yiteo7iMvTfPglJLYTXeSccLp9DET2GwztCkypmTaYMQwXTscUG6s?=
 =?us-ascii?Q?5cE3b/wpOOXhARkZm/tla7y52ujGmXs+JA5wx7SUcL96uB4TvtQ1bqHFE/+d?=
 =?us-ascii?Q?XrCPJqMLS8zGPWVLuc3kqpNcqHWCC/0v//HGFUPrrCwPhnaw5sFSSsJ7M5Rs?=
 =?us-ascii?Q?8DZLVbu+b9waSK59O+hkDd9mc5rC55GArp2uHtjTInUBbBz4LN0ZaQv259fP?=
 =?us-ascii?Q?Be/QLm76KugnHQqkCVcufscUQo6YX0SKOjMXRypLpFLpat8LvxMcWIRJGWrz?=
 =?us-ascii?Q?b8RXCHMBqJGUMhRSuYnWGEGP1mAPYZjrHZbSJormyroK8Gsk93RBi33BRMZz?=
 =?us-ascii?Q?bWkFNe7j6piAsyyKS0td23QF3xbeel7j6NXpOHQTlVB9EUf+397aIR303WzB?=
 =?us-ascii?Q?B1gUtBsYeSieWp/qFyVmJcKej0T4ZI3ubljz1yFwtbB8NKRIchzPpr1MoP25?=
 =?us-ascii?Q?GD/V52+kWLnUYdXb44A1PuVjSyOwkTo9U44pIk6yl3qZfYD4M1XOE7ACRsmp?=
 =?us-ascii?Q?Pez1TkxIuNzRJS7XcRoXWlX8m4QzYapcTYBLUNryeV2qNti4ddBPPxYCCxWh?=
 =?us-ascii?Q?WeZ/BZYmVYVC4Bm0Z++ZwXZ1WlijaDOUoFBUwPOkBmdOSQe7vkylrjn0sV+N?=
 =?us-ascii?Q?Gw64VqzvogIZ9ZGmkkx/Q7JFwb7/1gUSZhWywB4WpX/5vicZyoYg2rJQHfLo?=
 =?us-ascii?Q?54FiYMe0Am3lmRSO0Oxtwo0GhISG+MEJjEduKDznh0d5qF5v6Z3Z6Ta7XleN?=
 =?us-ascii?Q?2W5kuAD7SoxdDmIKhUPq1ahJ6n0mDmVpuWab+dIlNfuyPEQ6Yy/ZAH5ZLItd?=
 =?us-ascii?Q?53pNRVImSQSYzxvmw6Pa0CZEExpjCkD7V6gfZDvJUxmxL9rEHqltux2sJuas?=
 =?us-ascii?Q?6U9o75dVZUkVSlygxJyLx9PiJWYhefDCG6VYxL5T/rxVCB0v6a+M2LzeABFW?=
 =?us-ascii?Q?jS5C6My7JPvffeGgkgGH9r9GEa+riToLirjT4xzccwCdpPM6NxRC7xhCG5bf?=
 =?us-ascii?Q?mEJSG54bxejDxPAMQuRHXr1BquVnMFL2nchZvHM/a9uFUwh72L+JJkfPpynU?=
 =?us-ascii?Q?awFxBvyCBtX9D9rerO8Q2L6Qrn6cZxGK/FFThXovlHJ6bLmEld8gWtdjwjma?=
 =?us-ascii?Q?JbpnzmGm5STu9zf8yMGiIY6fCv+o32tp/6ItYs5ZHlba0JN5NqekLUQ+OfqI?=
 =?us-ascii?Q?Y9viocvRBo0ga9P8DaECt6PCh3PFNCuQVIjHoXL7fcKB+zODTzUCkxpBboQp?=
 =?us-ascii?Q?UHEVvshcU+keeWMiDtwfDxx+6nlHJFquYaCuWu8aJbHkUuQ84nH0ki0r9geG?=
 =?us-ascii?Q?qa/6dT4jVg4YVncL0VYP/y4EhfD7c7ij52hs/Ox8Cytb1z5Xdi7SOTQwCcgd?=
 =?us-ascii?Q?d1IjsyoMPbMlgJITtlTCV6Qy8xzOU8zWYdruuR9/qC8DbcNWv+F8DGZcRKRs?=
 =?us-ascii?Q?g9u070whYGc53PeW0tF/45YMmXt1XXsnXT6AQx5ZLve5PgJZXTRUugxmLBTL?=
 =?us-ascii?Q?cr54nnSs9gmvR7sS0pI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7687f75c-2266-4af8-6993-08dd92cf29c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 10:07:41.2787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bo6GCVrDcu4a64Tz8nfvqBgfGY8DzzbAAKgEkvo8YVPf/cJIjI2uLHxiotmNoWQi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428
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

Hi, @Koenig, Christian @Lazar, Lijo kindly pls provide your expertise for t=
he Sam's update below. Thanks for your support.


Rgds/Owen

-----Original Message-----
From: Samuel Zhang <guoqing.zhang@amd.com>
Sent: Monday, May 12, 2025 2:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhao, Victor <Victor.Zhao@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com=
>; Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>; Koenig, Christian <Christi=
an.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, =
Owen(SRDC) <Owen.Zhang2@amd.com>; Ma, Qing (Mark) <Qing.Ma@amd.com>
Subject: [PATCH v5 0/4] enable xgmi node migration support for hibernate on=
 SRIOV.

On SRIOV and VM environment, customer may need to switch to new vGPU indexe=
s after hibernate and then resume the VM. For GPUs with XGMI, `vram_start` =
will change in this case, the FB aperture gpu address of VRAM BOs will also=
 change.
These gpu addresses need to be updated when resume. But these addresses are=
 all over the KMD codebase, updating each of them is error-prone and not ac=
ceptable.

The solution is to use pdb0 page table to cover both vram and gart memory a=
nd use pdb0 virtual gpu address instead. When gpu indexes change, the virtu=
al gpu address won't change.

For psp and smu, pdb0's gpu address does not work, so the original FB apert=
ure gpu address is used instead. They need to be updated when resume with c=
hanged vGPUs.

v2:
- remove physical_node_id_changed
- set vram_start to 0 to switch cached gpu addr to gart aperture
- cleanup pdb0 patch
v3:
- remove gmc_v9_0_init_sw_mem_ranges() call
- remove vram_offset memeber
- add 4 refactoring patch to remove cached gpu addr
- cleanup pdb0 patch
v4:
- remove gmc_v9_0_mc_init() call and `refresh` update.
- do not set `fb_start` in mmhub_v1_8_get_fb_location() when pdb0 enabled.
v5:
- add amdgpu_virt_xgmi_migrate_enabled() check
- move vram_base_offset update to pdb0 patch
- remove 4 refactoring patches to remove cached gpu addr
- add patch to fix IH not working issue when resume with new VF

Samuel Zhang (4):
  drm/amdgpu: update xgmi info on resume
  drm/amdgpu: update GPU addresses for SMU and PSP
  drm/amdgpu: enable pdb0 for hibernation on SRIOV
  drm/amdgpu: fix fence fallback timer expired error

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 32 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 ++++++++++++++  drivers/gp=
u/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 27 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  7 +++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 16 ++++++++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c     |  4 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 18 ++++++++++++
 15 files changed, 152 insertions(+), 15 deletions(-)

--
2.43.5

