Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0190D1D480
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 17:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A8F810E137;
	Thu,  8 Jan 2026 17:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Op9El+/";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0191D10E137
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 17:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+8kF540ZWcRfPAl/3AdP/RqWjRp4K5Ywv5DExb/2Rs1tIm3ipqLZDX76PX4LsNc3pv1RoIV2kQpXWCMAmIAIlZJ8PJUkNiNb2xtBdVsdYd/5AbXe9cHRBmjdka6A7t/xCiMTScW0yxpbIHpwb3WSp9XDNuLuUWEFlKV/49E9v8OlKH43fGI3evXf9UAFpQxkFuXeymhirnKr0VlbBwOidFJCuF4A7E7VtuexLopumrjaTHj+sxEWQ0+cKhpKr3s+QEqcSI2grgi3sW9y2DCDbDKa368x6poHi6Uv3bH+NCRvO0Jor2PFpsdbQH3Z7MhBIEAQEhS4EgW0VHM0wCU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLGItWqR14x7gYmaAzzz6BUWxK9zKWoorv1rOmJhlss=;
 b=OPR3Mx8uSSS3rO9xM10ugMNez2AhBM+LYKtlJV5WiGcgBBwn+xwRC7jtKNchg3xZQImUbJNuNDwjKvlwEUPdBsBsEqCnI9WggcRAtv9uvIHTci5bRqDdPD3sApt5jxBVt6Eb/IN+7geCpTyNz3sG2DnRLFni+QEHeDJv1XE5EFqtJkaMtGtnv7HJMHHpDzmGviBWhhn2cP7PwJ8y+jecNFJu1rW+CtI1U9bnvnEDqPYNRBFW0UI3YG2KWHrdKHy40l/5XRCpBYV63y9sGxSscmQlFIGngBVbthBb+hScPWEWVpirPIT41rsqVuRzGrKA1FhCg8pdbIxjlt87Ue3CdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLGItWqR14x7gYmaAzzz6BUWxK9zKWoorv1rOmJhlss=;
 b=1Op9El+/sL6Z3S64/b9U5/6xmGxV2aelHEdsP9h1Ua8QOqmudh8pStoeOHelAf758pPbpD3CPBzW4yzaQPaiKXZLuCpQb+ihlclxA3q681Mo/haBbQseKPsuKtSpudnb2b95is6MANaqSEM9+w5itwtm2DNSka/9IzObUtXCltY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ5PPF0AEDE5C3D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::989) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 17:22:52 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 17:22:52 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes: Simplify hqd mask initialization
