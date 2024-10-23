Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0686FD0BB43
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 22:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD7FB10E240;
	Wed, 23 Oct 2024 22:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5e5Vmwgj";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD6910E240
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 22:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycfDawWIk+1tmx0Z/TU8/qpGel78s5Ga/C22N6oAtdRVP+WGreEsQAvUXXICxdcCGnZPD/yxu0hUo/b8CcK+/mTdnpMBxX/JbK6dxOIYwB3YQBEod6/G7XyMdKm1jMoYiCq38WeRBQYeTs9YnYE0Mqol6DZehtim+8FbFJzdq7h1n1RoGzLNaWiyewEY9Rgo2KAt4RPeR84yKZfali/yqGMfA/5BT/jGuzi9ELz1SeJ6wN3ss0E1UowTWIz6COs49QMJCCKhQlRoiP/l/hbl7WaW/yaUst2MM0+p8myWneNdt7kT3TtYmh8TtUw1tn79Jqhn9z0ZLTotIIhRosgksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kW3mLVM8hoapskb5ugHwzal0b6Cyaxxz3cbIsf9z294=;
 b=x3vmkzMZDK0TT4UyHyRkidgkToRK84GUfee1GePvkAxb3b4HVAtoZ4Stslu3TpAX/GUijRXCQIzwy8ABHWnEi6GUvOiwQsvFgZjFDDAYgJR4j4m/Mpb2K201o8KwLFPj1JYl9h578QlKyiGNpCxbZuE0JXwZrwKAI1pDOtXFwkNRh1EqfG7EfgR7rttXCsoLz36+U50m8iRebGQPt2RDXjcB7Ls8v7XLs/e3VVgUS0aOEdH8ljySoyPBwY+OJ8AnSy0g4q8Xe0gmQcUF9iGVdXQ0zLHkCQ995z7LnfQXWeJtV6IWYuyO+Os0lLMO+K8rQEdNqv2zvzs+6R3KbiQArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kW3mLVM8hoapskb5ugHwzal0b6Cyaxxz3cbIsf9z294=;
 b=5e5VmwgjExVCEmJODlql5LsDGugCm0rgIif/rGQGnK9bWMRqrP8eUK1bNnh5pVofGc9QIp8dm17Itgk9ZUMuoShAy+MOZgS7r6CtC00UxeudmKDq4rH8d38FQ4/sgpDZIZvKFSnBsAuwxU56Zt6urPX1veZIww7QqFOkCsQA8sg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 22:20:54 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 22:20:54 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Increase MES log buffer to dump mes scratch
 data
Thread-Topic: [PATCH] drm/amdgpu: Increase MES log buffer to dump mes scratch
 data
Thread-Index: AQHbGy74zIbs2tcenEG1FG4VDPMPN7KBxrOAgBEvA4CAAgdxHw==
Date: Wed, 23 Oct 2024 22:20:53 +0000
Message-ID: <BL1PR12MB514474636994F41952D1CB70F74D2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20241010161015.624089-1-shaoyun.liu@amd.com>
 <CH0PR12MB537294897F02C7B52A8EAF6AF4792@CH0PR12MB5372.namprd12.prod.outlook.com>
 <CH0PR12MB5372FDFD772CC7CE375A78E1F44C2@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5372FDFD772CC7CE375A78E1F44C2@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-23T22:20:53.385Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA0PR12MB7626:EE_
