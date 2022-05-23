Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43FBC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 May 2022 16:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4497F10E3C9;
	Mon, 23 May 2022 16:48:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A44C310E3C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 May 2022 16:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ix8ch7X0BDUyWc+euSOaUTC7CV/v6AHzRh+MPTqGaIAy6g/12zo3nrzKKDeLUExGsJgsr3q4F0XLVgUYyN4lAx6BKi8lTPkYLXPGguEg3YwuK1V9mI+3RgSnE8QNfzsXiYe8C90cstmGDSxsSwSTK91NzIfyZHiD91Kgwg/oVKHzBxQvk1w9vE0/bGcYDZcoqihb0aLHCFG1Jd8nT1NYqOqpC56zPQ2bazBUQ71KmG3cUL0SeDyQxiC30ZUSGoKcKOCfWEmtQpg+W266NjQZfQpUao1u/+TjiSsHk4ALetFIjluMYhyzr3YZRZQvCrC1vkrCh4rMdiQUxtCT9MJObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRfdVQ3QXJdM088fcFOYkzHcLPdDj2BdXrB6Ic0soSA=;
 b=ZM5NCCkzviUgT1E0X6QHl0Ty+BSxrBHB8V9afQl5nmGlZ3LzqDC3pgHJ/eASdBsAp/B90VQLa/8Ghctk5Gvna46a5PJ6grh9G/cNqTrN8e1dH9i8NVaeNlgarlYOJx9R9N6FIGkJm/r80oT0YDiAZSzERpzYCy511ub6ts5qBWaew7ZpbbgdSD8FU12G6gKHPUEw5zkVxY87XKVBm+PxDZtu+dRJ0FX9Prl5zblpi8kCk+dyvDj71+jZgb3lN46Z/1U8aaBE0BrsXb7PypM+DXyDfEGo6m9ja+TzbysUcLAKkOvLwsGAf+dLwMy6zJCmg/1SzRx+MPF2lLvHxwApYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRfdVQ3QXJdM088fcFOYkzHcLPdDj2BdXrB6Ic0soSA=;
 b=BlEsMJhCE6aDgbLVLG33Oy6YnKlc4FYvA+WS5NQ9MQ2adUU2mV7Xm/DH6zYXBqc3jxC4IMT2yHGUf2NG+ddLvbh0VsbJLWBkjdQ2yTstvep1N7z5PDNKHQZnjjyclX3lBvEfyxO4X05TS9zbin3TmSNZq38mB524HA0+n8oZo6Q=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB3388.namprd12.prod.outlook.com (2603:10b6:5:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Mon, 23 May
 2022 16:48:28 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da%8]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 16:48:28 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: differenciate between LP and non-LP DDR memory
Thread-Topic: [PATCH] drm/amdgpu: differenciate between LP and non-LP DDR
 memory