Thread-Topic: [PATCH] drm/amdgpu/mes: Simplify hqd mask initialization
Thread-Index: AQHccvV2NLybXpEhBUm5Zj1v1fyoKLVIoMmg
Date: Thu, 8 Jan 2026 17:22:52 +0000
Message-ID: <BL1PR12MB51442F8C36908D26D55D3DF8F785A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20251222034524.904628-1-lang.yu@amd.com>
In-Reply-To: <20251222034524.904628-1-lang.yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-08T17:22:52.096Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ5PPF0AEDE5C3D:EE_
x-ms-office365-filtering-correlation-id: b2dd6700-3aab-45e1-7ba3-08de4eda8e0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Nd4hNrnHbqVmpUQSWp2ht3IjdRJLN+3aQ0wXrYZxIrhb/OPzvmEunxl/ogKf?=
 =?us-ascii?Q?qygJbAlUkcuV56vJ4wogPwL1qNF+Nr+m+cBgjje74k90wbi3/zx2Fc9ZmiDw?=
 =?us-ascii?Q?Er0cofdhfB6Za0JEzGFi1lcd6ZcfM54W7qRA/+An5YOuUMIpRkWJYQIk3l9Y?=
 =?us-ascii?Q?yYnhwtPDPKLasBjs0RQ1VixLWNyq5Usn2/45oKcJ3fCrJoAHqWkpg18jVzg8?=
 =?us-ascii?Q?QJ/zlV6q4qbwGh6GlS/GkCymsRKlOEYJXW/ivamPr89NNXvI20zRA7PWorLi?=
 =?us-ascii?Q?RTnmrDjukg5n/XeSsg8DmONPcIt4htyO2PG20trH3U2gno2nSJz4BU3qikF9?=
 =?us-ascii?Q?/JQVRTpSaXAYXSiXPHZ3bR1w3gxn72k+Fu+uJCMCsQ+7wt4yhYgb7L7EqgHE?=
 =?us-ascii?Q?oyxAjhzlWpaG2ujhpIheWEfDLO+EJiqGtjLJbIEB8GEVDz6xEaIz+ouNFzm6?=
 =?us-ascii?Q?mK788lQ8/6gVfY2sjitR0d/MJCI4A4gZyb0ABZ9/U32U8eY/7o5JpArs9IUZ?=
 =?us-ascii?Q?0Anc15vVxOLLgqFcsq9NwaFXSQFqztRRRbfIWjMKNmxZJ2qIYXCNR07LlUAI?=
 =?us-ascii?Q?Ickd82xYedY3QjqByQsz6HwQQaJ+VupHVpVnnrkiqicKrtzMWbY+lk3CH+ms?=
 =?us-ascii?Q?6JcCpfwR6Djfou09aGV/Pa9VdHv/sKGdZGOKrynB73LHr8l4qbk3tC1a3AW5?=
 =?us-ascii?Q?9f1XwBU3VOC5QEyqcbLCa0lltDbJ89QBcyhZQf3A85R1g+2NlLjLpmE5dD6O?=
 =?us-ascii?Q?PVq0QkUu9eSnARaGzN+GGxz+gztuiakGqx4aPlA0LyqjY0q8ob3nMSc1nflq?=
 =?us-ascii?Q?HzznXoo+sGngkw2+pFB9EDmNeyD2+YceUfAEcnclE97PovePBu0LEQUTXZp2?=
 =?us-ascii?Q?Go+L1gTA9BaQI3HBftOqhiri9MufOQEd+4B7xWu77czgwZMenl7uVMfPXN21?=
 =?us-ascii?Q?o6lIFTmCveDfNOSaOeCB2QDpvBCtKyxRT2t9TTEWumN+ySjlJCObKRgbQLP/?=
 =?us-ascii?Q?nDe5pwSx2n3RpxbvzBe0hlFLD57nime4Q7+nJuS4OCJxY5AD2CgE3cRqG8A6?=
 =?us-ascii?Q?08K8icZEmTrObZ1T2AqQHI1HVyEBDoouxJTiLPX6gLVgSvDOwc/VEu4dq/oi?=
 =?us-ascii?Q?ur1GUkXnj5hmmwIk4F16g6S0f7km5PSqqEXXfn6kG9BfBuF/sqF9YhFDotdJ?=
 =?us-ascii?Q?eLwjRcTWM14AxHSmTyfxLPdWLNK3cXam5RMusIiQrEzuqg92tb2j51jC7ckj?=
 =?us-ascii?Q?BD3NmfvTXtpJYX4z8DCJvHTwz3OwChSOarELyAzoM3TO+1Ngxn6+VnKGKcu1?=
 =?us-ascii?Q?nrZsnmyKD/+XxOi2SAlWgc0914QxMvv+J8sFK2hq6l8TOrhST/WcrJPjntcf?=
 =?us-ascii?Q?B7n25T5YWA4lmIcYcfOK9Lq6QTdIJQ2tHwyQbdSkkRuuexrjQ2ZWUObbuGSb?=
 =?us-ascii?Q?/2BINngqTCXBbirEeISTSVXS6J1mwu+lxSTtfQHmUkrBmN3MoXMBUojLlu7Y?=
 =?us-ascii?Q?ze05HzbB+E+rbIKbJ/8133udkSDvOCnxgIad?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JWN8mU082U7MX5iCLoantSeabQJtBWhs5LT7HZXLV5MyyJ+ldun7X0D94ZSP?=
 =?us-ascii?Q?m+kRj5OsFpYqZQ8kT+9iWH6ZxwXFT74HC06kfZL9FCyQY4mFy2SRLIW/NWMS?=
 =?us-ascii?Q?/5Y8lOG6rQ1njoVlAtG2BSr2sothylyT7Sn3sEyNTi79eQTp0lkoLKKkwuvB?=
 =?us-ascii?Q?67uGzr9Wu06jA6iM0p57NoORbrpEqXElTwfKkIal4NZKHIEp7mCuPrxnL8vA?=
 =?us-ascii?Q?o1BFxGdjzKm4ja5PWE8Ia8K6SkLcppbbXVc2yvbSZlRDy8nm10tC1KYtpqvR?=
 =?us-ascii?Q?tv4NPpd1/L8gKOeHBQuTr9ZIC4nkWJGydycAkTavBl+JsD2IiPvlHxif+eNy?=
 =?us-ascii?Q?ErRgrojKvvXCNl6PxjSy4VsHhd8JvOlKvRTimGyUJ1ejvMVxbw02Qy3/eJzG?=
 =?us-ascii?Q?b8okPu/kbbqhxYAzOARwdj13eZTTzQ+MbDJs9sL8pGSx4K6pcR3SSnbo+DZM?=
 =?us-ascii?Q?NXkjEAhyK2cpUy/lgKX8UxATLuUl2aIbxkpFMYRlsIMynsYv1nixOqDEqJTF?=
 =?us-ascii?Q?WsqRkJ7LkJOq7qlqIFK3s92Sue6nvyfIcQRNJ4Y6asQkaQms0sLB5DsGZ1zU?=
 =?us-ascii?Q?mtr3ix4Hf3Tf8//2Q7sE7y5jUszhoYMXisKWXLVE6qB4zFuw4Gvd8HUYYA96?=
 =?us-ascii?Q?uVG7YOZWugjB4/f7oP3QFGATMVktCEWeKG01vwzdonm/e7qzYJFoxdKmK3/C?=
 =?us-ascii?Q?FyQprwxEgGhRVRdGsf2PceJcyekBLAX7axmx+3bQHVIsFhWCG6ye7eTJjcxV?=
 =?us-ascii?Q?nEPNzQo9bOtWcwr16ZtXW+9Wz92iZoyYL6OInXSL4ttT9VJR657hqNEZDClZ?=
 =?us-ascii?Q?R6HAIDFU9NykvM2f4r8N3YnLtAc560X8qHmSlqRTdtS5TPiYoVtl23DezA8h?=
 =?us-ascii?Q?soU0OCnzUSwNELVhJAn0pZIRHj1N4VB2te/mxFDDTknrwOMDJQF96lJvooXy?=
 =?us-ascii?Q?wX7Eehrnh0y11HzwwWW6oOO0x3WxGtV4Tlpz38V1wB5MdcgwrPLJrWPYOh6X?=
 =?us-ascii?Q?CgesD4Q5nYeaDoOihpD5CiTbvx7XdPSFWR0DmTPDQad7379X6Zu40BcVnXXD?=
 =?us-ascii?Q?slOhciFzYCuV/4xEaB54NxhqRH/MqBcWOfBbLGPkWInBcM0eHmnZ9u7N7rjV?=
 =?us-ascii?Q?Qe3QY8/PpC+djnBbFxO4XOziwhOVohpM8HdFL1rdLep3uf9ZYcmXMu7cXxkf?=
 =?us-ascii?Q?dwmSzmXri5BADrlSmky24e30JbQbKD75L+RzI26RSB4Hb0hXw2eMiQU8Pp22?=
 =?us-ascii?Q?FrrXUcMpcoumIvG34ym5yri4XLuJb3yQyo/2h8KrDOjpGXmylQENptqGHpkr?=
 =?us-ascii?Q?J64OSxngC45dPXfHOSIxlVceUkAC4VCUNPKygUqMtY4GoCede+41WLzcFpJe?=
 =?us-ascii?Q?zM8uVRIvVBRZUCWFNzaQGpHG/RNMEdTtRf0g122DMpozSZJWdj4qIDynQ+Yv?=
 =?us-ascii?Q?A850l6vA3BIxcljiG3+42F8X6GBFemIczn8Q6PIClRo98sk7fuU8ISSpMeME?=
 =?us-ascii?Q?5XUvoIe4s20WXLFWr7wVwNdh/95JU54EFCTdXb6lCxZV3PCc+LLYEdHDgFoY?=
 =?us-ascii?Q?/b3EttgHqeD/ffLYSRITWEwk+mvOX/awsEGMH1+h1Irmp1NL0gqyYxPtzfNn?=
 =?us-ascii?Q?SCD/0h1epP+tMh55kLrRifXLmAWmpNpZzGr34qgxzgfDhB2RnbRBht6uvCjB?=
 =?us-ascii?Q?9jEubErJebjIPjFIIhos5NtMdVRUiHhQ7owDNMuh/6ImKl6K?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51442F8C36908D26D55D3DF8F785ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dd6700-3aab-45e1-7ba3-08de4eda8e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 17:22:52.5578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jxj5vmW2hGtLB72KfLiEV4xO6RLdABgicx9vt6fgOnbqofB6w9xjbInUvEK71x7roNkawkbHxWlsPcaSWtyu6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0AEDE5C3D
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

