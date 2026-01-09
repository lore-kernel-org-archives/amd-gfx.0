Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EADD26D75
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 16:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F89410E908;
	Fri,  9 Jan 2026 16:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QImyLTKr";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C737410E90A
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 16:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NR4u8IOmwFZ9hMdE4K6vT8x6sKvcfuFX1f0YazD7Wn4Q0xhXWt7USI0e0AKPZgvgH6Fh5IfZdaKtYY2f3bNFfVwzyncXcJvpU4+o3IoFLbPebNmJ0qIRcXJjpQmx6fQH+u2H/GWo+yAAVErEuDkCax91fy+zTpceSvCLjKouJRgBZ+oVOYRYKIL4pMAOZ8ixv3kSeG2qtcV5fiDANcnuQ5G1nEfCKKnHxmjpoPD0Zm5tOPGkSJqGi9pAzUskBmSQV3Xf6g9YwVWkr3vqTT6Q6lweb5LJBOotNwFxP2w2v9QN2d7j2UGD86ab0Q8HMnphPP/1ImRDCDddjbMqhYmnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V61sHcNbYFv3oi1czr7mmvBbhfJi0Jtn1Bl0f7uK6RU=;
 b=lkgF2hSJepusw4Sy91gmvkQd+Cy/s//Cl7quQUUcc7O7LjZFWx3miOwjx0iQhG8JRF6UlGLTNT9gulnt2S3N0BEZokqGw/BJkyXvNF/ikELZaWkv6wHYsARQvGPLUG2K8b8PdUMbOE8F9znGO0y/l3tkCN8QjA/MvHiP5vK7kl2RnPO/RstykOdTdV1v3pUmYFL4QF7Ai5pzjSK8VVS6I+k6rNe1mSK2aJe/T0+4mVC15pFuz1qq6Q7g+MupeLKPe7SKxDlWUOamurfOwMqJNf/iXpfm4E6fL6SZkH9S/xLUV0sPrWffBESB7AYnFJakIVT4h6gg89YEVeZvVs8NmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V61sHcNbYFv3oi1czr7mmvBbhfJi0Jtn1Bl0f7uK6RU=;
 b=QImyLTKr8DzAxCEl1W9u37yM6crsbLozfX5ymZ0m8dDvjBC/DGdqgo2clMiJuzNpaygjjf3QRO1UI9ta3z1lL40LuR0i6DJJKeOyVyzgP/ssRO4UBp3IplO+RZ1VN++WD14bTVxfaU3wa3Nuh57yu4RGSNi2SpxlUlonCo+uecQ=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 9 Jan
 2026 16:39:49 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%7]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 16:39:48 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu/mes: Simplify hqd mask initialization
