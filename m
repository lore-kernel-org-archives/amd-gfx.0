Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBE6EFCE56
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 01:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A7510E1CF;
	Thu,  5 Mar 2026 01:21:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mZ/5n1U3";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D50C10E1CF
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 01:20:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKyy4l39E2PxqAze9+fYEgZPAr3qFxUvDezAQJQR4qzgou6akPGuBH8ASO7JebM+m6mA+vRnOe1fp9RAknXz4zpm2dqNnUcaQ2Xdp1PbiIllm3YJwIgrVJDWyyqSa9KOMiQqz9/JoAeTu9PD/6m3ZEZm1uo55cf1xEYgfjQ1lbxCMDxpg31ua4hjFjFy14WDlHiIXRCjMBd7ImtYdPcnthpyAs2ry4UtF11rol4l9IqEyXjBqAs0oF/pGjBkLGv+k6P8Efu41WXAk2BMPJ08jZ8dCVKDqGmX9SrU0qZoI7roUrWDHm8tupE8EnsTGpXgjsgbvdZm7dzaNKU7HIUmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jS17SD83D3Hiutj+DUf9Avv23hwdVLeS0yL+kRp/FxQ=;
 b=iKgjC1JdXMt6TdNyJxRfiQqHOSRMS4tBc8IzRWzFfOYK0GOmTXZU9U1EL4MWcQ56J/gA546oczJx2U4/S+tKgL/k0gcW9hYZL5uhHH0qsUV9yw8cGIO1bOfvh8dvpJ+ajNvn3+C17kBqplVouJjZZgUGfyIW7OUjfRNPjbf7TTZCNXKYS7eV4yxDr6ckCo/vkg7fAxV1MNnSc24+Hmsp2rOuJh+pHh97quoEbCaZTGqq6FkqdnzhXOz97Vx1jfep5sevm7RpoNQK8hu7Oz90wITGd6B3AZOIxSpUolopAzmJe41rw9kmx3mvG00AbzYj9F75joX1YioZeDilKcoHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jS17SD83D3Hiutj+DUf9Avv23hwdVLeS0yL+kRp/FxQ=;
 b=mZ/5n1U3nkigF5+P8NAfZXQ13qC4bSssX0oXU6Ha1Zb4bjfarCy1AzGajYc6tFYX6BdDbSd2gEELidSxyYxQKxKrYI8civJW4pYQBYLmibpTPwYa1zdNlLLfWdnalmg9YAe+Uy1aphnrS1CBNtaNYI571x8jUHWiNWi9v7xTE38=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 SJ5PPFA5F0E981D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 01:20:51 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 01:20:51 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix gpu idle power consumtion issue for gfx
 v12
Thread-Topic: [PATCH] drm/amdgpu: fix gpu idle power consumtion issue for gfx
 v12