--_000_BL1PR12MB51442F8C36908D26D55D3DF8F785ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Sunday, December 21, 2025 10:45 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH] drm/amdgpu/mes: Simplify hqd mask initialization

Let's get rid of version check and hardcode,
calculate hqd mask with number of queues per pipe
and number of gfx/compute queues kernel used.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 42 ++++++++++++-------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index dffa0f7276b7..5b5962a727f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -31,7 +31,6 @@

 #define AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
 #define AMDGPU_ONE_DOORBELL_SIZE 8
-#define AMDGPU_MES_RESERVED_QUEUES     2

 int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
 {
@@ -115,8 +114,10 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
         adev->mes.vmid_mask_mmhub =3D 0xFF00;
         adev->mes.vmid_mask_gfxhub =3D total_vmid_mask & ~reserved_vmid_ma=
sk;

-       queue_mask =3D (u32)(1UL << adev->gfx.mec.num_queue_per_pipe) - 1;
-       reserved_queue_mask =3D (u32)(1UL << AMDGPU_MES_RESERVED_QUEUES) - =
1;
+       queue_mask =3D (u32)(1UL << adev->gfx.me.num_queue_per_pipe) - 1;
+       reserved_queue_mask =3D (u32)(1UL << (ALIGN(adev->gfx.num_gfx_rings=
,
+                                           adev->gfx.me.num_pipe_per_me) /
+                                           adev->gfx.me.num_pipe_per_me)) =
- 1;

         num_pipes =3D adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
         if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
@@ -126,34 +127,26 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
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
+               adev->mes.gfx_hqd_mask[i] =3D (queue_mask & ~reserved_queue=
_mask);
         }