x-ms-office365-filtering-correlation-id: 3943e27d-6bf7-418b-d334-08dcf3b0f58e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/ODdgZiVVMDCnZ+Rd4dD5198y1B9i+l/Hfjp6gNenBYIyhKEh0xQoeAPtOge?=
 =?us-ascii?Q?qzfvq+9dC9PrYux9+tzh/jKaIdmYrr82DrjDchOzrehYtgUIe1b4IHD3l9vU?=
 =?us-ascii?Q?OwGUCKRAExCPCbWFYx6gPnZBRfUFwR4/ZQ+0wkxp59CtD7+7vXPnl99wA3fC?=
 =?us-ascii?Q?sE0/H6kHZBICO/smkIIL6hfVhsrp6/0odUG4+uTv0rkMhnTraxCdvn7823Py?=
 =?us-ascii?Q?SOlWIIsags5xn3LVJKJRDj9xbkegH+vVdl8/D33gtqCEaeQwjujaPRt3Xsm1?=
 =?us-ascii?Q?LdZEWCisPMR0/pRNvBRTZro6/YoaAUI2hyXj5O/RnIaPM7vjuU/ciAXORw1n?=
 =?us-ascii?Q?eUNacq4MbsPH02+Xdi1zZCyj7NX7vYXGPxgDprCSxFAFlWwT2b6v8+14Kuip?=
 =?us-ascii?Q?MIihB85dJXtwsbZaNRNqxZ5ps1PQSlmVquhXJYs7EiIk0WgADf82Nlc79EUB?=
 =?us-ascii?Q?sqcpuJuk80eQtTpKuk1bXzqp4MVYueaG4xZKB/ICsr+3LaMw+Mytm7ZRZGoz?=
 =?us-ascii?Q?zQ1VBSWlkJTW/XEUrX6/y9B7UW+Ty21ndWGVnfNMy1dXHuqnjCnWOn5MsBcw?=
 =?us-ascii?Q?jjci6ZIpR6YeIVCXOz3W3v+sYYxSp6O0hCe7J07yMyn1g+sRRqyu640PRcF+?=
 =?us-ascii?Q?p+95qGwfNxm/4TXr16cEh76xVBwF0JtF1xcKmt0Zdt6IqL8sqS8VX46uWX1u?=
 =?us-ascii?Q?X2IAp6si2M4AHIQsFD9PxG9E7GfqBxj3bfG0x82RPRAzm/dZtPXNpA3JBY+Y?=
 =?us-ascii?Q?EC4PgZTe6O2xQlq212QLqXqOaq7L3BzTUjHTWDgRdxm8qhVXU6+dSn2Y2WQE?=
 =?us-ascii?Q?ErOZ+H65yHTLdV18fkbN64ZbwAL7v9p8j9WzuHl78pBSgur/7bGs7HMkghp3?=
 =?us-ascii?Q?6Tr0/9XkvZopOwc8AdAsnYhR7lyeShMAdVRJRrcdbixKWd40sNtcuYQZoGw3?=
 =?us-ascii?Q?kthoZnXyRKMY8i5ppjKop3wO2bdQLCrDg/wTRV92Pk7o+aqATMSl3+P+LJqi?=
 =?us-ascii?Q?D4ecwLka1KNCRlXnPM4AxurqZjMnlKWGXNGc64GpF50PpkUVvGbm7M6kRjdl?=
 =?us-ascii?Q?OfhHwmxRlgKNOEjzM5OqSVLApsnaHJyXeuVHSWWuMaq3mlyq2k8K6DDnyqF9?=
 =?us-ascii?Q?IPulgHwEjnNK0sEDohG77JVehwzkCYq0s9Z46b9HBRp+cQbTFatk9+rgomCS?=
 =?us-ascii?Q?Uy9eFs/JuiP6scM4nxDIL9vJdi6Xvw2CXn45Bj6MgvmGqonxa6OZwFv1wo15?=
 =?us-ascii?Q?kZ4K6ibgzNmb/i4mvJpsIR4q9MYMUgGutr3mLMbKhk1cPdEkyec6qqvV7px5?=
 =?us-ascii?Q?jgfCrLgZbXHzQvHuplegToiqhUNoMMTuDb1XxoWc9fHxHHeUyPzjsEPyfi3y?=
 =?us-ascii?Q?hJleG+s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dulxlFbFvLJd1cyuYliI1mNmXIUFO4tRM+uQYyq+kSS6dDiUUjW61Dt/x+xh?=
 =?us-ascii?Q?QiGD5Ynwa6qnQRaaRnCpl+jyhqOq3GKjAbx0O3/4FaYSsX1toWvePaTGUIR2?=
 =?us-ascii?Q?ARK8qa1kmtt+HhXeKogTSaaCmZoLPhI1ACQ3Grh8k8NnRgnZzkh3LAbKXvXz?=
 =?us-ascii?Q?At7F68ESD999nLXZ8I9KqDWd1j1H+KwFDprcW5pkQppRZjT8R9f2EYATpsyX?=
 =?us-ascii?Q?MWn6SxA3we923iSawXOsP1KcQrK7z8yVt3fq59uOUzZB39+g4K8Lky9OoP54?=
 =?us-ascii?Q?CBkqg5u72UFZ7+s7BsCNbhwB5KM6h4+mR7wccRMtU17bT8kiIubkSHxHsezi?=
 =?us-ascii?Q?a8PadGL9QpWkJf4NDwOVDVS2wdXMQro6hpR9N+pEyF3dScudCR4bK9Y43cKl?=
 =?us-ascii?Q?+LO3QaTWXkFS6roq2HxvbTxFSDk36vV8QkIPEq8nA40CMxhES0uW6BTIVgSf?=
 =?us-ascii?Q?tuGkBsDUdsWQ94f7OmxYXpqvrMf3JpoqKVHHp9tjk1ScTMM66OLreyhNyfLu?=
 =?us-ascii?Q?B4Ic0Qp4cYB9ZHDHoCGFntruLzvQYfGY4f7oeZ8zOHhaJw0XRDa/xdFHzyU6?=
 =?us-ascii?Q?6BEfKLATSomvl6yWbsd6+0Mn9k3E5wNM5n3/D3jjGNNUDKA18PjBdZL/nXzW?=
 =?us-ascii?Q?L4n2E5OOgPXL+ybm9W1X4Q0j6OGgBkCPqS+52Gz837HHTYakhmjzCvfz0CgX?=
 =?us-ascii?Q?Wvh2zxVfDsRMNeweXTlk4hP6aAnURgNnh8tOmGmg7QtMY35pmWZVOi3aNl9G?=
 =?us-ascii?Q?YKMI5IY04nKfcpMKP+O4yWjugzFr4GzffbhnYEv/Hay1NWu2CWkERB5h37yo?=
 =?us-ascii?Q?NuWHR9VMytMZLHK66hY/IBxiynbrwcACnfWbm59+oj9PnQT/8Jki4LXqz8yT?=
 =?us-ascii?Q?Y08P+CCZnGE/9U+MrAFg+pE2E19iI2HFdYCnQx/fWSqsqOGeyg8HUBm/yH0O?=
 =?us-ascii?Q?mhu5qgqntlATSOKpEC+E6+HjYJBSXYgql3RKKp1jTkvpKEoLcKphU+tP1isB?=
 =?us-ascii?Q?RvE2XjXruydU31B1gr/XRpBemTEjdCS7fzApcQYklqpjQCnKyUghIAsCaeLI?=
 =?us-ascii?Q?TyCZdUZPj+n/rFEGPcg8ljMnuXXi9nD2FpXc4zUHlSc8h2SC4frx3dCgICBG?=
 =?us-ascii?Q?BqfSdd1WCOnneiPsLkFSrHhD/uqKpdlybx4HdhvV7+72stTrc+OiQUpvQkIw?=
 =?us-ascii?Q?pkx/Bd2uWcGuINIQErWUfeF9PdxXUnZ4O9JUa51Quki9SqVpycjP6TbbSFzY?=
 =?us-ascii?Q?WSY7C7eIQ+UUA+i/OhWTV2tj0zx5tfAxCNBD8+XZKlG0TMaHsK0hTwJnSWXJ?=
 =?us-ascii?Q?ch+t9AUHmzojz+eEewgG++oBjM9l8MH062oIPnxoo/tGRqt0sNDY0o+wf/11?=
 =?us-ascii?Q?N/bPF1eS2JbOjFGPrBKDaIoEujU1FFEPFLICzgGzFJEKU9om0zzALBqWY2HF?=
 =?us-ascii?Q?uGEKtboj0zAw/CSe3jyltYzCfPJwMYU3zywdDwmHSmLbHWq0jUm1nv9eWf+q?=
 =?us-ascii?Q?HkreVyLPGWCWxk43nEDdhvZr29ckOCJlgJFvBwLHlPhyXtzsrvml5pqe22ai?=
 =?us-ascii?Q?760aJO/3fyR3If1oOsQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514474636994F41952D1CB70F74D2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3943e27d-6bf7-418b-d334-08dcf3b0f58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 22:20:53.9312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NeJLpyquD7UkujJu0mSQtDCe8uzIOZv6qR1neUU/cb54IsVs7QJRr9km1DawflOfvWpi8zJ7YudqfqM839YF/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
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

