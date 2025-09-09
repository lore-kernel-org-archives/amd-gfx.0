Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216D2CA1016
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 03:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3B9E10E2B7;
	Tue,  9 Sep 2025 03:21:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eZHkps5t";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F9DC10E2B7
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 03:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiPd6y3WLbiGnsulo8RkodztYiOy2PPgVK15HxKVPy7CaXy28EWtTeQJuOjsMw7tRrlBF2AE+BjQnoses+NZv9XHRj+I548Na08+YKUVIeJgP5z8FZBknEI/Gs8soxMonAUceXWRNm7oIiUCD//iLvPyh7Eygf8eNzZkzUThQsTYlKsGvjk/uSYEOL6BiW5Wcn4UZKL/LAo9NQEY/sqIbpZPGZ734dqFqff2O0sP0G9/SdbLmStRLkUHwmehzw4RribQnXRP3OmfEYDlaGUzkC32cu3+GstVtO8OS3bNxWfRkA5SQ5udGxFqo0IdO/ow6/Jj3sabvmaejTtVJ7XMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfKCXI+3fm0WhIUGXoIF0zBtpd47etRXPPXXJ5LNkXw=;
 b=tE2ef9Y60jpn5fqMlRMTfLvH1zjrzMNGW/uFforKcTFWmI+r3ZtJwyPC9FIgWFPzUAwJUdeUV91rDqnUDWHYSGed38J7eKDpDCqBkobJHvN/zNlbfCliWN9+4WSNbNDeroY9nc/YoGRYQELh0fza0iiCIYpCoFfpsk4thbLylJazSj6NdNST/hC9amaZuAet5n5ac0PB2Nn8kxfd+OGV5sf32U5Fd4uDi/dIIW17veU0pnJ1Hb19qvtIGvOhVGka/RTNmWIVGe/WSpCPHDg2pNGVrk0V2xmZmIiqlNN6Eo/mvb+TwGIJR3IcgCtDdnc8LSmbOpMK0PgBcyBLCLxWJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfKCXI+3fm0WhIUGXoIF0zBtpd47etRXPPXXJ5LNkXw=;
 b=eZHkps5tWgStXA7KVGhkxMC4XAwIUWU2tp3Qfj9eTTPPi0pweUNaN2frtvOJtv9zGjccW67pRSjPuCvOM2OvX8G0zuIrmbLgzqQ7Oin96VhdmGtJgcQ0xWPXfe2r3YPMqKlxEdPlPgdGiC4imN6t3MWh2T0IYYp3RxGRUZNPv3c=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 9 Sep 2025 03:21:43 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 03:21:43 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: make smu_set_temp_funcs() smu specific for
 smu v13.0.6
Thread-Topic: [PATCH] drm/amd/pm: make smu_set_temp_funcs() smu specific for
 smu v13.0.6
Thread-Index: AQHcITB5LbJGK6SqKUeaOPqgiDYKbrSKKmdJgAAEjJA=
Date: Tue, 9 Sep 2025 03:21:43 +0000
Message-ID: <DS0PR12MB780458A3DBE8C558D0ED5E88970FA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250909022110.2695284-1-kevinyang.wang@amd.com>
 <DS0PR12MB78045814DF5FE4A2247B2534970FA@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB78045814DF5FE4A2247B2534970FA@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-09T03:05:07.5184514Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CY5PR12MB6323:EE_