+       queue_mask =3D (u32)(1UL << adev->gfx.mec.num_queue_per_pipe) - 1;
+       reserved_queue_mask =3D (u32)(1UL << (ALIGN(adev->gfx.num_compute_r=
ings,
+                                           adev->gfx.mec.num_pipe_per_mec)=
 /
+                                           adev->gfx.mec.num_pipe_per_mec)=
) - 1;
+
         num_pipes =3D adev->gfx.mec.num_pipe_per_mec * adev->gfx.mec.num_m=
ec;
         if (num_pipes > AMDGPU_MES_MAX_COMPUTE_PIPES)
                 dev_warn(adev->dev, "more compute pipes than supported by =
MES! (%d vs %d)\n",
                          num_pipes, AMDGPU_MES_MAX_COMPUTE_PIPES);

         for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
-               if (i >=3D num_pipes)
+               /* skip MEC2, since only MEC1 is used */
+               if (i >=3D adev->gfx.mec.num_pipe_per_mec)
                         break;
-               adev->mes.compute_hqd_mask[i] =3D
-                       adev->gfx.disable_kq ? 0xF : (queue_mask & ~reserve=
d_queue_mask);
+
+               adev->mes.compute_hqd_mask[i] =3D (queue_mask & ~reserved_q=
ueue_mask);
         }

         num_pipes =3D adev->sdma.num_instances;
@@ -167,6 +160,11 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
                 adev->mes.sdma_hqd_mask[i] =3D 0xfc;
         }