--_000_BL1PR12MB514474636994F41952D1CB70F74D2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Liu, Sha=
oyun <Shaoyun.Liu@amd.com>
Sent: Tuesday, October 22, 2024 11:21 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Increase MES log buffer to dump mes scratc=
h data

[AMD Official Use Only - AMD Internal Distribution Only]

[AMD Official Use Only - AMD Internal Distribution Only]

ping

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, Sha=
oyun
Sent: Friday, October 11, 2024 12:57 PM
To: amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: Increase MES log buffer to dump mes scratc=
h data

[AMD Official Use Only - AMD Internal Distribution Only]

[AMD Official Use Only - AMD Internal Distribution Only]

Ping .

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Thursday, October 10, 2024 12:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Increase MES log buffer to dump mes scratch da=
ta

MES internal scratch data is useful for mes debug, it can only located in V=
RAM, change the allocation type and increase size for mes 11

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  2 +-  drivers/gpu/drm/amd/amdgp=
u/amdgpu_mes.h |  1 +  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 12 +++++++=
++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 83d0f731fb65..bf584e9bcce4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -104,7 +104,7 @@ static int amdgpu_mes_event_log_init(struct amdgpu_devi=
ce *adev)
                return 0;

        r =3D amdgpu_bo_create_kernel(adev, adev->mes.event_log_size, PAGE_=
SIZE,
-                                   AMDGPU_GEM_DOMAIN_GTT,
+                                   AMDGPU_GEM_DOMAIN_VRAM,
                                    &adev->mes.event_log_gpu_obj,
                                    &adev->mes.event_log_gpu_addr,
                                    &adev->mes.event_log_cpu_addr); diff --=