x-ms-office365-filtering-correlation-id: 19929e16-9c72-4a05-d483-08ddef500008
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GpZgTOGJHqRDlMhTHBMolp79qrCe+A8mnhikGl/eVbwLSzf9sIDC2TYphXJx?=
 =?us-ascii?Q?A9rPKcsmiOZBUkKwpySdZSoNjeb/Xtd0Sc9OiNcQklWW4x3tFl4pCEzplB0k?=
 =?us-ascii?Q?7Phl5vEFAFG/VTtSvKFe21GBCrFfhnuCOhzMSIKLgVC/NEkwHYNWVQaJatxG?=
 =?us-ascii?Q?BJdNCsv95DKRrxXSh8tjLEcQZYKAL65fJUrHePpSinpV9G5DlB0j7qu3wNNK?=
 =?us-ascii?Q?Xr3lP/nkBH0gmAY4I3cNxKf8n/bYXZN5Vjj47Vmv51s78yJExjIKya0MqqV/?=
 =?us-ascii?Q?cqzIEE0B0q5cTbpJjQLFBGZF4Ly1E5KqAedEVPjgSzxxIt7K8BVB4QI1T5Vx?=
 =?us-ascii?Q?+PlKxGup4LqSLT47VBStUcO9W34dDWgAnzUVzJSMLfA/Qgloc+Mtk8Q2hsIe?=
 =?us-ascii?Q?pyRVxSEWWz4Sxa+V4HJlJnXHuPXZYEIp5XTEaupBdjA8Y5cMfm6cUDywBRXX?=
 =?us-ascii?Q?jO5fPi31EuGX+ol8VMHxNf4KpBLHl28c7Lv2mvT0oCDRy+Ysfpyfn4ZYxYux?=
 =?us-ascii?Q?KpWfSDCyh+zsJwc/6C85juDQunf/96lbJMvU9ZKaNPUJXNqSo6m1yc6S92Nf?=
 =?us-ascii?Q?ngMxtao7JBkcs2qaIAz+8hHV/JI+/SQ7n780alWl5zE5UxWI//EgY/jroeGV?=
 =?us-ascii?Q?ewOKQ8TZkVCfwXlrOY8m5jCwe/CplAAxq8PXouh/JjQ2H12HSeHvIab9rqnW?=
 =?us-ascii?Q?EKjPl/ti/Tg2QKEsptVLHHy4HHr1BCfrJI/OQOcEdWLMdYkjI7ACqdWGWBlz?=
 =?us-ascii?Q?T9FldiVueWU1O3/nsSffCliycI3EEuOfgsjz2QaZdUUuGMoyBH2mxdGGWpUt?=
 =?us-ascii?Q?qzMkgnJRhewD7VpLTchGsuSYGtBK86dhS8mDgj26t7116E2SbldlCBOPcQAC?=
 =?us-ascii?Q?/TtLGaaLHDyxmAOS/d8K0EMiJ9DeKzvNuCN4ENk1YzOpXS+2JinVAJTkBPqx?=
 =?us-ascii?Q?rlPcrQHgynk1TqKlCYEiC7Pga/D9ZQu0UrbySdGxS9pY3JOcXeJPzdWWxWuK?=
 =?us-ascii?Q?6RwaSe3vfqV2Bv5FtPpELq+bwCWMeVLypm8WFiytVN46vWiiIQcM7JttQ1Aj?=
 =?us-ascii?Q?Rru1fLcvAylELZQwdFtkAy7cbBUiIwgIHlOvo90XefdUYDLqrYn2Lg7zSycS?=
 =?us-ascii?Q?dVqQBGXrw2mur+kN1G43R68z7fXrnphichVPkIgd2X34qR9vkD4RMHI+Fflu?=
 =?us-ascii?Q?p/nsXc+ZkGMmMk3Cr8FZb5ekSEZjAm8WhDmo8/k2RzDV/HE2OMMmuMEakt1D?=
 =?us-ascii?Q?Kx0gPKL0EWL1jm0ArKD0pCYRAZ3FydsoEvJmfhNcf3PdlH7fOCD4XvAQ6Y6P?=
 =?us-ascii?Q?Ef/fNPXEp6jdvPS33Sfadr9c04b5E3pxWX8n4meniPWXXmk80ySQrH+9OHSg?=
 =?us-ascii?Q?/gRtmZ1G8Pb5iFNyriFznNNRh6HPsfC9LmSWjSe2UpesPwonDNeTs4rzD+3O?=
 =?us-ascii?Q?gB7hfgwl8mfQJ16APcT4stGtA/XzFvIa/RbO8dkh1XDWPgbKn6s3izNKwods?=
 =?us-ascii?Q?pCZXa1Gne+++asI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P6Uo0CYdTDxvYSXfRZq3olqZzGOWfrHkJJRFiN4Yyd9QrnyZp9Yd/cgjBty7?=
 =?us-ascii?Q?GssA8OFzRzm6wexGkWfw6HFooygUIEAwSa8FvFy/4/lSGlkOz+NWrfKfQAne?=
 =?us-ascii?Q?57Sj3ahP3PRaXBYgTf6k3UTReWu4JMhohnalP0iYrwHyzElSFedbBpP3irRb?=
 =?us-ascii?Q?513+DFrs2WIOSW7gpUrsOzGLr3XPJPTEG1xvmMSWg6nT0lxoiS1QkLepxnyS?=
 =?us-ascii?Q?dFDvGH+CaVQDetkiEpbhVU1mrfxcqWt9/lqAoq/eSgOvcg1I5ENER2gwa1mb?=
 =?us-ascii?Q?6J56VFXNSpCH4geomdEfATK7RMBtaugJ2mmpIeDV5/ls5Nj1esfDtfiTCEN8?=
 =?us-ascii?Q?IWwWiKlQXKD5XQyriB/W0UGlt0UK4jSXh8u4p4FjTh24mMHY+Ha4bc5VRhLd?=
 =?us-ascii?Q?mmhCAF3n1fBoOm5VCn6ZLKMeDAjjyvBYVb76jCkl+/PG2VLmZIMFzPxr62fh?=
 =?us-ascii?Q?Wh3EErl9Es8gF0hqoNcAHNNc6svo/AKUSIaGiTmvMbZE7YU6nGa0sTMjOnzQ?=
 =?us-ascii?Q?qUcwakcRfUrTZpCBRQSj7xPsREKNcQ/zOjfL1+7T+m0Y+oW4NIPvH8oZJezF?=
 =?us-ascii?Q?esxhhQ63oWJqeUjHqjm4a6qUN6X1Y4miFihge5K3HsyAidUbxv/RtJuStpdu?=
 =?us-ascii?Q?85YyGIYZ/YZYOb1z62fcHOF2VAxNaq/wB0wclWNwlp325W0mIC/k/4+IkCOy?=
 =?us-ascii?Q?v+ZyOdGutbpHU0Yc1wRcDx3Jj1i5L+BxyvSRfkWnl1QxGAZRPGCs4D+ygbqH?=
 =?us-ascii?Q?rQKj/43BbqChEDOy4x0S9rBv3aRYSydy2YeiD70Gewuq6G1Pjun3wF0zQbYh?=
 =?us-ascii?Q?j1jV8p7x8dpjQsWs2mLk3ZTkqDYo3Ov6boYRA+/naWxzsJ8Xit+x4nBTgVzE?=
 =?us-ascii?Q?m5ruQGwcH+u4opihWPvzmLVupSi+7E4lIQhuHT357ueXIu2/DvOCWut01RTV?=
 =?us-ascii?Q?dvzyM19q1IcBWbWSwZS586Td2nMszGasnZ82vS1n0rZMdm53IPuaxtVKdFpk?=
 =?us-ascii?Q?ReJud6KZt4i36fJ1UTRI739oTQDpkPCIFh0Ilj5eFiCwBgEMajA4JQIx1k4W?=
 =?us-ascii?Q?PSm3ZBSdV3rZD3ciICTI2/SIahhMHzIxVpAHUvPyLplNcoPeYhBpVx9LUvhx?=
 =?us-ascii?Q?ywvmO7s2EcpYYY3aw7dDK9vFwYqIj7TgSR3mOA7uid4Omrk1HP/CVOkU80oC?=
 =?us-ascii?Q?NOnzwrRElqrn92VSbuxnAo4AkHFcszQ2GBtPFRAnCp+O6krA7t57SCRvOyVz?=
 =?us-ascii?Q?aREUb9NW6aJnr68FG/6uqmQ7FycnGBn+MimmX/MYmH35T56feKIZ/Fn3fqWv?=
 =?us-ascii?Q?QKr0Dhz+l+m9ciricuLd52Kk6rra9/hd0dyK+PVeRvuv/n7ZUgQP0SyJyZVC?=
 =?us-ascii?Q?N4hhh29hWWE7UlUwZCBMteCA5bOe+kcLz4c2MRq5rujVbfLXKDCrF31SQsmx?=
 =?us-ascii?Q?5rQzeCOwmgskSf0UNLE2i3vrABlB0QNlV6eRGJgfTOqQKt/ttK34HDt7x+cg?=
 =?us-ascii?Q?oVSXgmsMNYuHwtXvtrtG+l2BPaC+/X0epA0lyi5JNV44NVTrHyoBwIyuLSlc?=
 =?us-ascii?Q?amIZZPrLADBAPpZ5OKs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB780458A3DBE8C558D0ED5E88970FADS0PR12MB7804namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19929e16-9c72-4a05-d483-08ddef500008
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 03:21:43.1526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MoRR6Kw/qnLdR7u13TVyidu2h8nzcJOEL0Egd4BOKTOASVQb1gsxIo6jCSgRtNp8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323
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