Thread-Index: AQHYbrtS5ZNaNrSO3E+S3T1cSqYaoa0srD8Q
Date: Mon, 23 May 2022 16:48:28 +0000
Message-ID: <BN9PR12MB52572B4367E42D8AAF9DDFC5FCD49@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220523153919.1558019-1-alexander.deucher@amd.com>
In-Reply-To: <20220523153919.1558019-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b31e56d4-97e1-433e-8699-f72ccf86982a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-23T16:47:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2fa3fc1-2078-487e-9172-08da3cdc1002
x-ms-traffictypediagnostic: DM6PR12MB3388:EE_
x-microsoft-antispam-prvs: <DM6PR12MB33884AFF4AAF0FB58AF683B8FCD49@DM6PR12MB3388.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TgJMQlUOc0HzQu2pg6nKZu3UjVdFHuMzIj2ZxgAWCJDyvOTJeOjFIN2tA+4+CmJxU8QorxgNuBDlVMCjlXLJ3AN6kjfuCjR4QnE1Z9BAfuhET893BnFE/v2Ma47bc8li2YZRq0d8sMuK/mX1KwNqfxdGsX0kMLrA2eXO5kSkGNQ3ZXMf3ssKNh29zfFJHAdqOMP+IGoULf/A9Eo0AX1yfzMPUUDmgFv+0ipSIN6QLGLMEGi0lnOXv01GCjj04M7K8MOd3J3mK9p6OCfriE3HMwfkedykvVUKVs5pynJ7HN8xpnnh0BD45L3nbf0/Rwk0nc/ykXrZvfferyDMg3ajnGw3BDRaTNcXXuPPpRzsBPyYKlT3wLXVbJ/mQHVbQPnQu1zsf9svfll7CVFzemesUKaAmMqwk2t/4IGLjmcWilZgfZC8MLr+ACogNFQYNUvn+UXzUQsTfr8f42/lfZH1gEcYJnI4VgyyLemmjKeLrbd9/T/2RzoHsBHmT4bF9SPhjxwIJ9fDDI9KlSlyOTNje3Rc66/Ks/ttwZxQ62UXzZIzXPThE3Fpi/cqRI7Hr2mGbXsQjzLKA/psHD2NIhNOocJ8IHVqLVhJnt2ERIz7ANxxb00zC27opSDD55usESu38+dva5kfUwPO9oc8WfBuJ7HBeDAu0PmTsHHVMMjEeXe+LbSqAc4xVSZjnZnw/Opki6/jH7pCfoOAkwYefxVG8Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7696005)(38100700002)(38070700005)(122000001)(55016003)(2906002)(110136005)(53546011)(6506007)(316002)(26005)(8936002)(4326008)(8676002)(71200400001)(66446008)(66946007)(66556008)(66476007)(64756008)(33656002)(186003)(508600001)(9686003)(52536014)(86362001)(83380400001)(76116006)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hrnEZ6yhVi+3w4BeOhwJCBwAxM84jn9743miEmd23XON5EjvTEHVtzb7UjL0?=
 =?us-ascii?Q?R0zAZcSJt0a7zcuDtrcgGJTRmrrFitQi6Sraneg6vT6CzqMO8qTMDqnnTvZj?=
 =?us-ascii?Q?6hXiXnhRyK0yzwOhqZT2Rae0fLhzGhRKmN2Z7Jalv/DkFYU2Bdy8uyQv0TD2?=
 =?us-ascii?Q?4eyMq5sz2/eLNU9PHi5kbz7SwfB99Kw51p3uL02uv8mgJUJ0VeXFYcT0lDIP?=
 =?us-ascii?Q?lvw/e07r6Kqo+W6/axd4zPWNaYpXbbvHpJowzQ+Xt87CRyfflZUkuxdZ65Xs?=
 =?us-ascii?Q?cLqW+lQvQfQj6sfY4eFmN8iYgWo17Mp72w4igobX+cK+BiXdDrrZ0tNzd5yg?=
 =?us-ascii?Q?1yHRYtN189K2ebmmBoNdmDuwcGJBi8GNhtB+OQ9PiozcxxThbrThJW0Rwjq5?=
 =?us-ascii?Q?OLGJf7Qx+FDqxS877Kx1WW+LE2ZiagrN5CCwPJ1vU8EMhmtcOMHsppUcacbS?=
 =?us-ascii?Q?oZx5NymxXxZpVJP6PuYoSCQn3vcan30m7O+2gZrVgZ/ixNWEIjn0pQCUwnq0?=
 =?us-ascii?Q?fUSxoG9w2/c1in9xPStHMXyK4DDK/S4ziTW3rQM3sy7xBAmMxmmepegz7cfz?=
 =?us-ascii?Q?VyRbfi9FyU2RD0Pk6yHeB+QXcosIkCZwSqHTtnSxUIRN21OWp5w+ComR09x5?=
 =?us-ascii?Q?TwtBPcFYXzpxhj8WRoyJWDsJBJBQM8d5vghXkNyHZpPrhPUNzNMOjX6tH7e+?=
 =?us-ascii?Q?mcHJ67oVr4e49dxq46EqR8qwZ0ZX0uMI+TjsGnvGBo8zZlZ1Ln6RLj72bJRq?=
 =?us-ascii?Q?HeCwh81J/RYB36lp8TUh+eHfp+qtQcZXB71H8U2CxaFR4FJJViGo3LznNmXy?=
 =?us-ascii?Q?5XeP6iAnni06xWE0KeO3A6TE6lUf1SUoD3kBlFSbuh9WG9zZHrV0UDQSeWJK?=
 =?us-ascii?Q?ywgLbgAHvUKRxy5AdQt0Lmue6sPtPmNXGo6PPzH3oe+iKnOQT/d4BHCZ9Ygm?=
 =?us-ascii?Q?0D3bSI56qy43f2JNp3/EZGJtx7TRbZuga53ZRGq88OBlAdh3gOh3zZ5DtYZT?=
 =?us-ascii?Q?ypVhOPv+ZYRhpBwM2byMEnQfy3Fq9sl1o731rmLW+IQKeLEbZhetSQ4zOfZS?=
 =?us-ascii?Q?7Rv0ox4ImKzYbySX+AY9Gx37C1fP6eqrvJwRFNmwsBosEY2W7zmiFQRhoPdj?=
 =?us-ascii?Q?I1xnjhUIXsSjcH6Gzy2csS1laYDS2om5gvZQZnn3/NFbUk5V2u/fRNmLVihY?=
 =?us-ascii?Q?5COINbO78Y06182bESESDuiOv9mwkly1MMY8KTa1efhv+el0lyrg88DCvh4j?=
 =?us-ascii?Q?ROdkIsjQj5hYTGB1FXWeBDb2zR8zIH4dr1dkz2XYM+T7VMrbHzmunLP1JYzR?=
 =?us-ascii?Q?smDr9rEk8wsURhWVNDz0V3/RDAFPwZb9DKM6I+eW2N7bhciObRRpFUnvLtfQ?=
 =?us-ascii?Q?OfnaMIOhxV+gvrVQJQeJ8JhqXfZ8AY6Fy+RexcMBePZUCGAUzVyicQvI2Fa8?=
 =?us-ascii?Q?m7rmsjEfprqPRBhe3b9gBGtbkZFF7V92fe7VJdVb8x1slmha2xCCc980eWC2?=
 =?us-ascii?Q?9at8pHXw6FMGxxIEnZNs82qTu0+rfcmb8M84YrLQ1+fhbBQCcAwXZxZ8hJoL?=
 =?us-ascii?Q?OEttqghMGpJWJ/iXbpHc8v4IYmM9OQ81C51nt/8YMK3eDsVac7tYJjK9CeV5?=
 =?us-ascii?Q?Vm0yCczp7I1192CJaEBUru5zTJEP6iJVLk0LhAGNzf8Kb3BsLc8EEOaYxAr/?=
 =?us-ascii?Q?jE30Kt/kcZs3NdbWnhUncNxcpHVI5wiqMokFVhyqMluKDFAb3hIdr46KdaKi?=
 =?us-ascii?Q?ov7LWaOE7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fa3fc1-2078-487e-9172-08da3cdc1002
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 16:48:28.4797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEXqDX8xDVIXujX1ffvixAjeEqO9uqI5sDeRJqoW3euV0tyImIpPqM5Ri+JUXgZKq2iLJMKFMnMUcAwRssxjyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3388
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Monday, May 23, 2022 23:39
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: differenciate between LP and non-LP DDR memory