git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/=
amdgpu_mes.h
index 45e3508f0f8e..79f13d7e5e16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -40,6 +40,7 @@
 #define AMDGPU_MES_VERSION_MASK                0x00000fff
 #define AMDGPU_MES_API_VERSION_MASK    0x00fff000
 #define AMDGPU_MES_FEAT_VERSION_MASK   0xff000000
+#define AMDGPU_MES_MSCRATCH_SIZE       0x8000

 enum amdgpu_mes_priority_level {
        AMDGPU_MES_PRIORITY_LEVEL_LOW       =3D 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 03bf865fbdd4..aa2e9ef4ff12 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -913,6 +913,16 @@ static void mes_v11_0_enable(struct amdgpu_device *ade=
v, bool enable)
        uint32_t pipe, data =3D 0;

        if (enable) {
+               if (amdgpu_mes_log_enable) {
+                       WREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_LO,
+                               lower_32_bits(adev->mes.event_log_gpu_addr =
+ AMDGPU_MES_LOG_BUFFER_SIZE));
+                       WREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI,
+                               upper_32_bits(adev->mes.event_log_gpu_addr =
+ AMDGPU_MES_LOG_BUFFER_SIZE));
+                       dev_info(adev->dev, "Setup CP MES MSCRATCH address =
: 0x%x. 0x%x\n",
+                               RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI),
+                               RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_LO))=
;
+               }
+
                data =3D RREG32_SOC15(GC, 0, regCP_MES_CNTL);
                data =3D REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET, =
