Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97ADACD98DE
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 06:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3109910EC6C;
	Thu, 18 Jun 2026 06:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ukDuqtaP";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C4110EC6C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 06:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQI9Cm52yKUvr3NeeLr2AOv4RzZnuvnitfdMQMJEp/FcpZQxFvbeF1UoZqrr8uk9rZOwaRfffTUxL9k/24wd+EEHvtkz7b8Le5YKagH6QwbgBi7Fy1+U0QTIdwSghe2zcvZ01KXL5rImxDQpxBfWp21Dqz9+jOdqa06dbQLO170hqeLQgP31XjbIXXz6TH6LMCdHhmElActqkZo2sPCw/F0NflbsAeKShQnAUiFw6zRYDM207i4gZO4nWuEzwwineYpZAXkiT8eznt5wEXToABA5MPkphf96rzt6MiOjXQnS/X4M3bzqN4nvz+Vg79Ssfq3NrU21BvszIC+ERp5L1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7T5+LQw1giDcDCm8qQeoa2zeddDEdtgzw0HiWtFy/7I=;
 b=wqHpQbMaIXH+lI8L99IohJItdxCWPVLl/tmBRAZDJBL/3GN8aY/xPDcLVHNS6e2SU1a3pmeXGEWb/ZPmTP7uEQDvPSTU2Prki0s4fI1rH9A1ZXgSgCtu4hthxAP2Ig4SLXOT4R9ICr6HDaGrNOG9htBug9Q1ZMR1VJYPAovfNt3NcSkg1E8IYQfdZL/n2sm5UQ9N30JiToCuGKjWC5a3hVDXynMRvhYJrishL7cnd1wa6r4OoR4ThvD8aKm3CjmIj5GiAFOqpl4GKcCUN4upw/V6XpL0IedwXBosXzh0WPzqDrSLbRWbGlY3IAMF6dZ0bW6nzfPYkwxOlFqtAjteaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T5+LQw1giDcDCm8qQeoa2zeddDEdtgzw0HiWtFy/7I=;
 b=ukDuqtaPymzEP+7tiJ6Ka9pBTpZjTbUHWOaB4VoOYX5bo8EFjOzJM4IMRqRXr7j1DSzCUTfKryTlsM+fn0+hsQrcww6P5OUw4wVOV6LdKz2UA440Mes6weKS48SikEEA/aZCT6ljg22bTIkfROH0tf3rZB2zJ/pLeP1mjpOmo1E=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS4PR12MB9635.namprd12.prod.outlook.com (2603:10b6:8:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 18 Jun
 2026 06:11:01 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 06:11:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang,
 Morris" <Shiwu.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: validate XCP topology counts before
 division
Thread-Topic: [PATCH v2] drm/amdgpu: validate XCP topology counts before
 division
Thread-Index: AQHc/uF4Ij4ZVQHe+U23kOpWqWlZu7ZD1JYQ
Date: Thu, 18 Jun 2026 06:11:01 +0000
Message-ID: <BN9PR12MB52574EB044016CA7931D668FFCE32@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260618051205.3130057-1-asad.kamal@amd.com>
In-Reply-To: <20260618051205.3130057-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-18T06:10:34.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS4PR12MB9635:EE_
x-ms-office365-filtering-correlation-id: b65496f8-96f7-485d-7421-08decd005f46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: RNLZPcHmYcC6g57qilyKmmovufGlvg1qqxNJ8D3PYINqwM7X7U17sUXQ9jz02MFMM6gAFb9zssWfj9hnfqD6eypnuIR8RhUIdJ9L/T4haaUY4Tmg6B/sgn9hjUzcoxZ6hjoRFzB15x9oGACwtjG7LYG8XsLD4BZw94NXO3BENFxCyc5gtAlmxFgKt4WOnghG78lbCBLuSOplQJlJsvoGd1ld6sEPVdcTAklcPD78by/KfNZrjT2p272hxcTA+C4kbCnKlliMOTBRjIbmHE7LSnE6iYXm/3XZPcIc/E7Qi1LzhR1cdvsjn5o+/Rj0SO2LlUZfrcUdibiPOoW2cFItI9EG0Ft3BYMN10YeWFY9RM/ikb0J1jWH+N/JhjMKgYkA1kViFeGMsrg2q3vkPnqwiDa1yhNjxJJXVd1JtVW2n0IlbUUcNaSnhzCsVLAGYyFUj5du9t+u4lBwAPjJxBnBd1UxssBGDF1ddkEKWD253TGACCbpEpm36Wld1wiHBYLvnme5aPSANEp+5IAwyf+Gzxztlq/CP/N53TJVRauVk1Nxm6s8YoSnqNIBD657SP2mPr0x7KWpbP7LY/AjMZdt8DWptnApR7CiGwYuxuFVKfBa4EqzJ2fORRuorb0MILKUl9z1jfylDReNXAcOTY5V5Il5k/6ixzfe31U/iBjQgQicE1OSb/OcAXh42G/rgT2f0zdlsrtLLT7sQPTt84SgJoeUoGThPg6/PJ+uV6EOng34Kg+ppdjLgPttEt7dgMAk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fQjKo2jqKZi1hQlvf8rpvlVO8Isck4RjSHsXx8S9SjOc/2FSKfoq6Cak35FD?=
 =?us-ascii?Q?6VY5gs23LZJkhGnIpuYG8/Hi5ePrZisTcfWeH4EGepHneN6AUBJc9XI/x0vw?=
 =?us-ascii?Q?aZ4tR/WL9A1eIIrpOaqFFg+7j1bPtONepfNqyKJnz1/YdwkLQzslAHz7Pqax?=
 =?us-ascii?Q?3SB3BhR+Ww9/icEoxd/0qs3y6KqUyuSGrJPzb6FDAw7h/Z2oqMh9uZ30edsH?=
 =?us-ascii?Q?EQxSi0SbxrJIUsdjhPClTbAhEi7pLxsZMUEGROQ+qwP7QLUghOJS2HF5ojWm?=
 =?us-ascii?Q?3TNxnAJWltmC+9s3IBVhHZIEoON5j91+NYWZ0vJNcKuZRrCVAeevxd4Vr1+s?=
 =?us-ascii?Q?x0c5rkR3z0coYk+vDqvMtn0GIRjOBsrs0uKFq+WdLxnYBc1HBhRuBbFIxe3r?=
 =?us-ascii?Q?4IWQL7JE6qy8A8Bg3DOoL8VMb98ziJOabwBl6QPjgBZb+LtRcKqggezGmSQk?=
 =?us-ascii?Q?6LwSHUrVHVA2wjmRdyODGCckJZu8R90Zmaas+U+gvlVEJKAbArQQjMvqmam+?=
 =?us-ascii?Q?iP1QjVz8hKCEVq+fXND+x3ZkPrhkIOJHf7nGBWSb3V79atnVtKD1xOJfMM13?=
 =?us-ascii?Q?sxbMgQri8hwaSCYxyRjM7Ac3vpf7fLbGedTmADrPvKGVkijCiOtGmaIS48gU?=
 =?us-ascii?Q?qXkyu3rnXhUiWZSvONk/XlhPFNAyIFwZLS3Jk1qldOciK9T8AZxl4lz0QUcZ?=
 =?us-ascii?Q?jcnhD7pxpddtoeAHDMijbYMB7aeEoFyzvZ/UtEVjeN6ByXT/2277FoqLGOnE?=
 =?us-ascii?Q?dcKbDf3AQBFfTqzn6razZkfuePWT5MnuILcg+CBC9KbSt9eiRzcNyPEAkPFk?=
 =?us-ascii?Q?amzAAvHYKwnMBfScKv3WQXmIS1TWrla5tEEUgs1qglInO2c2zN9td5OMjorU?=
 =?us-ascii?Q?I+ClacIwj+sRsGLv6bQyD+P2ci7m8j22gnZeT8x5OeRQ8rrrh12NggECFb/U?=
 =?us-ascii?Q?HKcOQpdXatLyo+cFp6lyRLcwMo9QQayQsGVFpBIvOfZ80QzzCT0PSsT0TOwt?=
 =?us-ascii?Q?ATwpdw+mbAfZuoKddBvloSamXe2alEKSguvtMr5JFKQmN1hMtlue0Nr2G+Fb?=
 =?us-ascii?Q?p0QhBVA1+ZpS1w47CHWzvPgSvMAZdFPZuwuEgnRc+6jdnxGDMcshh7aCfam8?=
 =?us-ascii?Q?swKv0vE7eJi52+Xl6vOrJnDpSjhxixsmI+yye3kA2NFHjaj5ngxW1XOqyADb?=
 =?us-ascii?Q?Npojrim3Zm1/oWK17t3YiTLdCzVEc3Rwa8TJVoWviJKQqRQEWdB6RUPjjYaU?=
 =?us-ascii?Q?Wd5PU+rtkLOyCAEmTdMUKQuXsVRdpxkwIrvAQ3Qr6uBS1eBN3RTbbiLzHQ+k?=
 =?us-ascii?Q?YznRV6i2k+pm+gfpxjA2fnSGzTGf91mNDrMT+tt6/I7VOIe9zXcSgaK8I78j?=
 =?us-ascii?Q?cKBIVWEC8G2wjTkOYjaEWIO6k5y324AUHAxmr1ES0CqBoMBrXgbIY38BmQwc?=
 =?us-ascii?Q?gcjExWyBIkOqN7QiCHjOfd5e9UwgWkvWyotE6s28NfTUh/8OifKXCuCDkrsY?=
 =?us-ascii?Q?4Jg9UwN1Zze7Vv0mcOsJ+cJhFu3ocbergx7htuYrjJhe8djEyrvT+MKG2EWo?=
 =?us-ascii?Q?BanNVNwh4k1T6VVV8215n/d3Klld5RU1YMydw4f4GICkU02b7VyG17hqRsFS?=
 =?us-ascii?Q?oYqNfcygO7wVnFPP6uAuTNhJ+p0P8bBQqWVZ3JANScyyRJ6zel6A/VeSo6oI?=
 =?us-ascii?Q?ySWUfqZcPVkGFsZN+tdIefDHez281R8/fDLboNMfR91i+rlt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65496f8-96f7-485d-7421-08decd005f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 06:11:01.5233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sUoQMFzxQ6CoeGKLK/OLQGk/BQhpeN11D+fm8UaIS5IsdH0q1LYFxz1h1hbHhe7iKhwOulz/R3b86VTDsEmMKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9635
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

AMD General

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Thursday, June 18, 2026 1:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v2] drm/amdgpu: validate XCP topology counts before divisio=
n

In aqua_vanjaram_get_xcp_res_info(), max_res[i] can be zero.
When res_lt_xcp is true the code divides num_xcp by max_res[i], causing a d=
ivide fault.

Skip the loop body for absent resources.

v2: Remove redundant checks (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/a=
md/amdgpu/aqua_vanjaram.c
index 72ea37dbfea8..1c11cc280599 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -273,8 +273,10 @@ static int aqua_vanjaram_get_xcp_res_info(struct amdgp=
u_xcp_mgr *xcp_mgr,
        xcp_cfg->num_res =3D ARRAY_SIZE(max_res);

        for (i =3D 0; i < xcp_cfg->num_res; i++) {
-               res_lt_xcp =3D max_res[i] < num_xcp;
                xcp_cfg->xcp_res[i].id =3D i;
+               if (!max_res[i])
+                       continue;
+               res_lt_xcp =3D max_res[i] < num_xcp;
                xcp_cfg->xcp_res[i].num_inst =3D
                        res_lt_xcp ? 1 : max_res[i] / num_xcp;
                xcp_cfg->xcp_res[i].num_inst =3D
--
2.46.0

