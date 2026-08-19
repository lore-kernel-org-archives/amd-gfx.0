Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB102C5DF85
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 18:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 757D710EB89;
	Wed, 19 Aug 2026 18:51:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FoukTfIN";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012042.outbound.protection.outlook.com
 [40.107.200.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21C4410EB89
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 18:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+k6807NXL6L5e3ePxA7s6wMzItOOAwy4V3AAhEi892BO/0fcp5bt1vSm79+GoiwyetVC9HzOp9X/v7CZjIfegK7L5aOSMZK+BjbntQsvphD/SiwJ8Wzu4N/mpYH/hiTdw5GRyGqFkJwqmGyDQkXizQOdR2uIgJX5ZqmYgB9XUnlnsZBH5/kTLrt13ctUHxKTVPIEwHSJOnAxQ1+G/wSfy5tecUP3HolpLs8Vz1Q8hjNiAuFR35rOq2ZXkyQE6FiXRgYGtkXTEfTb8NGgxUTyTfIuy8r0C5Dh49NsesH7nr7THPE97lEnpHn8df8hbjEnuPjMvkUZJHmwcQcER24Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYqq8GhzYtwogTcOzeTHeL0N+2rC3Z9wVtfly7J0j1Q=;
 b=A//0ikGx2lkxs33irDHapK4PL5zI6E1yBA1Xz7c2/PlMpLA6WLcHdJ7NomPz59n4RTlB4LAlHpuWmHyrO1QL8pigXR13PiGoQZCs9x5QJ1B4zLdoCvVYXHV3TQiPry9ETXLvE95TErQ52vrmiCj3rAsME+d+wpvCpFJtmmFVFdzJ1g06wnZAiaVfs7K1GPgj2/WKWbCoP2+vtM7kwgqeQj7lQbQ24M0JzhZiJz+fjmnOdC9JZuJHxaPMIfPWN5iFxjpg42HBYC16gsKtljweN5wy8zvEKo9lbrnKe3InX3Y3mWxLMcC4xmEfmAEwzu+GYA8dOjfBR6b5k1DPQON/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYqq8GhzYtwogTcOzeTHeL0N+2rC3Z9wVtfly7J0j1Q=;
 b=FoukTfINX1L+6F9AP0rZZwiCF1g+zIT7sNBuiPEmfjI00fny99nLyUblbCBUvRjVcQzS8PH+1aiAo/SP0LRzNVSztyPRFe6UBPNyNwcnux960gvJZj1fY5qz/8r+nDhbSIcKhh2aZGzBoZCix9BK0YBXJaEBcC9ayRnnOR1lx6Y=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 18:51:27 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 18:51:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes_userqueue: add MODIFY support for SDMA
 user queues
Thread-Topic: [PATCH] drm/amdgpu/mes_userqueue: add MODIFY support for SDMA
 user queues
Thread-Index: AQHdL8+EXFCq0RDB+Uml3orBIRhVYralt7wL
Date: Wed, 19 Aug 2026 18:51:26 +0000
Message-ID: <BN9PR12MB5146938FA3451458BF032D79F7A52@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260819114001.718908-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260819114001.718908-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-19T18:51:26.586Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|IA1PR12MB8494:EE_
x-ms-office365-filtering-correlation-id: 506af424-e3ac-498a-a621-08defe22dfdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|8096899003|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: jqlEcmpkvfwvCZUiIi82tIZpNf2FC/4dVxC8DxbgpRQLsbdPJCD6lrwRTfx0J1fdfCThJR1rLWt6RQDIjiV2hJoguFDnDlrO6PCTpOPAkrP4CRkVeibzT4eDnvo21227VxMOq1kHNCdDNuRuYkiNGaMNwUz/mH4FagGI/g/ypvvRp6ymiAFHNdKZiKqGiCHzd3eErVP95lF2Rx6XEhrSoQjwMtKD7Ut0KbU6BnJRObuvWtCHXc4jFK5kgwx6odvC879BdZREk1hRZsqqA/TuKn9RoN3EOXlD6D+XWnFh9HhytUrYOpjJ2tgrjOA8yfXCqMebn8RCjWkcVfCH+HSHMREUp1Nl/T04fG8/QzVlJYMINwSE8VyvARqlVU1ivBTlNxkNZVhRwNRptMzFfJxzKz4bWJoLkW8la3QNNQmCKYAsrX69govESvoRz76ST8sXG3/l8h6Y5eYL8HCBygIajDSQAl2dv1LeN1DcCS0gfHniI4SI7CGd+GSiRB+W/zr+sgJzNc0cGJ2M9GSl7eQE/cSDMpp4zJ3SAUMl/Ak8e9oGm14uch26gAh9dCAi/YrdFS8EJCk3YgiKgW8bD5KdTgq3RjFTNYtijxp7IcqjwMhGqWC+KoaxxdXv7SqNezK9EqtP484zgwGpDbsNBpjhjP9/d10F12ODm2JpCOUisjoMpasfIgt8U9T7eChZViFTetJCSWH1+0ERjBY5p38CmLr0RhmDuvMvhZhlP6V/h0w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(8096899003)(22082099003)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w4NYd1GvdqFLidcT68/KT+kihrvII31wAsQ2xgEgmiHnN5MtQ8Y+y5dNhXik?=
 =?us-ascii?Q?i6GMtPEuQSUGdX8p6f2NIfjKbJvH6wFKQRr0Wf8MBmtSOEn+aS9W3m/CBMYN?=
 =?us-ascii?Q?VxuD5kqqdUufeoRPckvxKgr2nXrx/Zw/n1WggWrJwgq+Ah8yWWw2ez0oDKZu?=
 =?us-ascii?Q?LZ/RYIwGcluCPuxz4gPcUEAJzGFwS9uHhrIPJQ8ARxpjyLQ/qzLR5oZGmcg/?=
 =?us-ascii?Q?bfZXJkFbFI5K4WRalA4ADGifKbObjRdK/vIyrDk48RMXhZPO8UGsplSnvvva?=
 =?us-ascii?Q?8LftnCVnFAG2yCCzne2wk3EZTo6Gfx+WHTWqWq+TRJ8vdExt+dd3so5lx31C?=
 =?us-ascii?Q?ehWt9Cg+MMMnfLJYfCYAwvjTBjZ8wtvwR4HyGQtMh3vK2jjZIsRTrZsZBhwI?=
 =?us-ascii?Q?fB0YeTxA1H7MF3a325yvxItDzzbxz6GHLom7rDCDvTkj4bfBMupwfpsWUjv8?=
 =?us-ascii?Q?xbL+KrEdmg8Ll65Ve0nkceN8p4dwZ2MfSa/y2pLQqwl0pvyFQYvHpIjSQRli?=
 =?us-ascii?Q?4XfRI1Ao/6K2MDrGC17ttV+V/+n+VFxdFZLZzSUenrQdO+oQSzFZcf3pHPqv?=
 =?us-ascii?Q?5hVg1JqM8JVc9oh0TJfqye4lZWhNAhUyr/Ywb2ChRLNbZACJ9CLPmsvWHBXL?=
 =?us-ascii?Q?b4mWs+ews+jYmari2N0Nsp8n34bFUxwQ9A7lW2dgLNlpG8zEL7Wfg3oO6dtF?=
 =?us-ascii?Q?BhvFffD44AvxuuQr+RiouS0B8NvI0BDmi4cLG41r0SXHDVg5SN6AzXS6nnTJ?=
 =?us-ascii?Q?6VIUJXWnfQbeP6tAj9lYMGLz/dfVucOOXMvHAQjl3td/g9rOU65L+HQV9XrC?=
 =?us-ascii?Q?ZuJrY5VySAScHXRJhL4DA+b65VpCnV4t/W7XIthaWmOimwl/7mhQZ69Q/U7C?=
 =?us-ascii?Q?XuJd629Y02X0I0JHvmCfXhqGcr/MOmR+JKA3aaa83uT4x7SdphFI/C2hI0d0?=
 =?us-ascii?Q?pRYxWj92QCXw5cxiczYyYc3yhy/D73A/MmgJykKLm144q/gNtQoZyYrXv0vu?=
 =?us-ascii?Q?c9ktguTAMt339w+pElxL9baOVG5DNtSZ09AZ9+lskEZBf3Ikw6fE7IkHwrYj?=
 =?us-ascii?Q?CIjI/XLk9duQ6fTP8twJ4iz2tKSIK2VpXisYvJAzS0nhIrRZFgd3TZcPZ3rt?=
 =?us-ascii?Q?MB3/F1+FgzP5va38ZuQybFJ84Qw4oTHwNhzBTrN8Rw4+wWI0u3GrCkd5q4ot?=
 =?us-ascii?Q?Hsg2IASZDtc2vpadK04pTr4rJNmtBT4gKYbW94igepgxJ9uMFWdnycyIBg4O?=
 =?us-ascii?Q?JCkopud6QPngF44xhwlH6XWSODd24Rjs5mF57oH2kFusHOFdBBGkKvBIUhUx?=
 =?us-ascii?Q?CTKfuBkwSfP1ZI1wL2cT/MfQyYEKjEtWF7jlUHslB3rGclK9FoGb+PYNVHux?=
 =?us-ascii?Q?DL55jg0QHomWxIeT859V0K5rb+v4vyqll5Vu/N7MfVCEvEio3lVp0CJNpHKr?=
 =?us-ascii?Q?ua3mE2vepoqAJ9sDsHxD7lW2yg1L3u7QWMHC8e4Tx/X59k8IMg6qxTsiE5CX?=
 =?us-ascii?Q?BB2W5E7oggmozIIktEkkWY/OawlADeAnpYTR6Eal5eh9gHM/JwG1ubCE8Veg?=
 =?us-ascii?Q?6zOI3TRUXWV6lE8j28H8GiEc7T9Yso6hHUGN9qZcYCeknwh00cVyzJoet58y?=
 =?us-ascii?Q?p1SbiYIM89XHT/dFxG4WlMXHx4yPJCCA/z4dLXyTtULbBLoe63wNBZ8vI2Mr?=
 =?us-ascii?Q?TZ5lmfP0cYHYU0wg+mnsVtMGePkSqPzBuiEMbih5l1CJ3LoL?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5146938FA3451458BF032D79F7A52BN9PR12MB5146namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506af424-e3ac-498a-a621-08defe22dfdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 18:51:27.0980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Z8JPON9IML1VuxMYApXoTul5ZN3relYKv1dC/j0Uk1HhGjjtavdy2ezylwsqL7FONYIHrAiQUpETrsmgwaI+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494
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

--_000_BN9PR12MB5146938FA3451458BF032D79F7A52BN9PR12MB5146namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Can you send a patch to handle gfx as well?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jesse Zh=
ang <Jesse.Zhang@amd.com>
Sent: Wednesday, August 19, 2026 7:39 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/mes_userqueue: add MODIFY support for SDMA user=
 queues

mes_userq_mqd_update() only handled compute user queues and rejected
every other queue type with -EINVAL, so an SDMA user queue could not be
updated at runtime.

Add mes_userq_sdma_mqd_update() to update an SDMA queue's MQD from a
drm_amdgpu_userq_mqd_sdma_gfx11 (csa address, queue size and ring base)
and re-init the MQD. Validate the queue type up front, then dispatch to
the SDMA or compute path based on queue_type.

This aligns KGD user queues with KFD, which already supports updating
SDMA queues via update_mqd_sdma.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 36 +++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/a=
md/amdgpu/mes_userqueue.c
index ad72ced472dd..03f6b5ab32ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -681,6 +681,36 @@ static int mes_userq_mqd_create(struct amdgpu_usermode=
_queue *queue,
         return r;
 }

+static int mes_userq_sdma_mqd_update(struct amdgpu_usermode_queue *queue,
+                                    struct drm_amdgpu_userq_in *args_in)
+{
+       int retval =3D 0;
+       struct amdgpu_device *adev =3D queue->userq_mgr->adev;
+       struct amdgpu_mqd_prop *userq_props =3D queue->userq_prop;
+       struct amdgpu_mqd *mqd_hw_default =3D &adev->mqds[queue->queue_type=
];
+       struct drm_amdgpu_userq_mqd_sdma_gfx11 *sdma_mqd_v11;
+
+       if (args_in->mqd_size !=3D sizeof(*sdma_mqd_v11)) {
+               DRM_ERROR("Invalid SDMA IP MQD size\n");
+               return -EINVAL;
+       }
+
+       sdma_mqd_v11 =3D memdup_user(u64_to_user_ptr(args_in->mqd), args_in=
->mqd_size);
+       if (IS_ERR(sdma_mqd_v11)) {
+               DRM_ERROR("Failed to read user MQD\n");
+               return -ENOMEM;
+       }
+
+       userq_props->csa_addr =3D sdma_mqd_v11->csa_va;
+       userq_props->queue_size =3D args_in->queue_size;
+       userq_props->hqd_base_gpu_addr =3D args_in->queue_va;
+
+       retval =3D mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_pt=
r, userq_props);
+
+       kfree(sdma_mqd_v11);
+       return retval;
+}
+
 static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struc=