1);
                data =3D REG_SET_FIELD(data, CP_MES_CNTL, @@ -1375,7 +1385,=
7 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
        adev->mes.kiq_hw_init =3D &mes_v11_0_kiq_hw_init;
        adev->mes.kiq_hw_fini =3D &mes_v11_0_kiq_hw_fini;

-       adev->mes.event_log_size =3D AMDGPU_MES_LOG_BUFFER_SIZE;
+       adev->mes.event_log_size =3D AMDGPU_MES_LOG_BUFFER_SIZE +
+AMDGPU_MES_MSCRATCH_SIZE;

        r =3D amdgpu_mes_init(adev);
        if (r)
--
2.34.1


--_000_BL1PR12MB514474636994F41952D1CB70F74D2BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Liu, Shaoyun &lt;Shaoyun.Liu@=
amd.com&gt;<br>
<b>Sent:</b> Tuesday, October 22, 2024 11:21 AM<br>
<b>To:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Increase MES log buffer to dump mes=
 scratch data</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - AMD Internal Distribution=
 Only]<br>
<br>
[AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
ping<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Li=
u, Shaoyun<br>
Sent: Friday, October 11, 2024 12:57 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Subject: RE: [PATCH] drm/amdgpu: Increase MES log buffer to dump mes scratc=
h data<br>
<br>
[AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
[AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
Ping .<br>
<br>
-----Original Message-----<br>
From: Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
Sent: Thursday, October 10, 2024 12:10 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: Increase MES log buffer to dump mes scratch da=
ta<br>
<br>
MES internal scratch data is useful for mes debug, it can only located in V=
RAM, change the allocation type and increase size for mes 11<br>
<br>
Signed-off-by: shaoyunl &lt;shaoyun.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |&nbsp; 2 +-&nbsp; drivers/gp=
u/drm/amd/amdgpu/amdgpu_mes.h |&nbsp; 1 +&nbsp; drivers/gpu/drm/amd/amdgpu/=
mes_v11_0.c&nbsp; | 12 +++++++++++-<br>
&nbsp;3 files changed, 13 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index 83d0f731fb65..bf584e9bcce4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -104,7 +104,7 @@ static int amdgpu_mes_event_log_init(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_kernel(ad=
ev, adev-&gt;mes.event_log_size, PAGE_SIZE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_G=
TT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_V=
RAM,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;=
mes.event_log_gpu_obj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;=
mes.event_log_gpu_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;=
mes.event_log_cpu_addr); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes=
.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
index 45e3508f0f8e..79f13d7e5e16 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
@@ -40,6 +40,7 @@<br>
&nbsp;#define AMDGPU_MES_VERSION_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000fff<br>
&nbsp;#define AMDGPU_MES_API_VERSION_MASK&nbsp;&nbsp;&nbsp; 0x00fff000<br>
&nbsp;#define AMDGPU_MES_FEAT_VERSION_MASK&nbsp;&nbsp; 0xff000000<br>
+#define AMDGPU_MES_MSCRATCH_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x800=
0<br>
<br>
&nbsp;enum amdgpu_mes_priority_level {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_MES_PRIORITY_LEVEL_LOW&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index 03bf865fbdd4..aa2e9ef4ff12 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -913,6 +913,16 @@ static void mes_v11_0_enable(struct amdgpu_device *ade=
v, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pipe, data =3D 0;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_mes_log_enable) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC,=
 0, regCP_MES_MSCRATCH_LO,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(adev-&gt;mes.event_log_gpu_ad=
dr + AMDGPU_MES_LOG_BUFFER_SIZE));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC,=
 0, regCP_MES_MSCRATCH_HI,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(adev-&gt;mes.event_log_gpu_ad=
dr + AMDGPU_MES_LOG_BUFFER_SIZE));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&g=
t;dev, &quot;Setup CP MES MSCRATCH address : 0x%x. 0x%x\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI),=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_LO))=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; data =3D RREG32_SOC15(GC, 0, regCP_MES_CNTL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET, =
1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, CP_MES_CNTL, @@ -1375,7 +1385,=
7 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.kiq_hw_init =3D &am=
p;mes_v11_0_kiq_hw_init;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.kiq_hw_fini =3D &am=
p;mes_v11_0_kiq_hw_fini;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.event_log_size =3D AMDGP=
U_MES_LOG_BUFFER_SIZE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.event_log_size =3D AMDGP=
U_MES_LOG_BUFFER_SIZE +<br>
+AMDGPU_MES_MSCRATCH_SIZE;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_mes_init(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
--<br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514474636994F41952D1CB70F74D2BL1PR12MB5144namp_--