Thread-Topic: [PATCH v2] drm/amdgpu/mes: Simplify hqd mask initialization
Thread-Index: AQHcgVAc4l4XI83wwUmmbQ0KJbLNvLVKCUHg
Date: Fri, 9 Jan 2026 16:39:48 +0000
Message-ID: <CH0PR12MB537208133262DC80280EC548F482A@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20260109100936.1163980-1-lang.yu@amd.com>
In-Reply-To: <20260109100936.1163980-1-lang.yu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-09T16:35:18.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|CYXPR12MB9340:EE_
x-ms-office365-filtering-correlation-id: 4360880b-89ee-4503-5ed5-08de4f9db44f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?sG61S0DArmSGATFDPb2AocuiTUC98Pl9kebWxTTYIe2a3j91lhchgGQ/DV97?=
 =?us-ascii?Q?Eq7jjs5oH8UvF9GWrq6tV+W5r0yEh24oTnlUk2UQXo2XpqPLmGGQu4aHXGDW?=
 =?us-ascii?Q?ulKr/UefaiHB3lKOsJI86aZ+egRHrYKfl3Tvk7hm89F2/XM4wvSPMmvtjq4P?=
 =?us-ascii?Q?YaB1lh69c5Qm4X6kYtkSMi5P7ljnuLBkmo1ZM1aTmi70SYerBzpK9WXYJ5SS?=
 =?us-ascii?Q?ixChE8GvYBjGj1O2PyltY5HM7RXq035u7TKtEyJpaCJTxMrStzcxHAeM75qI?=
 =?us-ascii?Q?T6CNvuYpKMTfh9oAMxSiF2R3LxsjgHl0Wjyy5PSeyQ0KQ/ztuQIiauGOMn4i?=
 =?us-ascii?Q?VdV1UFavSIXQ8vIgkRYS1TQLvdCC24bEb+OdjuzcNGlkLtqOljaRrqd78m+j?=
 =?us-ascii?Q?Nhd/qDQKd40RbCacPY5d1Iu9rPUiZ5WnRaYfMRH9+XdYGzsoExXGKqcLxAFd?=
 =?us-ascii?Q?PJ1LB6R9mEoyFAj9JtsqqL/D9YOpZO8Kh0RgNw3KZR/SeMF1ys4PVYvERhZQ?=
 =?us-ascii?Q?T2SueBu6qPHVh9Ytv/hCh+i7/RxahLxcpmRqVWHDmhkcPJ1Gy6kldVdSaVvH?=
 =?us-ascii?Q?k/ODQGIP+/rlhXHodqSdP8wVowEFmOtsRzLy7ZtCennuQmHVS2ZFJhI0WSOz?=
 =?us-ascii?Q?tywgM+bvJohBxALyevJP1f1twV7mRiwBSOwgFoX1tK9EcE1Fp+bBTcj7QWrx?=
 =?us-ascii?Q?Ob/hBIcbNU+XtBU28rlwjYWnVugja+G46DCs4KW0Ti9eeQs/vefNYF0dR6Yv?=
 =?us-ascii?Q?yh3vUhAhjvvPNCeNtHMKwTqoi9SVOcX0OtaSWTGOZfCb/My6aVpZ3tGr0Y8B?=
 =?us-ascii?Q?oPd1NYvLvJrLut8e6ZcGc7A3pn9y3fUieAdXLqNckf8xiCg+eyGgN8R9vGq0?=
 =?us-ascii?Q?is8bbtKotXcigSIv0IPftNMAWufQ99PtV2arGeFCzcXrux6gmNSyqr/Z8724?=
 =?us-ascii?Q?aldpN6e1l7sZ+A/IOj5wnzk9rh2aAA8IvzPODcikI2ZU+LVCiEA3lgUN3d5J?=
 =?us-ascii?Q?1z0y6V1SVkx4pQIijaL0g06VzXb4OFO0f7b0R4KdaJRXJ6PZIxeOBeQRizq7?=
 =?us-ascii?Q?xoBTynC0qtD20D0as6sUUpqF+5gS4KOYH2zA05nGXa6TaytuzH4jU8Mqp+ja?=
 =?us-ascii?Q?lXvn0pICvKgun6dWqDsUu/Fex4QZjprI08CyEGZz9EenL8ctFQxupgpBWszy?=
 =?us-ascii?Q?46C1JmYw0gzeu2ZIcVgHKB4Reb3Cv4ouOfsqDHo0pSgei1fFCHTR5ZRuEFJE?=
 =?us-ascii?Q?eRSJRJyUhhyrWoViF1MXPxnY8CqnJ/I+mW+RGYDiBgU9gmDowQuSGIe5p05L?=
 =?us-ascii?Q?phUt9xt5zNkiY8vVAzeDfXWChlp7o3JwvN+6E903TrBCQH1Irx/QLZsPH3fr?=
 =?us-ascii?Q?bfTjvkVLzGl1u//1sdpm9PoD9eTm0ump8My+Dx08oo0Nhv07MSxizdKqyNxg?=
 =?us-ascii?Q?cH3vkZ3hI6H7KmY5VU49hiOVFZvGCtNEWTamwalD31PZhHvm3N7ZlBv/QKbw?=
 =?us-ascii?Q?Sz/qd669td0tVWPIBYD8/MtmtiMjaPjddG+p?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2dwEyPrjw+vTN54wmS7Gk5ISWqlr+zPho4Ht/jzG9/oGaBNTqooR4+Oc6/Jp?=
 =?us-ascii?Q?hThgA22P/+sUYdu3ya1E9m/gDos1dq6TL8zk8juPgH7zi1dMP2B13jaiLO9F?=
 =?us-ascii?Q?zmJjKLjUe03zSAh4x/gs0QQAXVwDFIK67MUBi0oCsLKT0dAh6Uu8GiBJOObh?=
 =?us-ascii?Q?olQTYHB8p8nt/BaI0xexxY4AwGlw+kqjYfdbsPgpITO2q3H97rcYtydzyzQK?=
 =?us-ascii?Q?DHrA2oVzYpdcp15459WWWFvzanv3adqzjHYEtvi3pwd283l4FyRVf+6s3VFy?=
 =?us-ascii?Q?LG2jQT4hjfbVIWmCjLhvTgy6X30OMsXd9Hio7TMIq03PveArJVNhXSvBwc9M?=
 =?us-ascii?Q?IPTZVcXo98KP8tQ1Isgtcz73YC0sZoIUOwbBENrvA45ySjnG/AFAh/w57dxA?=
 =?us-ascii?Q?o5LUqQxWrOAaqkpqg72GROv3RQ5ufgBSZ1kC0Ad3bW76wLU1OSL2PmD+KN5O?=
 =?us-ascii?Q?lZQXB7jkZFS+A4vS+PWoaj2kzEZ+fO++IrtHzLvHnHtgGo/w1+gb5uhVKOhR?=
 =?us-ascii?Q?6KY37N/G3A/UqKu9l9locnzfQpBUlZriMSppN3JEAElYX+TZexZYPv1s/Vck?=
 =?us-ascii?Q?2C4XeikW3Xp0Kw9WHP/KDvAVDfM1bFi1z2rsVYlzgvlQYM6Wq8XkvxRA7NN9?=
 =?us-ascii?Q?mTOAHATpYLLo1cCCpmIfFwOXwAY98Ukx/m3bhdkiBsWuTECV9x2JU3dnWsnq?=
 =?us-ascii?Q?rjCOALwg4RFvMB4cf5497X5PQzKOhj+v86t0HdcMLw48IuKptcRF2XTu5xzT?=
 =?us-ascii?Q?zCDj7CYQKGAUv7CjFT4NCTwfxDpj1F2R7hUqmGDkZGPSwEJyvn0Ty+CFjdp2?=
 =?us-ascii?Q?f60NOtF8nb1J06rd9iH+Q/2iHRvfydVpN+TQgTYtULQhy0t7/vbkhiFuJNkh?=
 =?us-ascii?Q?jNTXwjtGFh3cZspF7YLoCLyVNbJObmXIZczfZZUQe+2pGP1UBE/ce/HCU9iA?=
 =?us-ascii?Q?cXw/GhZWeN8jCFXROClhAPOlVFOSptxPW8DJ7tJWvy37ygi+A6AmcSCyzYy7?=
 =?us-ascii?Q?dXHqur6iub3hmBsVqrXQhlX8EVMRahvnYJ94qirX9Wd2mhkylGQfwnTtyLc6?=
 =?us-ascii?Q?fWgq7HTC2W3p7dkVS9+Lw0KdlzaDoljGTRVF13O4XUjwJDV7wkMFknOX6vqm?=
 =?us-ascii?Q?kl6WBIi9t/VX8331B1yfk7blxryTdpIHUjgcYL6VLU2O0tvbl3dBgweBlUeA?=
 =?us-ascii?Q?J37ESOe7GFJFsYBLNFHO+gf+8wx8rJNLHj8SpUK17k83oDKhV9cGdWFQ2fSp?=
 =?us-ascii?Q?DmIgZ1l7maDVu6dx93GUP3L90PiooxP/WUhBJ9/qhuvEslKIdKj0SiYiano4?=
 =?us-ascii?Q?FY++I5260D1TKQXAHu70gMNIdxJ6f0iFvb2Ta+qO56rWfJPCEJbcL2xxvgCb?=
 =?us-ascii?Q?K7z1yyl60nP/0KSVwTX4PV7jqR/IZveFzukiIj1OSV8vzpB+ZTVdpoje2Hjt?=
 =?us-ascii?Q?Xgb9qRdVBcf/OHJ/xSXM7Oz2Ll7IARlH4EkhPqZhL7j3xovzEsu1BgbCjCk4?=
 =?us-ascii?Q?RPM0gR6FzMRWh7H3XL0SqLVcbqB1fP8CB7Qq9Veexo0PPubtpp8Sjf1sdR5D?=
 =?us-ascii?Q?k+l2U8AClnOYDSLDu9EfI47UaJMMIWsX+WPg3zGvIwfnc+1nN8pkYqUAkDTG?=
 =?us-ascii?Q?wSez4hmjcAkk7k/gxjfLUPpsswyeDIgW4xYw3BPAc+8Q1f8riydbQsLGkDWr?=
 =?us-ascii?Q?UYjkc08brWY2Dp4ubggh3ADGa0/oOIcZOjPqjnheJYLWxBZK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4360880b-89ee-4503-5ed5-08de4f9db44f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 16:39:48.6513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLIGl/jnmakeZaDPexj+lmZd/Lz8T0mohTqbxPxJzjWioYKvlmF3qQQ28HZ8V3mT6CB+1TGLO81eHsS9j8hvNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340
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

