Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D38C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 07:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD04B10E977;
	Fri, 14 Mar 2025 07:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P/4/rhZx";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D085D10E977
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 07:36:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPpvDud09bOIf1NR0GBcWNSo962KrJ4EmDPF0Q4+6HObSOUyIsXJgbma/w3m6by65JTSVLxY0OnWI4cd/l/KZT63W3o6Hmy0TkdiAZCHJI082wSw0hIzYkk7HxxiiyxQbwLP6qzSrFd3NVRIibZG3bJzVHdJrwpSxZ/LTOU0GjSdFTDYR4chPRqHYfRnjKKX/MpDzHMHO7zGUMWWtqLmrKWB/a8n+Xz3lKHaEoclu2sFcNCeSCz8Qw1mL9xTyVMMO4wChk8z4V7O2aK2h14FaUDZacg/zwJRISVtu2/nwm8ckg1LabLfUqx+A0QJY7bQ3j5ZqZlOI04PJt45j2CfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQoWulyw4sIPU7tpHXUsd3LtYk0fqeR19eAMCiRdpbY=;
 b=TL5k76J+GcTgUH+MWH3Aep2TJr+Eb+VzofO+wz2LGWGD9Y/p5T4m8yDu09gT0iBz9Ggw+Ab1I+0002ZXWq39DWx8SIvLNmd7ZqPHF1Zwe0tnAPxSuZqN0tVPikLiB6K5PTXiWJi4XT6Y7NjVDfmTssvd6JCN2OAB+jFTgdp/9DytiMDIqw1i1e77UiF4FiyTOKtBiT3jBb41Y9bGoad4a7UUtYRRseMusSeCw2how+nYeP59CDxP51cZb6lbQ5C2LZ+iJD6an8Zb2jVhyQzz5m2Pceu3TeG9pp8L8HhjLIXuQ62FQSumYGJY/yZqSmf5hHy9DE8lbMYTAE2+qd1Tjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQoWulyw4sIPU7tpHXUsd3LtYk0fqeR19eAMCiRdpbY=;
 b=P/4/rhZxKK9GaWBX0QBvIySBE9kif8ByIIJSfIp72bJPj8mrkcNV8B4uaUN62dQY53QqroOhIuErZ7JHX85JMmedzK4xGBIS0l6gvktxPS4S6fKEKcEvAeVkPw17YegZqjKcAWeB9WxTmf9xR/zaxtBSxR5WjIFCuPx6BEjZOtI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 07:36:37 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 07:36:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add active_umc_mask to ras init_flags