+       dev_info(adev->dev, "MES: vmid_mask_mmhub 0x%08x, vmid_mask_gfxhub =
0x%08x\n",
+               adev->mes.vmid_mask_mmhub, adev->mes.vmid_mask_gfxhub);
+       dev_info(adev->dev, "MES: gfx_hqd_mask 0x%08x, compute_hqd_mask 0x%=
08x, sdma_hqd_mask 0x%08x\n",
+               adev->mes.gfx_hqd_mask[0], adev->mes.compute_hqd_mask[0], a=
dev->mes.sdma_hqd_mask[0]);
+
         for (i =3D 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
                 r =3D amdgpu_device_wb_get(adev, &adev->mes.sch_ctx_offs[i=
]);
                 if (r) {
--
2.34.1


--_000_BL1PR12MB51442F8C36908D26D55D3DF8F785ABL1PR12MB5144namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 128, 0)=
; margin-left: 5pt; font-size: 10pt;">
[Public]</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yu, Lang &lt;Lang.Yu@=
amd.com&gt;<br>
<b>Sent:</b> Sunday, December 21, 2025 10:45 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Yu, Lang &lt;Lang.=
Yu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/mes: Simplify hqd mask initialization</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Let's get rid of version check and hardcode,<br>
calculate hqd mask with number of queues per pipe<br>
and number of gfx/compute queues kernel used.<br>
<br>
Signed-off-by: Lang Yu &lt;lang.yu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 42 ++++++++++++------------=
-<br>
&nbsp;1 file changed, 20 insertions(+), 22 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index dffa0f7276b7..5b5962a727f2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -31,7 +31,6 @@<br>
&nbsp;<br>
&nbsp;#define AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS 1024<br>
&nbsp;#define AMDGPU_ONE_DOORBELL_SIZE 8<br>
-#define AMDGPU_MES_RESERVED_QUEUES&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;<br>
&nbsp;int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)<br>
&nbsp;{<br>
@@ -115,8 +114,10 @@ int amdgpu_mes_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.vmid_mask_mmh=
ub =3D 0xFF00;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.vmid_mask_gfx=
hub =3D total_vmid_mask &amp; ~reserved_vmid_mask;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_mask =3D (u32)(1UL &lt;&lt; ade=
v-&gt;gfx.mec.num_queue_per_pipe) - 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reserved_queue_mask =3D (u32)(1UL &lt=
;&lt; AMDGPU_MES_RESERVED_QUEUES) - 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_mask =3D (u32)(1UL &lt;&lt; ade=
v-&gt;gfx.me.num_queue_per_pipe) - 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reserved_queue_mask =3D (u32)(1UL &lt=
;&lt; (ALIGN(adev-&gt;gfx.num_gfx_rings,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.me.num_pipe_per_me) /<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.me.num_pipe_per_me)) - 1;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_pipes =3D adev-&gt;gfx=
.me.num_pipe_per_me * adev-&gt;gfx.me.num_me;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (num_pipes &gt; AMDGPU_=
MES_MAX_GFX_PIPES)<br>
@@ -126,34 +127,26 @@ int amdgpu_mes_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MES_MAX_GFX_PIPES; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (i &gt;=3D num_pipes)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) &gt;=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(12, 0, 0))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * GFX V12 =
has only one GFX pipe, but 8 queues in it.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * GFX pipe=
 0 queue 0 is being used by Kernel queue.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Set GFX =
pipe 0 queue 1-7 for MES scheduling<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * mask =3D=
 1111 1110b<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.gfx=
_hqd_mask[i] =3D adev-&gt;gfx.disable_kq ? 0xFF : 0xFE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * GFX pipe=
 0 queue 0 is being used by Kernel queue.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Set GFX =
pipe 0 queue 1 for MES scheduling<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * mask =3D=
 10b<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.gfx=
_hqd_mask[i] =3D adev-&gt;gfx.disable_kq ? 0x3 : 0x2;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;mes.gfx_hqd_mask[i] =3D (queue_mask &amp; ~reserved_que=
ue_mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_mask =3D (u32)(1UL &lt;&lt; ade=
v-&gt;gfx.mec.num_queue_per_pipe) - 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reserved_queue_mask =3D (u32)(1UL &lt=
;&lt; (ALIGN(adev-&gt;gfx.num_compute_rings,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_pipe_per_mec) /<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_pipe_per_mec)) - 1;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_pipes =3D adev-&gt;gfx=
.mec.num_pipe_per_mec * adev-&gt;gfx.mec.num_mec;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (num_pipes &gt; AMDGPU_=
MES_MAX_COMPUTE_PIPES)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;more compute pipes than =
supported by MES! (%d vs %d)\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 num_pipes, AMDGPU_MES_MAX_COMPUTE_PIPES);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MES_MAX_COMPUTE_PIPES; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &gt;=3D num_pipes)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* skip MEC2, since only MEC1 is used */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &gt;=3D adev-&gt;gfx.mec.num_pipe_per_mec)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;mes.compute_hqd_mask[i] =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.dis=
able_kq ? 0xF : (queue_mask &amp; ~reserved_queue_mask);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;mes.compute_hqd_mask[i] =3D (queue_mask &amp; ~reserved=
_queue_mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_pipes =3D adev-&gt;sdm=
a.num_instances;<br>
@@ -167,6 +160,11 @@ int amdgpu_mes_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.sdma_hqd_mask[i] =3D 0xfc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;MES: vmi=
d_mask_mmhub 0x%08x, vmid_mask_gfxhub 0x%08x\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;mes.vmid_mask_mmhub, adev-&gt;mes.vmid_mask_gfxhub);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;MES: gfx=
_hqd_mask 0x%08x, compute_hqd_mask 0x%08x, sdma_hqd_mask 0x%08x\n&quot;,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;mes.gfx_hqd_mask[0], adev-&gt;mes.compute_hqd_mask[0], =
adev-&gt;mes.sdma_hqd_mask[0]);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MAX_MES_PIPES * num_xcc; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_wb_get(adev, &amp;adev-&gt;mes.sc=
h_ctx_offs[i]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r) {<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BL1PR12MB51442F8C36908D26D55D3DF8F785ABL1PR12MB5144namp_--