I just  found in mes_v12_1 , it still hardcode the  pkt->gfx_hqd_mask[0] =
=3D 0xFE in function mes_v12_1_set_gfx_hqd_mask, I think this is wrong and =
unnecessary.

Regards
Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lang Yu
Sent: Friday, January 9, 2026 5:10 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH v2] drm/amdgpu/mes: Simplify hqd mask initialization

"adev->mes.compute_hqd_mask[i] =3D adev->gfx.disable_kq ? 0xF" is incorrect=
 for MEC with 8 queues per pipe. Let's calculate hqd mask with number of qu=
eues per pipe and number of gfx/compute queues kernel used, and get rid of =
version check and hardcode.

Currently, only MEC1 is used for both kernel/user compute queue.
To enable more MECs, we need to redistribute queue per pipe and adjust queu=
e resource shared with kfd that needs a separate patch.
Skip other MECs for now.

v2: Force reserved queues to 0 if kernel queue is explicitly disabled.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 59 +++++++++++++++----------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index dffa0f7276b7..bed37e50d45b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -31,7 +31,6 @@

 #define AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS 1024  #define AMDGPU_ONE_=
DOORBELL_SIZE 8
-#define AMDGPU_MES_RESERVED_QUEUES     2

 int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)  { @@ -8=
9,12 +88,25 @@ static void amdgpu_mes_doorbell_free(struct amdgpu_device *a=
dev)
        bitmap_free(adev->mes.doorbell_bitmap);
 }

