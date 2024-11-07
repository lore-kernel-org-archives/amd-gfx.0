Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1A8D5AE72
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2024 08:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD64710E04E;
	Thu,  7 Nov 2024 08:04:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P0La0a/O";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D77810E04E
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2024 08:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxzloceqONnnMKizkuNfAm3+mghO+d0Md5q1BtMzhtboqTkdaZhATpyoBRY453OmuH8LmcGB9QWREUHcbBl9wUw02efqagWPgkUu42ajrPESZJoPjEWWGHXmRMOGYlJxrG+lasKlkJAL4WV3wHnnpmHrSBhwP0xqW9OuPIsL+B8fk6vjAT8otv9XbiS8euPVaFBNTwFjET44vQ9tUEHyoAFLLHq6pjDRiVqMgFEy4RryLake2mn28wJStFoIQge762/j2fuX7gWj73xdDTAbbGGRcbXEAgNN0fz0om01ASRBxAZ+Uq15dIla8qUZ03svGZQRhXrXSkVBycCfZJOVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMRkC1MsyExQPjfwpFHQp+08lGmhtsny/162BS/Fto0=;
 b=NZlNmmAV5O6/Ejz4qadxpUbrO42GXNJ6V7XmXE9Jn4VUDmbyEQzYpJAxuS3cMYWCtKhTJhSuDm3z5b/jBnm7JRvw+nfEn8hPNkpcF1OvUuO7J7FDSwa3RsTipUjc3+rGAoKj4q1fQJhU57x2C7HAsfmTLqRkfVgiXY19gYUbw4KFoPxXogP3iwZ1C3P9J4p1yh22vwW1pA8UkmijUaMlatwJYxqU+TTUkXEaZpHL4TXdLdbgnnfp24BJVLtgD6W9At3PsP4j7KyHcc8p1FbwyAU7VUkEqyArQOYW4IznHjDsdiq+qKS84wKpYY0gjO5QPEQdiN/ZCHEIv6Qzo42O+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMRkC1MsyExQPjfwpFHQp+08lGmhtsny/162BS/Fto0=;
 b=P0La0a/Oy3hVinQNrxk8UMUSwuI3/FGzjv7CAZ2pbUUGGtMszYzuWkVlyAoOCPzMvMAP7yc0r2A1NLqJ2dxk+WpS4siutvmAUl7jCVtxqyS9uTYc5KZuWtrVOhz/LAggysqs8ID+9TF8DwbXZoHsurTjFQzjFimJ/lNc55YJn0s=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 08:04:29 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 08:04:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/mes12: correct kiq unmap latency