t drm_amdgpu_userq_in *args_in)
 {
         int retval =3D 0;
@@ -692,9 +722,13 @@ static int mes_userq_mqd_update(struct amdgpu_usermode=
_queue *queue, struct drm_
         if (!queue || !userq_props)
                 return -EINVAL;

-       if (queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE)
+       if (queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE &&
+           queue->queue_type !=3D AMDGPU_HW_IP_DMA)
                 return -EINVAL;

+       if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA)
+               return mes_userq_sdma_mqd_update(queue, args_in);
+
         if (args_in->mqd_size !=3D sizeof(*compute_mqd_v11)) {
                 DRM_ERROR("Invalid compute IP MQD size\n");
                 return -EINVAL;
--
2.49.0


--_000_BN9PR12MB5146938FA3451458BF032D79F7A52BN9PR12MB5146namp_
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
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Can you send a patch to handle gfx as well?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Alex</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Jesse Zhang &lt;Jesse.Zhang@a=
md.com&gt;<br>
<b>Sent:</b> Wednesday, August 19, 2026 7:39 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Zhang, Jesse(Jie) &lt;Jesse.Zhang=
@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/mes_userqueue: add MODIFY support for SD=
MA user queues</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">mes_userq_mqd_update() only handled compute user q=
ueues and rejected<br>
every other queue type with -EINVAL, so an SDMA user queue could not be<br>
updated at runtime.<br>
<br>
Add mes_userq_sdma_mqd_update() to update an SDMA queue's MQD from a<br>
drm_amdgpu_userq_mqd_sdma_gfx11 (csa address, queue size and ring base)<br>
and re-init the MQD. Validate the queue type up front, then dispatch to<br>
the SDMA or compute path based on queue_type.<br>
<br>
This aligns KGD user queues with KFD, which already supports updating<br>
SDMA queues via update_mqd_sdma.<br>
<br>
Signed-off-by: Jesse Zhang &lt;Jesse.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 36 +++++++++++++++++++++=
-<br>
&nbsp;1 file changed, 35 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/a=
md/amdgpu/mes_userqueue.c<br>
index ad72ced472dd..03f6b5ab32ae 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c<br>
@@ -681,6 +681,36 @@ static int mes_userq_mqd_create(struct amdgpu_usermode=
_queue *queue,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
+static int mes_userq_sdma_mqd_update(struct amdgpu_usermode_queue *queue,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_am=
dgpu_userq_in *args_in)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D queue-=
&gt;userq_mgr-&gt;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_mqd_prop *userq_props =
=3D queue-&gt;userq_prop;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_mqd *mqd_hw_default =3D=
 &amp;adev-&gt;mqds[queue-&gt;queue_type];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_amdgpu_userq_mqd_sdma_gfx1=
1 *sdma_mqd_v11;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args_in-&gt;mqd_size !=3D sizeof(=
*sdma_mqd_v11)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Invalid SDMA IP MQD size\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_mqd_v11 =3D memdup_user(u64_to_u=
ser_ptr(args_in-&gt;mqd), args_in-&gt;mqd_size);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(sdma_mqd_v11)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Failed to read user MQD\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; userq_props-&gt;csa_addr =3D sdma_mqd=
_v11-&gt;csa_va;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; userq_props-&gt;queue_size =3D args_i=
n-&gt;queue_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; userq_props-&gt;hqd_base_gpu_addr =3D=
 args_in-&gt;queue_va;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D mqd_hw_default-&gt;init_mq=
d(adev, (void *)queue-&gt;mqd.cpu_ptr, userq_props);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(sdma_mqd_v11);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
+}<br>
+<br>
&nbsp;static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, =
struct drm_amdgpu_userq_in *args_in)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval =3D 0;<br>
@@ -692,9 +722,13 @@ static int mes_userq_mqd_update(struct amdgpu_usermode=
_queue *queue, struct drm_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!queue || !userq_props=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (queue-&gt;queue_type !=3D AMDGPU_=
HW_IP_COMPUTE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (queue-&gt;queue_type !=3D AMDGPU_=
HW_IP_COMPUTE &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue-&gt;que=
ue_type !=3D AMDGPU_HW_IP_DMA)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (queue-&gt;queue_type =3D=3D AMDGP=
U_HW_IP_DMA)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return mes_userq_sdma_mqd_update(queue, args_in);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args_in-&gt;mqd_size !=
=3D sizeof(*compute_mqd_v11)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Invalid compute IP MQD size\n&quot;);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
-- <br>
2.49.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN9PR12MB5146938FA3451458BF032D79F7A52BN9PR12MB5146namp_--