+static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pipe, u32
+num_hqd_per_pipe, u32 num_reserved_hqd) {
+       u32 total_hqd_mask =3D (u32)((1ULL << num_hqd_per_pipe) - 1);
+       u32 reserved_hqd_mask =3D (u32)((1ULL << DIV_ROUND_UP(num_reserved_=
hqd,
+num_pipe)) - 1);
+
+       return (total_hqd_mask & ~reserved_hqd_mask); }
+
 int amdgpu_mes_init(struct amdgpu_device *adev)  {
        int i, r, num_pipes;
        u32 total_vmid_mask, reserved_vmid_mask;
-       u32 queue_mask, reserved_queue_mask;
        int num_xcc =3D adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : =
1;
+       u32 gfx_hqd_mask =3D amdgpu_mes_get_hqd_mask(adev->gfx.me.num_pipe_=
per_me,
+                               adev->gfx.me.num_queue_per_pipe,
+                               adev->gfx.disable_kq ? 0 : adev->gfx.num_gf=
x_rings);
+       u32 compute_hqd_mask =3D amdgpu_mes_get_hqd_mask(adev->gfx.mec.num_=
pipe_per_mec,
+                               adev->gfx.mec.num_queue_per_pipe,
+                               adev->gfx.disable_kq ? 0 : adev->gfx.num_co=
mpute_rings);

        adev->mes.adev =3D adev;

@@ -115,9 +127,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
        adev->mes.vmid_mask_mmhub =3D 0xFF00;
        adev->mes.vmid_mask_gfxhub =3D total_vmid_mask & ~reserved_vmid_mas=
k;

-       queue_mask =3D (u32)(1UL << adev->gfx.mec.num_queue_per_pipe) - 1;
-       reserved_queue_mask =3D (u32)(1UL << AMDGPU_MES_RESERVED_QUEUES) - =
1;
-
        num_pipes =3D adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
        if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
                dev_warn(adev->dev, "more gfx pipes than supported by MES! =
(%d vs %d)\n", @@ -126,22 +135,8 @@ int amdgpu_mes_init(struct amdgpu_devic=
e *adev)
        for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
                if (i >=3D num_pipes)
                        break;
-               if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D
-                   IP_VERSION(12, 0, 0))
-                       /*
-                        * GFX V12 has only one GFX pipe, but 8 queues in i=
t.
-                        * GFX pipe 0 queue 0 is being used by Kernel queue=
.
-                        * Set GFX pipe 0 queue 1-7 for MES scheduling
-                        * mask =3D 1111 1110b
-                        */
-                       adev->mes.gfx_hqd_mask[i] =3D adev->gfx.disable_kq =
? 0xFF : 0xFE;
-               else
-                       /*
-                        * GFX pipe 0 queue 0 is being used by Kernel queue=
.
-                        * Set GFX pipe 0 queue 1 for MES scheduling
-                        * mask =3D 10b
-                        */
-                       adev->mes.gfx_hqd_mask[i] =3D adev->gfx.disable_kq =
? 0x3 : 0x2;
+
+               adev->mes.gfx_hqd_mask[i] =3D gfx_hqd_mask;
        }

        num_pipes =3D adev->gfx.mec.num_pipe_per_mec * adev->gfx.mec.num_me=