Thread-Index: AQHcrD1dRhNckWxuVEqZvahyrGd5iLWfI+ww
Date: Thu, 5 Mar 2026 01:20:51 +0000
Message-ID: <DM6PR12MB2972994E2E3531359D45C2AC827DA@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260305011342.925550-1-kevinyang.wang@amd.com>
In-Reply-To: <20260305011342.925550-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-05T01:20:07.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|SJ5PPFA5F0E981D:EE_
x-ms-office365-filtering-correlation-id: d6641b5b-ab9c-4aaf-824d-08de7a55709a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: 1ST+nRLDutwPX7sFnHLuZ4VTUq/d6Ukd+1AZjzVko5h77tZnhDaX4xz8/TdZEM5h6jeVxWMZi162Ik57am8OYhsSBFtvjNdW3H+3GMFjyVIse77YmBYOsexhBL4GUPNKP4qlmpUSPaA4t13X2foRkzcR9WKAcrJo4+A2/BozTRavgxrHNMUzM/B4qRK3O9ks5R9AtystTV1+HG6mQ6bBIAp1aKGNwxRbSk25v/W4vRdivqvJu1LN05hjPVmt1Yq6m3t6kgAF6OQv0SOpS9048HcjWaznzmToNITo68ENZ9UaNOh3ybTrsCuAiBigkXRcmhnOa1l3ZINZ31ZL3fWzm/C4DpQ/r9bnBLDUmIz5b40cxGAe7c7MFeDP+0kOR214Ro3+8/h/rJ7fuHPP7Hcp9EvZ41JsqnxmRY1r+cYWdtqPAulktzZqV9h1PjnK3wXrXQT/Ba0Jp8pS1dxsUqUZ/khdg6XsYwY0lipcdcJgVnJHwTsvibAluwBr8kXFoVfLbOG3JEjeEyq/xSTD6ZBslIp4HskqZKiC57M4XssIasHc2hrJEs0C9FRJ48+5ibsEYP2nPoh6BV7MMec15p9KS1w/j40Sniw9XI67uZmyh14QOtk1Ch/UmOoNpL9bH4Oimy7t9Tr/TTILpmHXDojJPPkhCPC8+SnGwc+64CgWqCvMzvtDtihVVRLM7m1PjWcK3mWB82uKSwb8TaWXFv7mop61hlfPy+89XxonH8cP7tOfjsxZnbst3V1jIpjhiwaYF7CVo2kUL4m5sGyWck3iMHF52Zps+LXXy6+ju8v1Xm4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VBG53XWG4DQhQRu1IgCMgjGNkMGksZeQQHX/afdBHCk5YFbX6IBmUaqDUSj+?=
 =?us-ascii?Q?P0mfT1KSL4B9E2KIiskbXW7YOZMJuE43EIdj8hWBlEuukliU2z87Z6XQsvPz?=
 =?us-ascii?Q?jXb7iKEEMCLASoMEZZyj8jrPvLpbyD7iDKV0bNJhIMGqoi1Hgi4JpWi0U9GV?=
 =?us-ascii?Q?+d0pEi5o7bUUzcN8HhBeFQQfPg2xw/b1wGsHj8G6TBluAxpk6ZLgCpVMyJhu?=
 =?us-ascii?Q?iCLMqeQpf5JNSJegKvuvsb7NlDvIf+tP2z1qWZdv/mveuWRNRASf4RPLYue8?=
 =?us-ascii?Q?7vNfdgFYClNVOPdkavQZfrVwdKWmJOQ8TsWh8ok/nO2GHdvmUB404vMwm1Dj?=
 =?us-ascii?Q?NjpZCu5Kt+QSLIs2mmEOCkzjY0oFNHRkLVBBR3n32KW4xw+PRsNM3O8HIMOF?=
 =?us-ascii?Q?LRqlhJIdsGF/16BCIf0Cm+C52EmdtT1f4OaErigCQh+XVIR0Qgkorsmsonbm?=
 =?us-ascii?Q?orjoTP9RqV/iz2o/JcCvLgue+XTuK2yVr5W0rdPL+5Bc17RiIAbNo5MU/2ll?=
 =?us-ascii?Q?zJ7iCTmQ6kLfVwF04cgrDLGnAryfvVSWRehftN+4UF7UbcJbyFPS+AwogbGH?=
 =?us-ascii?Q?sC46yimj12yeZXPvsa2OAAYDqgwop6F+SOOcWdONt0frg88JRwGglxbwh/2s?=
 =?us-ascii?Q?CR+MnjM2KfwKfYWZWuYtj6UesUVAmHzUJDMtgVZ1y44rhIkMNnE4OWtsvRUT?=
 =?us-ascii?Q?/D0b+/NNqfElcTqzvwVIapFPmcStZekQFoIA6QA5Tb+4eSOKSkB+svSPF5Df?=
 =?us-ascii?Q?ohpEokk4uoClHt65x1ZBBvN/upw4mpo6jv7IFmAJtb2i/uzgapN7E9EERcEt?=
 =?us-ascii?Q?LLnqVsELDHpKEAs1Jfnt8bpGDLoNZBRsga2O5+4nivzgCXa/LthSVKdTfTEf?=
 =?us-ascii?Q?b+4TjRIc7aSM7Od3KMjanwwaWqie1X2MEE53eETuXBoqpFlzb9qtLOlFvVes?=
 =?us-ascii?Q?A8OdP+55fISoIzOl/5nsIHUe9DVSLyfl23/xoodWZ9EkVHzKz3PQClvF0EoX?=
 =?us-ascii?Q?Aavju6xb+NCgddg3Yg77IdlgoDQ1caPBAbriQ8wPP6OfPAZISDFuXbV7b4hc?=
 =?us-ascii?Q?SBQGo6GcZJyZrYmLSw2jMfzkssW5PC+3zhmKG5M1Zg8/9VgZB0kv22HMp9TC?=
 =?us-ascii?Q?yQmVQVcSv5bveItkSB+SeboJco0HyBeIDuXlriYjbh8jVkAmTC77lWJZDg4j?=
 =?us-ascii?Q?aZ0gQChRsgsMffTBv19ssoGv13zwvhWs5eOt4cjUyek7OwbTIWrEcXxMH3ea?=
 =?us-ascii?Q?+PACBZILye8Wjkp/Mv/6MYHtHiaCdEJTfMzBx/1n5x1H0/iEWhKvipVADJbq?=
 =?us-ascii?Q?qczv11E8nrSCDvjonY3zQFyzOiKUfWb8H2RinUnebJnda8Wnv4WYFLcxpdln?=
 =?us-ascii?Q?WruywgNelkSMSo/6VHXmnxGMdlPtod7fB8oN0MfsHNhiMVMsd6EVKjvOaGZd?=
 =?us-ascii?Q?IbuFJb0/Mkk++uWG/RRFTZCG2Z9Dln5I3gQbkIBT2ziS4aHtWcBNZntL8web?=
 =?us-ascii?Q?vP2PNgvXImpSkYkZxX2ptP5BxhPsx5e2i3QSc3PkQPKeCGA4CBKw/jnLN+T5?=
 =?us-ascii?Q?v6m2XmC1ndMpDhs0We4BRuRj9q6/O3bheHepYHLnmWOMqJkgw2PV9OsymnED?=
 =?us-ascii?Q?f0lEcucioBaZfVc0hUUkBqXiBVRrb/W+jVAnc6oV78HBnwxkEw0gm7zwKXH5?=
 =?us-ascii?Q?fIqZpsjy+1Hv0E7Cz+hglqbCawX3FvRXlC6Yursr/cFa0yPy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6641b5b-ab9c-4aaf-824d-08de7a55709a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 01:20:51.2680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VikpWK/xZH3Y/5CTzATilzdnJU6buzcc5OIsJ65uYPuXHXf9ED23NF/sG6kcKXU+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA5F0E981D
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