--_000_DS0PR12MB780458A3DBE8C558D0ED5E88970FADS0PR12MB7804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Please ignore, misread the patch initially.

The patch is
                Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar, L=
ijo
Sent: Tuesday, September 9, 2025 8:35 AM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Kamal, Asad <Asad.Kamal@amd.com>
Subject: Re: [PATCH] drm/amd/pm: make smu_set_temp_funcs() smu specific for=
 smu v13.0.6


[Public]

The purpose is to keep thermal related interfaces separate going forward. I=
t's not about this one alone.

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Yang Wang <kevinyang.wang@amd.com<mai=
lto:kevinyang.wang@amd.com>>
Sent: Tuesday, September 9, 2025 7:51:10 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Kamal, Asad <Asad.Kamal@amd.com<mailto:Asad.Kamal@amd.com>>
Subject: [PATCH] drm/amd/pm: make smu_set_temp_funcs() smu specific for smu=
 v13.0.6

move smu_set_temp_funcs() into smu_v13.0.6 ppt.c file to keep same code
layer in amdgpu_smu.c. (only set_ppt func in amdgpu_smu.c)

Signed-off-by: Yang Wang <kevinyang.wang@amd.com<mailto:kevinyang.wang@amd.=
com>>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            |  1 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 12 +++++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h |  1 -
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index ae3f7f00c38f..b140f6fc50f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -766,7 +766,6 @@ static int smu_set_funcs(struct amdgpu_device *adev)
         case IP_VERSION(13, 0, 14):
         case IP_VERSION(13, 0, 12):
                 smu_v13_0_6_set_ppt_funcs(smu);