c; @@ -150,10 +145,15 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
                         num_pipes, AMDGPU_MES_MAX_COMPUTE_PIPES);

        for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
-               if (i >=3D num_pipes)
+               /*
+                * Currently, only MEC1 is used for both kernel and user co=
mpute queue.
+                * To enable more MECs, we need to redistribute queue per p=
ipe and
+                * adjust queue resource shared with kfd. Skip other MECs f=
or now.
+                */
+               if (i >=3D adev->gfx.mec.num_pipe_per_mec)
                        break;
-               adev->mes.compute_hqd_mask[i] =3D
-                       adev->gfx.disable_kq ? 0xF : (queue_mask & ~reserve=
d_queue_mask);
+
+               adev->mes.compute_hqd_mask[i] =3D compute_hqd_mask;
        }

        num_pipes =3D adev->sdma.num_instances;
@@ -167,6 +167,17 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
                adev->mes.sdma_hqd_mask[i] =3D 0xfc;
        }

+       dev_info(adev->dev,
+                        "MES: vmid_mask_mmhub 0x%08x, vmid_mask_gfxhub 0x%=
08x\n",
+                        adev->mes.vmid_mask_mmhub,
+                        adev->mes.vmid_mask_gfxhub);
+
+       dev_info(adev->dev,
+                        "MES: gfx_hqd_mask 0x%08x, compute_hqd_mask 0x%08x=
, sdma_hqd_mask 0x%08x\n",
+                        adev->mes.gfx_hqd_mask[0],
+                        adev->mes.compute_hqd_mask[0],
+                        adev->mes.sdma_hqd_mask[0]);
+
        for (i =3D 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
                r =3D amdgpu_device_wb_get(adev, &adev->mes.sch_ctx_offs[i]=
);
                if (r) {
--
2.34.1