Please ignore this change.

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Thursday, March 5, 2026 9:14 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu: fix gpu idle power consumtion issue for gfx v1=
2

Older versions of the MES firmware may cause abnormal GPU power consumption=
.
When performing inference tasks on the GPU (e.g., with Ollama using ROCm), =
the GPU may show abnormal power consumption in idle state and incorrect GPU=
 load information.
This issue has been fixed in firmware version 0x8b and newer.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 5bfa5d1d0b36..6584ade3b3f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -731,6 +731,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes=
 *mes, int pipe)
        int i;
        struct amdgpu_device *adev =3D mes->adev;
        union MESAPI_SET_HW_RESOURCES mes_set_hw_res_pkt;
+       uint32_t mes_rev =3D mes->sched_version & AMDGPU_MES_VERSION_MASK;

        memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));

@@ -785,7 +786,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes=
 *mes, int pipe)
         * handling support, other queue will not use the oversubscribe tim=
er.
         * handling  mode - 0: disabled; 1: basic version; 2: basic+ versio=
n
         */
-       mes_set_hw_res_pkt.oversubscription_timer =3D 50;
+       mes_set_hw_res_pkt.oversubscription_timer =3D mes_rev <=3D 0x8b ? 0=
 : 50;
        mes_set_hw_res_pkt.unmapped_doorbell_handling =3D 1;

        if (amdgpu_mes_log_enable) {
--
2.47.3