-               smu_v13_0_6_set_temp_funcs(smu);
                 /* Enable pp_od_clk_voltage node */
                 smu->od_enabled =3D true;
                 break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1e506781a470..e028046b027f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3850,6 +3850,12 @@ static const struct aca_smu_funcs smu_v13_0_6_aca_sm=
u_funcs =3D {
         .parse_error_code =3D aca_smu_parse_error_code,
 };

+static void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
+{
+       smu->smu_temp.temp_funcs =3D (amdgpu_ip_version(smu->adev, MP1_HWIP=
, 0)
+                       =3D=3D IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_=
funcs : NULL;
+}
+
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
         /* init dpm */
         .get_allowed_feature_mask =3D smu_v13_0_6_get_allowed_feature_mask=
,
@@ -3921,12 +3927,8 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *s=
mu)
         smu->smc_driver_if_version =3D SMU13_0_6_DRIVER_IF_VERSION;
         smu->smc_fw_caps |=3D SMU_FW_CAP_RAS_PRI;
         smu_v13_0_set_smu_mailbox_registers(smu);
+       smu_v13_0_6_set_temp_funcs(smu);
         amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
         amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);
 }

-void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
-{
-       smu->smu_temp.temp_funcs =3D (amdgpu_ip_version(smu->adev, MP1_HWIP=
, 0)
-                       =3D=3D IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_=
funcs : NULL;
-}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index aae9a546a67e..4652fcd5e068 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -74,7 +74,6 @@ enum smu_v13_0_6_caps {
 };

 extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
-extern void smu_v13_0_6_set_temp_funcs(struct smu_context *smu);
 bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_c=
aps cap);
 int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);
 int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_t=
able,
--
2.34.1

--_000_DS0PR12MB780458A3DBE8C558D0ED5E88970FADS0PR12MB7804namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Please ignore, misread the patch initially.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">The patch is
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Lijo Lazar &lt;lijo.la=
zar@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Thanks,</span><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"><o:p></o:p><=
/span></p>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Lijo</span><span style=3D"font-size:11.=
0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><b><span style=3D"font-si=
ze:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span=
 style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> amd=