Thread-Topic: [PATCH] drm/amdgpu/mes12: correct kiq unmap latency
Thread-Index: AQHbMOgb348hWOi7h06RhRE47w5n3bKrdWIQ
Date: Thu, 7 Nov 2024 08:04:29 +0000
Message-ID: <BN9PR12MB5257CEE0A33D04589A150735FC5C2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241107073837.3532220-1-Jack.Xiao@amd.com>
In-Reply-To: <20241107073837.3532220-1-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4d1bcece-ca55-4a8e-952f-fce785c6b226;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-07T08:03:58Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB5738:EE_
x-ms-office365-filtering-correlation-id: 637268c6-04c6-4cab-a0d9-08dcff02ce35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7oInH9elup2DgUg1FIRsnHvS2jT3Y5O2yFBHAUBlRsfzNVL02w1aZEDIWn+S?=
 =?us-ascii?Q?Ki1Q8X89gVq3OWNyxt5RsCRAWlSffyqjKfDwVvecyG3wiCwZmAJ2Z9nH1JR/?=
 =?us-ascii?Q?uKnwS9/Rtzv+fIrOmh5Xv+xrzRgKw44x6sY3Sk+TXNZMk6N7PzvI0I66TFG4?=
 =?us-ascii?Q?SNaCeOnK/6JRSy6YsAQLbLevruHw+s2pevsti//dUKQqDtdqNjtJqoVUKDHE?=
 =?us-ascii?Q?FuWFby4OApoO9SnZI5XxAJBYklUfH2857NEOKL6R++I+634rYXSLB7kRAj70?=
 =?us-ascii?Q?yXCTk8LnNCOy2lngmiiX5DcDc/prtywr2cL5Sb4NCD8OlwLqbPSiyOGTXNsY?=
 =?us-ascii?Q?AFRWL0AZv4VBU8ErhShNzdLrIyo0zfRk+UfG6kg3CPgXSDnW17CTeFfs/3AK?=
 =?us-ascii?Q?lPOS9LY/pimD9GMKaf2P7voYdpuadG5KVXbWcWUoG1z1RCSvGZlOp9LgGLMY?=
 =?us-ascii?Q?7eBfoE7zRWDIuftnnNVt+DaLTr31Br+0/6zC5CoNanrbclnB2mKKF97ScKrJ?=
 =?us-ascii?Q?ZIPEGNDoxCdaRWXMUf9j/X8f6X8nLDXi94gt2k3uHW06H2YhmPJ18RWSg4iy?=
 =?us-ascii?Q?k8UZCpcmsnlvT871Eq8jdqN9Pr75SG6ukj/uhPJBn9xzn/TsUiTywSbGnYt9?=
 =?us-ascii?Q?OYrsERZ409SNeDTxvd+Ojlvb+qt8ev4Ds9++GczzPiuyl3x+70x/Ae+rDjZr?=
 =?us-ascii?Q?Nr9zgDewcMgEqGGbFue0QHKFwb4Ssii50zR6MhcLrwpbgO/yHAuqG0YMnlaQ?=
 =?us-ascii?Q?Pxr2Oug/j2DwpWH2NcSAsliOD2V4HBKiKI8LXEW3cpL5OrmJekCkJjoqUcVX?=
 =?us-ascii?Q?Tc+Q46ShnM46u+ROGL9iF96p0EKoqOJwhGddQYMuzg2HmCgI6wHJBlIhIpTw?=
 =?us-ascii?Q?IIqM5f2t79bGkXcCOJsX7f/KS9d+oqqYxePK+pSReAw1SE5ZWgZ9OqqlU5Na?=
 =?us-ascii?Q?K5iOVCTHJq7nFDxM9iiLtSTG39DpXejC93zO3Z0kXINITv+SD00z99ZAOFmA?=
 =?us-ascii?Q?Kyu32yhzrnlIWV7VHIY4Z0cLYEG1ERn/0B268jAOoHwWheHJOIbNP9ylv8rg?=
 =?us-ascii?Q?eKWjl89CMeawY0zTMw+vK2yB0MUwdYfpBbTKBJXoNtzsvdY0+h8J/LfzNsl3?=
 =?us-ascii?Q?PZhhEoPEXVmQM9wMC4o10VSWGbTEazlQFzCBaF+tzPSI4c7n6xEKLJfU30ZN?=
 =?us-ascii?Q?D/VbawKYANdF3bt85rSLEuSIkjPhyEjML+SmT+1xB6x5cKIr6Rk5NxIzJJ9A?=
 =?us-ascii?Q?Vf2MjJ6T+XlJda1b85liE8fUfiyJCHDC/cJ8vwvo/lzz9ZYxzKoo6u3gEu7L?=
 =?us-ascii?Q?RXI70jo5Hq8CYCeId8zxEePqOUKAbujVT08IwqQrKE8gXbNTbE3PG49Rzcct?=
 =?us-ascii?Q?f82OTfg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4f4I0D2zY5FlATAyvwsGFfYnS4a7ocz6IhmKH23jzprMki28F1PAWo02aHwg?=
 =?us-ascii?Q?6kcdcM5KtbxVyWW6tPcnIkCIQitDpkB5Ig3rJhZ6aaWVeznZonpfhqcarFls?=
 =?us-ascii?Q?G0uJ6nJf7KGoNiPp5BxHv9kxQAPrBTdETYYqTyvDOc1aIEzf+g3bk4gu1sIS?=
 =?us-ascii?Q?ouPxizdVutKW39o82IX9/VDhPY7gYo5yR5UBzKjm6+SBy31LpBM4U4yJdfYn?=
 =?us-ascii?Q?G7gJ6WCmL6lrdrTOwvgx7zU20a68nfqGRno6jvQHNpdz2TdZbsJQmg4XFZfr?=
 =?us-ascii?Q?IKYAf2Ynjvkcw+JiWZ+DMpaJsl82CjV9ZYnM5V2Xf33S+4tG1WW6VfP0c4Z6?=
 =?us-ascii?Q?R+8FX4dKB3NDaCmhRovgpeEPrWpeDG0j9Pqu8EL+hr0rKuSXteNaNSti5CzP?=
 =?us-ascii?Q?HEvE0/6g+pzsu/kU49SuWiYJ/cYluQIIgEGce1bsBA072f5QCHgP9ZFLZrCf?=
 =?us-ascii?Q?4hmq5iPcWE/3c8d6vjYcyRzkl8uO/M/jKjnIVXMQ8iw353A3UHiVqCsQxkCt?=
 =?us-ascii?Q?xRslf8OvEhuX18CPoijesDI4VmOPWpLOs7FVq7MZJbOBbxHriSDjxkphTZs6?=
 =?us-ascii?Q?sJ5NJtgxgHgi81Kd5oHEIQgSCQweOYgGUMJcP7TdWs+uRG1VgL62HujItUK5?=
 =?us-ascii?Q?q9NKixbWNL+k1PAqEtnalSLS0c1sb2KWZHiJXI759Ihd3KfHWM1fNj/AOhXp?=
 =?us-ascii?Q?Bv7JyG7nGmKOoSMBTyX/GEtsox5DKLdUyvYdeL9XmaBgZGDnBlahqJd2OQwM?=
 =?us-ascii?Q?Yzj4GWtj2G33p+tI0xNoouaO+MizuR5rFFJeb8SjoeXFS9A8jzBZKG/VO5WJ?=
 =?us-ascii?Q?i8xM+YVe6xsaSydysw8t5y+KMv6fUFZtxDez4kCCwA/84rEzsOfGcs636Vxh?=
 =?us-ascii?Q?7fExd2tOiyoIt800xdCSNXG/jDJC5ncNYfIkIciDiPS8Ehs1LAw53UCFd85o?=
 =?us-ascii?Q?mdQ8lI8iAPA3k99TAsyKYJm1VgGKC2FspZc7je/by5B6HV0OvOIbIWP8WYaN?=
 =?us-ascii?Q?I6Oc7btJzqf4dI4LWl7I8sgdG04JjY/PVsOgRWrjP8WV3SRncAlXar4gLj6z?=
 =?us-ascii?Q?TR9PYOTk4POu8dyX3khULinCoABMlaEQrn2fYKKHdo0Cyc8xL5XIPhXw2JDd?=
 =?us-ascii?Q?0El8ymwuHB4ZddU1gOso+zmcY/jKSLXR0hY0DSQ58AwrEPBJuYRN0mgOztQn?=
 =?us-ascii?Q?n61twELtyGOSSJLu4NewpDjtoalkABilG515P9+EjLFKGCXeA8TRdk/0tKBS?=
 =?us-ascii?Q?ePwrl3Z57Lgif+av8avaJHRLYuoUb5zLd9buZk5vWRNc3lbnjxjf+nvUWzgu?=
 =?us-ascii?Q?OOb78gUQdaWmHSeKBXKz4mEzc9n0CzWjobzsnx1zTP/8KGPY3vKj00JHboZK?=
 =?us-ascii?Q?/nV9QUN5O4twJaXEfJjvAK3Qp/qvhmAXvlIFZ9NF5aUNoPSIEShmeheGt7Uz?=
 =?us-ascii?Q?yzzRloB9c3YQkvFXwwAS73ioXDeJCLLzfPx2jrLoNbnhdSv5/WU4NKeLsF7N?=
 =?us-ascii?Q?0qCACqC/ZVOwQUGPtVzuLJC6XiVplW7EfhtkpwgCvJsaxhf4CneigGdIfAOC?=
 =?us-ascii?Q?Yc6xkyfEUx0JyRBGLHgJntMxqA8lEmwxkBtkoG8z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637268c6-04c6-4cab-a0d9-08dcff02ce35
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 08:04:29.3903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2wbJdEBnpbOJqA7hv0x3CfIPfokIB5zksG89DpDx4wqcWD5C29rA38mnDOOeG3ZmIMfX3N1icssN/6MYsBPsJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Xiao, Jack <Jack.Xiao@amd.com>
Sent: Thursday, November 7, 2024 15:39
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes12: correct kiq unmap latency

Correct kiq unmap queue timeout value.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 9d0e342a2f81..1ce935e684c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -550,7 +550,7 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_m=
es *mes, int pipe)
        mes_set_hw_res_1_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
        mes_set_hw_res_1_pkt.header.opcode =3D MES_SCH_API_SET_HW_RSRC_1;
        mes_set_hw_res_1_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
-       mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout =3D 100;
+       mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout =3D 0xa;

        return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
                        &mes_set_hw_res_1_pkt, sizeof(mes_set_hw_res_1_pkt)=
,
--
2.41.0