Some applications want to know whether the memory is LP or not.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c       | 4 +++-
 include/uapi/drm/amdgpu_drm.h                    | 2 ++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 63e0293edc5f..fd8f3731758e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -188,13 +188,17 @@ static int convert_atom_mem_type_to_vram_type(struct =
amdgpu_device *adev,
                        vram_type =3D AMDGPU_VRAM_TYPE_DDR3;
                        break;
                case Ddr4MemType:
-               case LpDdr4MemType:
                        vram_type =3D AMDGPU_VRAM_TYPE_DDR4;
                        break;
+               case LpDdr4MemType:
+                       vram_type =3D AMDGPU_VRAM_TYPE_LPDDR4;
+                       break;
                case Ddr5MemType:
-               case LpDdr5MemType:
                        vram_type =3D AMDGPU_VRAM_TYPE_DDR5;
                        break;
+               case LpDdr5MemType:
+                       vram_type =3D AMDGPU_VRAM_TYPE_LPDDR5;
+                       break;
                default:
                        vram_type =3D AMDGPU_VRAM_TYPE_UNKNOWN;
                        break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 2780eb5b533a..0d3fd1db5474 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1020,7 +1020,9 @@ static const char *amdgpu_vram_names[] =3D {
        "DDR3",
        "DDR4",
        "GDDR6",
-       "DDR5"
+       "DDR5",
+       "LPDDR4",
+       "LPDDR5"
 };

 /**
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h =
index bb50644a2129..3a2674b4a2d9 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -994,6 +994,8 @@ struct drm_amdgpu_info_vbios {  #define AMDGPU_VRAM_TYP=
E_DDR4  8  #define AMDGPU_VRAM_TYPE_GDDR6 9  #define AMDGPU_VRAM_TYPE_DDR5 =
 10
+#define AMDGPU_VRAM_TYPE_LPDDR4 11
+#define AMDGPU_VRAM_TYPE_LPDDR5 12

 struct drm_amdgpu_info_device {
        /** PCI Device ID */
--
2.35.3