Thread-Topic: [PATCH] drm/amdgpu: Add active_umc_mask to ras init_flags
Thread-Index: AQHblLNwJdUmL8PWt0GdkVRvGRcdprNyPiiQ
Date: Fri, 14 Mar 2025 07:36:37 +0000
Message-ID: <BN9PR12MB52575A31D8459FDA9807034CFCD22@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250314073317.641951-1-candice.li@amd.com>
In-Reply-To: <20250314073317.641951-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=89cd4fa2-b183-4499-bb2b-73e398ccf130;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-14T07:36:20Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB8584:EE_
x-ms-office365-filtering-correlation-id: 4d87e8b7-9efc-435f-7c58-08dd62caf405
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FnyVG3tj/nDr4PAWQDLhk0vLf/q3GMc2nCszWYLBfQY/XBmUAUt7jUGzyuqx?=
 =?us-ascii?Q?0r+JbM/o4A9IZaGMFpCaBPQfjV4WuKTZZMZSQGjaeSlzpnnT1RWtxyL1CT8L?=
 =?us-ascii?Q?v2V5CUKU/heFa8HA0SESU54/zvgDLwam9hiBTQJOncpN3QvmAUcAzb1ukPVU?=
 =?us-ascii?Q?Osa2MvBFLhqEvu4viXWkSoelaiq0H+4YpSvxHVday02PSITD3BLcicjFGbLF?=
 =?us-ascii?Q?RKpKCVILvwD+vKsZ7hPzBrRmkExQDVRdvEsR7zQJ/vZ7FJ5Kfaux4pgHlM0E?=
 =?us-ascii?Q?//BJlIQ9AI6q7sr/rX6wx/4JblWx530WhuQ00JJpUYuU+X6SqMVq+44HTmOD?=
 =?us-ascii?Q?29/f6XSN7dXN6HYf/sJb9491UymgZsYAMr7P4LLUDoe97LR5YecSzv8x6W8s?=
 =?us-ascii?Q?7C98oWxprkhUp/rJuEAJYKlS3DbdgUqcELP0lPbTQmKZk5A1aG6vDWq0g4Cf?=
 =?us-ascii?Q?qE/HaEW7QEiKYtiHXOrjqyUWUcESUGocuNfHWdtQ1zlJAvYMvY7HnOynKuNu?=
 =?us-ascii?Q?rhuXAtVVnJb8FfYC1sqxFiOL6Ffw1dWCIsXENqO30ClJPrvDR6PbtPlAd83K?=
 =?us-ascii?Q?LZimsaJewujtQZzV6mDwRsLuzPTnL9Ie0lfbOTcPHWKZq4Hx7zgqhmVgdATs?=
 =?us-ascii?Q?c8cOcJTpoY0/fd3/St5kW1DBhvhSjt0Snzhqg328zAwrBNJgxe/cBAD3tE7e?=
 =?us-ascii?Q?2HmeqYAXrKEuw8Nq5cRJ2Q9N1h2MH0DYfe2bDF1uNYNvpk89+YiVbMXRzsGG?=
 =?us-ascii?Q?pLVSGTu9Nv7FmogQI74M2JhJbcORCVwxtXzi9lAZef9YeY10mqxpePY0/NuA?=
 =?us-ascii?Q?wNgafYoyuawcsIuspxYsKR9vyTHyNdcALM+kXBdbmLj+oT0QRt8FuU+ofO+3?=
 =?us-ascii?Q?DpFtNJyjRfMvN9Q3S9mTnHiuoU/LlOIjKac04dAd+hcqflfJXjSpWUzBmTJy?=
 =?us-ascii?Q?CIJtXv8uH+mCydTvToDTh3C6H+zsjNer3GvR+aG7FkGwTVGDttFiu796Acaf?=
 =?us-ascii?Q?4AK7p+6I2VUMpZlgnaLlNzdAgTVjC8lvj9DKH6je8t6nHx9eCiNLEWiaw8B7?=
 =?us-ascii?Q?TdI/vj+uCagA4e/g4LUR4ZPUXVIUhPYOyakgBSWAty6XRtRtuOPiTf2hrJlQ?=
 =?us-ascii?Q?TDbtZABGvi/6PIpH6aOvRX1AHZjxJEmG9CZmScP3ct0lAtmBBfaye+tQDcNJ?=
 =?us-ascii?Q?xP2e0S8ZEQz+nmrbkvoLQoyhfzsydEWVJ00fgTQZNENneofWTF8Cl1kuoeCr?=
 =?us-ascii?Q?l896e3jV7VV8ljVWXyqgIu2gczUIYU+dFmzRZiojPdIMAamsa3PSC2Hb4+Yd?=
 =?us-ascii?Q?WKTUslH5Z70JN3IO5CBBWTNtTlFnsfakNj3l2OmqooHlCAbUT64LexKNd/l6?=
 =?us-ascii?Q?AdBJP60+V9HkQbWfzDX/MIXEL8hXfABqVs6jQ7osow+hJRhjfruln1M4NZvi?=
 =?us-ascii?Q?mO6hskRsIyK0pCH3V6+G1Ry3HPj6Whgo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3rzWMqbI0ZBsAao/05Grr/aWJlWT9rOplp2tpcwHG51mpC1EjBzrXxN1yHch?=
 =?us-ascii?Q?upU5OTXFfHTCmvHdhhwO3Qhbmyd+puBcAk/kyIqrooCFCzhVFwmhF5OAG3Nj?=
 =?us-ascii?Q?PxGwBszZWGBaNFm0nFWqgGjd9uhP9/ZYzM7YqkLRH6pvoHTtjMUHGWIREzUL?=
 =?us-ascii?Q?BVNtpdCi4yjgoOgR+ZFSsqXE1zqAt/5RV/j6MVWVKOKScLVClLyAWkmazSVO?=
 =?us-ascii?Q?NZwfvSNtWkwxds4DJZkyOhZRBfw4GONdnYLVB+uGUhtJMB/0XwLJGyYVxCSO?=
 =?us-ascii?Q?PL/S40Op+joJYBOy5iTSlB396bXhjOCOeJwsrdocCK3ro0nmQbY58Jpm+I6x?=
 =?us-ascii?Q?yBhMlOz8zZ9wI+4soM39KPv08gdzvif1+LSFIwhVefsnNgZ+EFr/cHCaUCYB?=
 =?us-ascii?Q?joCRI9ZmlcQH/YDRrJkqhH1dVY4emzDSr0+ZL/w2v2pQPTYMBDw/XslQwZOc?=
 =?us-ascii?Q?+oPRI/BLhD2xKuGzH9A2N6yJNVbmvj60NY8jZvTnYiMnawCGq5ybHeIrPzYB?=
 =?us-ascii?Q?oGQFq+e6kA01AAriEmdIU4DqeOQJGKz4xT7o9Y7Qei5kqOinCDfkZBNC6tEY?=
 =?us-ascii?Q?mD+RbhFKSjZRqVgRCDMjXHali7GtaamWd3v4rIx5LLpPs513f1hM6BtzRVr1?=
 =?us-ascii?Q?0lGQMdZ/dLX1RdFyWGX2F3VWKW+e5mDG8wVWvlMqiF5Z2CU85fisSHFqKsu8?=
 =?us-ascii?Q?ciga6s2BeJdg3ylMHCXFzHJETIfn9RokH8jaCFcF+uLYirg9dTthSkcZpha/?=
 =?us-ascii?Q?r5EvNm0jpslfrXsIuqdaAyiraxcpCEXlQdW+n3/F5Kp8TBbrmcXEG/WcBDTT?=
 =?us-ascii?Q?28hh7IopuUotza7cqDTVySZ8q3cBxNbaXZc4xdlaAwuwpj89CL4vbsN0ueGr?=
 =?us-ascii?Q?6GCPN90JJypspMW5ecUfY7skCjbSyU/kUGl0XmsHJP7Zwgp/6yjTpuI8PuCZ?=
 =?us-ascii?Q?fIXZBg/0xCAlslMaZCuuquIipTP2GPXZXft0tvgF6PwzPCnN1OaU85fURDmc?=
 =?us-ascii?Q?v9jdxlUp1aB2/WJlbOwudi4Bzyuv5mZGzn+5UzdGs6oSZ8DjF+rjV02FVqvH?=
 =?us-ascii?Q?0kDhRAlEedfvyHw3zV5eTDwScegdHfAPgCUd4rtQyjkHr+cEbaCiUmFIC9+D?=
 =?us-ascii?Q?XJOv0CwZ2nWV0xcTwQzxwaJgoc+dL7YvJm+S2OsQcLqN1scZu6AA4+JuclKF?=
 =?us-ascii?Q?nz9M0hm9NXhK8g8V5ToCx/dl3gHKDeFV04h4TdTXlGdaSR2e2qWgqzsFVZUM?=
 =?us-ascii?Q?PP9eWONuI5YcyafhK+uavBVfZ1iWxNINGZJUpQ71/CvS0bGGinWSbcMyC4o8?=
 =?us-ascii?Q?nx61a3GPuT0JOjV99Q1pJi9hPc/S5Jm+Bmf1jdImjrqGLsj7j+U/bK/sSzQZ?=
 =?us-ascii?Q?FpoB/cjEvf3qXYCCJTozd6sea4lybrSbpLMET/+HfAmjAPWWB8Au4UHQQp1a?=
 =?us-ascii?Q?WlqJQvUmaZJYaibd+Q7rKRFkmQ2MKgvIHVOyYIHEkiUb+hjD4RRuFwFicBhw?=
 =?us-ascii?Q?K3tqBJc6yh0b3VXNwFiFEeZgOkU1cxW7b+fSuktDWTlT50Qeo/wjvRPPAA5h?=
 =?us-ascii?Q?vbgf5VLbgRFN926l/W1g0ydU89pdhhvafgXjhGHz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d87e8b7-9efc-435f-7c58-08dd62caf405
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 07:36:37.3188 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHtPBmXI1ZL/YXq876ZlLGG4bPxI5nF1smr1PiQMoW96Gdh87xs4+E1DDLwYTheNjrNLAO5VfKsEVyAsotInbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Friday, March 14, 2025 15:33
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Add active_umc_mask to ras init_flags

Add active_umc_mask to ras init_flags.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +  drivers/gpu/drm/amd/amdgpu/=
ta_ras_if.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 79dad75bd0e79f..d3b05b7020c84d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1861,6 +1861,7 @@ int psp_ras_initialize(struct psp_context *psp)
        if (adev->gmc.gmc_funcs->query_mem_partition_mode)
                ras_cmd->ras_in_message.init_flags.nps_mode =3D
                        adev->gmc.gmc_funcs->query_mem_partition_mode(adev)=
;
+       ras_cmd->ras_in_message.init_flags.active_umc_mask =3D
+adev->umc.active_mask;

        ret =3D psp_ta_load(psp, &psp->ras_context.context);

diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/a=
mdgpu/ta_ras_if.h
index 64891f0993666e..a3b5fda224328b 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -151,6 +151,7 @@ struct ta_ras_init_flags {
        uint16_t xcc_mask;
        uint8_t channel_dis_num;
        uint8_t nps_mode;
+       uint32_t active_umc_mask;
 };

 struct ta_ras_mca_addr {
--
2.25.1