-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt;
<b>On Behalf Of </b>Lazar, Lijo<br>
<b>Sent:</b> Tuesday, September 9, 2025 8:35 AM<br>
<b>To:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@lists.=
freedesktop.org<br>
<b>Cc:</b> Kamal, Asad &lt;Asad.Kamal@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/pm: make smu_set_temp_funcs() smu speci=
fic for smu v13.0.6<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p style=3D"mso-margin-top-alt:5.0pt;margin-right:5.0pt;margin-bottom:5.0pt=
;margin-left:41.0pt">
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">The purpose is to keep th=
ermal related interfaces separate going forward. It's not about this one al=
one.<o:p></o:p></p>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line">
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Thanks,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Lijo<o:p></o:p></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"margin-left:.5in;text-al=
ign:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><b><span style=3D"font-si=
ze:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">From:</sp=
an></b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans=
-serif;color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.fr=
eedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
 on behalf of Yang Wang &lt;<a href=3D"mailto:kevinyang.wang@amd.com">kevin=
yang.wang@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, September 9, 2025 7:51:10 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Kamal, Asad &lt;<a href=3D"mailto:Asad.Kamal@amd.com">Asad.Kamal=
@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: make smu_set_temp_funcs() smu specific =
for smu v13.0.6</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0in;margin-right:0in;mar=
gin-bottom:12.0pt;margin-left:.5in">
<span style=3D"font-size:11.0pt">move smu_set_temp_funcs() into smu_v13.0.6=
 ppt.c file to keep same code<br>
layer in amdgpu_smu.c. (only set_ppt func in amdgpu_smu.c)<br>
<br>
Signed-off-by: Yang Wang &lt;<a href=3D"mailto:kevinyang.wang@amd.com">kevi=
nyang.wang@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 12 +++++++----=
-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h |&nbsp; 1 -<br>
&nbsp;3 files changed, 7 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index ae3f7f00c38f..b140f6fc50f6 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -766,7 +766,6 @@ static int smu_set_funcs(struct amdgpu_device *adev)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 14)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 12)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_v13_0_6_set_ppt_funcs(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_v13_0_6_set_temp_funcs(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Enable pp_od_clk_voltage node */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;od_enabled =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
index 1e506781a470..e028046b027f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
@@ -3850,6 +3850,12 @@ static const struct aca_smu_funcs smu_v13_0_6_aca_sm=
u_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .parse_error_code =3D aca_=
smu_parse_error_code,<br>
&nbsp;};<br>
&nbsp;<br>
+static void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_temp.temp_funcs =3D (amdg=
pu_ip_version(smu-&gt;adev, MP1_HWIP, 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D IP_VERSIO=
N(13, 0, 12)) ? &amp;smu_v13_0_12_temp_funcs : NULL;<br>
+}<br>
+<br>
&nbsp;static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init dpm */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_allowed_feature_mask =
=3D smu_v13_0_6_get_allowed_feature_mask,<br>
@@ -3921,12 +3927,8 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *s=
mu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_driver_if_vers=
ion =3D SMU13_0_6_DRIVER_IF_VERSION;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_fw_caps |=3D S=
MU_FW_CAP_RAS_PRI;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_set_smu_mailbox_=
registers(smu);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_6_set_temp_funcs(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mca_smu_init_funcs(=
smu-&gt;adev, &amp;smu_v13_0_6_mca_smu_funcs);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_aca_set_smu_funcs(s=
mu-&gt;adev, &amp;smu_v13_0_6_aca_smu_funcs);<br>
&nbsp;}<br>
&nbsp;<br>
-void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_temp.temp_funcs =3D (amdg=
pu_ip_version(smu-&gt;adev, MP1_HWIP, 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D IP_VERSIO=
N(13, 0, 12)) ? &amp;smu_v13_0_12_temp_funcs : NULL;<br>
-}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h<br>
index aae9a546a67e..4652fcd5e068 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h<br>
@@ -74,7 +74,6 @@ enum smu_v13_0_6_caps {<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);<br>
-extern void smu_v13_0_6_set_temp_funcs(struct smu_context *smu);<br>
&nbsp;bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_=
0_6_caps cap);<br>
&nbsp;int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);<br=
>
&nbsp;int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metr=
ics_table,<br>
-- <br>
2.34.1<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DS0PR12MB780458A3DBE8C558D0ED5E88970FADS0PR12MB7804namp_--
