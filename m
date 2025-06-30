Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837BFC7EE30
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 01:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8B0710E14B;
	Mon, 30 Jun 2025 01:20:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xs4OnuHe";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEE3F10E14B
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 01:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Doysi9CV2hVK/WxhH9Lmk+RMamkMvKn2Oyb/EevQDZz/eywgJfhpdC3MA57xmzoEX5LOghWV9jHQ3dJl/hi9kaSs+hQDKPquc9uQFteFFnFaRVNGEfbq2glXTOcFRKZdfIpd4ALv3/WdinL9kNojU4zQDzyFuCFxSbnNYjkSB3Yo9uSpbon7eeDhNZmGvWH9PCpuNJFI1TyPeIl1BBK0V9pNZDd1LW/zQCddlq4kind46MRWgQhI5biZzIUd5sTIhU7Glfb66xCCQ085HL70aATYBTM0bRE2kQfjyDlPthPwSgaiCxb60s5ymSWGYylug9Xgz5HWlK/Xlm0vIUMrLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5duDhbIqDA6LECWVFCm3meZqf04oTjDg5KsVsg1XM18=;
 b=IxvLdIZmAOWd0Y0RvVfy/72jb5P8+R11+O/NBimGgc8vqMUt1wpYtwvjxVxxUhTMR5K//vaWGGraVR1MSj3jrM4rIOij72dgULotMa5XMzJvb78Hr087L5Oy+4LZHklyFVpj+Aa2fF3ZoFJG2BEC/eZsPZ+azPSz40C1I0dc2vnZYuix9FMf3V/5gPg4uaKR3fvdKrE2u1TG2rhP2WP7mCMi90USwD5daP7Mesb3V6wfnrvotSWHByXy3gIVhnsvI9pJatKYl+U6fEYL9PrPpuQn45haLCkYysC9EYZJxk81PkQ7eNVWuBPdeKSugZLXBlQplCeUDLZ+3BX33wQF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5duDhbIqDA6LECWVFCm3meZqf04oTjDg5KsVsg1XM18=;
 b=Xs4OnuHeNOds5kIFEombjpT6iGUHLGHWup4j73d7I4lQhUWxdnkx/miNveeO7lp6mRzLRl8O8sh9LVHsem2JG9vFNcMNN/9BobMJoh2zQq8FeTsfC3RGSOR6wXB4RLC218QEYmonHzNCL9xrLbxSUS00qJQXajunWVa4yZYgRyc=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 01:20:24 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 01:20:23 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sdma6: fix user queue firmware version check
Thread-Topic: [PATCH] drm/amdgpu/sdma6: fix user queue firmware version check
Thread-Index: AQHb54MEKF9J3D6aC06Q19RF/NxfjbQa6z0w
Date: Mon, 30 Jun 2025 01:20:23 +0000
Message-ID: <DM4PR12MB5152B8FFE4803D09FF1C5A0FE346A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250627164558.27382-1-alexander.deucher@amd.com>
In-Reply-To: <20250627164558.27382-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-30T01:20:14.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS0PR12MB6438:EE_
x-ms-office365-filtering-correlation-id: f810e714-03aa-4587-d5d1-08ddb77449c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8C6Szv+BVxi3CBpfVgrZq2+lPUOB2fJO7nq2YM+eijmSr/UXXwsTmi96Pgmw?=
 =?us-ascii?Q?hqZKr/qHM3qA0hdrIE8VLOxU3TsqHtbj8k3E+9rPcGfyes1zsJ3MsafMTBpB?=
 =?us-ascii?Q?AFqqN2EW4fyuF17Wp6uG0nqJEOdWZc8B87Vhgjs8epNJCM5QGnCwdl0D9Irw?=
 =?us-ascii?Q?k7yuYlsh7q1+OCVxs+nxyYSMR5piu1n2QRYnSXclLYaeX1QObEw1lHLV+F1d?=
 =?us-ascii?Q?eR5P90V/6167KTRXhMbgPR/rpWbfGtTnHvwuGmhUvLvXaZu6k6KWmXuzJ7av?=
 =?us-ascii?Q?aSPw4uILAI7aPXMg3iqaNrsA8bTTnlEJsd7TK5zpma3F6lZLJMqZ9O3N0+G+?=
 =?us-ascii?Q?p/r/jEYLS0et5gap1EEcF5Y8U2SwDBSMdvxlLQwwh/WPZd0a8K+ABbJUw/VX?=
 =?us-ascii?Q?Ku9REdScp5BvmSJwNmmFEkBVtqCbYY12p6NnoWsGCYimoZpQVpq2MjCGCyV+?=
 =?us-ascii?Q?0OSqEezjELCGChAgRIk5ZFcNXepatOvxcgKZOt51OfV/XEhrpa9huHm5Bu3Y?=
 =?us-ascii?Q?GY/GZb2RuHusKD+a8SFiqxG7fI13yTSL1ip8IvYuaiz1Z5Ip0MG+DvggXe3u?=
 =?us-ascii?Q?1+/D+5ep+zWsLRKAXQtXb3v1Gqb/0Bqzb5EtO0qhd2MNOw/b19tk5+h0XPS+?=
 =?us-ascii?Q?jQiQOjAAqm+mS+7HV7yPHYlFwV1qKtvLmzWGySKY/4n7o/Ai3VtIe7A50Pfe?=
 =?us-ascii?Q?aF6GSEoPYD5+Qfd1DcpNs7SFBFEVxrrknTHickKxzfAcMMhw22YUJK5s3P/P?=
 =?us-ascii?Q?YUiCnhgMjb/yvgdVbe8LVcLrJz73u83MHuEQTKzMrsVys7qF29xZlc/+MJFN?=
 =?us-ascii?Q?h6QYpdLUeDvR6osSats18099n/pV4fvjN1eO3SEhjYvg7kOqo7NvPuBWtJMu?=
 =?us-ascii?Q?EtKyByHOi2/Tka4/jIQbe6zJUnj7sZXD+vjbcKxdab2k2uP/oDiOZQmBfRV/?=
 =?us-ascii?Q?7epCkewP4iIvVoF+eIKS2Zk1rLZLrVfTvn4C0H0zPSBV0MMmhPtiJfX5cjoI?=
 =?us-ascii?Q?0MSpUBFOet+kmkEwN1455gMXmHH9cvRQQgahO/SaCxHHvlmQFoDI2Kug4hn5?=
 =?us-ascii?Q?lWlEWU8LuPZj+oUdaqyraVvwe4YyYy8axhaPiOE7LMYdnx+zdxYGN+r1HoMl?=
 =?us-ascii?Q?ImoDgEgvtFLwO7969uCn5XrnXT0C0UAKdOyTwvhPhXSoJs7/QKNh2oBSSPlX?=
 =?us-ascii?Q?zI3775wuYDlxi/AZBEnV7Slp9LqGjc8tSN8//iAi0oiabMUECGcu4c2q5ZWR?=
 =?us-ascii?Q?tui43ZI/Bp3Y6aGRpzQIm4heEWH0ABfwtXP6GzYG+D+TP0JTkaPckPAKthnZ?=
 =?us-ascii?Q?70m6eaaTiScoozm1lB3UCEzrBF2nHcSAxrnA0zjXqjv72xfPT80tSUQhFq4W?=
 =?us-ascii?Q?OMPKwI823LMEXgcmR7QuznT840eMXsoaMCF6sHBcV6Q+sAcs+BNXy4oYILpv?=
 =?us-ascii?Q?7e1y14Sxg4Z/hlr4r0emk6kpVuV0Z4BkeSgIk76n4wCZzBVJ9K1FOA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Pcv+Aaqir06zm5h3qbDQCpkqHHrg5b9QQv+hOVmcDxnSAta+N/W8ZG2sOlG?=
 =?us-ascii?Q?ZT52CLSJlrJmBodOL+gEgvziDEgvshYuKSfiLwAaQl6kQQPMmgi5vLvtDLB6?=
 =?us-ascii?Q?HoY2fOz9QdQquB2faTMUX60JH+kUkBZ3TirC1vXU0N/xnqVBOUy0dckfyqfQ?=
 =?us-ascii?Q?4Ir78xkj9p07N124w8scf+Ge7ZnEBzUASd0WNc7uSTMfORV5XLYarHOYlrV9?=
 =?us-ascii?Q?bW4xtJKlQL2nx6lyXWH7M/P8IfnVsZdSIqgpEFV1AJDu3rnDaWtfZmycaCmp?=
 =?us-ascii?Q?lQVUD/8vHvQbPcnItvqQIKwg//QDsXlOtiQTwKG5PCzZGmGYdCbSJrUldpgB?=
 =?us-ascii?Q?22W/D18/4hpO6LEoewnYKGdv+i81VA+W+yreKAwl+6H4w8pPb7KLX/+DWvYl?=
 =?us-ascii?Q?Tfxi0Rj7L+U6pxOi1T3WUbag6pUbgUqCMVm0tj0Jq9lzZVf2uEXZCDRU5B5C?=
 =?us-ascii?Q?QMyn7ukypu7vntooDfv+G5z2sHLS4ud9O8/xY3j8gsRambE4HIvuv+d1nsbo?=
 =?us-ascii?Q?LaAA0i6e++j6ERKjXtNEm4s7YSLqAF4aODo0nILv1IVOxekDsRRnbQvdaeiq?=
 =?us-ascii?Q?6AsvMPyVWf66k3YwELCNXx5KDDCPBJHyGfrDop+kNQreWsR7dgEunlZNJ7cd?=
 =?us-ascii?Q?V7Ic0+O48AZ/mLy16qB0o49BIoP8yZTru1i/vIPEFwrmHULMisj9hPs3Uwk5?=
 =?us-ascii?Q?Ifiw1/QyzxupkI3B6MNK3Y+P7L+iE/t2InIzUL/zTV0I3jAfwP8rCEEqJEx1?=
 =?us-ascii?Q?CWHOQLxu93SKge4Oqs3hzSDIzov4P+adg4C5UABZ+mY2cq/EBNhZ3DuJ+u5I?=
 =?us-ascii?Q?Ob5Ks3HukUrt+lI5JzL+C6QNMGwlB9KRkdrisERA+Wr+9PlFYRjWiYud6W/E?=
 =?us-ascii?Q?yWzNzoNHhpYFKJS8AAKv96o8OZIdArcsnPVmhDTYXXp5B7XIMZBBDyveLuLA?=
 =?us-ascii?Q?fZGgPtC3xJDrGw4o9i3PL7KBThCFAQrmt9I6ctl6e2Pir2JfNeX4YTbvkGdn?=
 =?us-ascii?Q?+4+7DslSAlbIiexu8FFGmZuFg0qJcHsByt+q91fe9zZ/EdhrO9qJLBCco0Uf?=
 =?us-ascii?Q?vCt1LrHKCaLMSGMklKa/tNpJCsgiSt5Fn249bR40Rs8oDzgwVKvAGQb8r2Sr?=
 =?us-ascii?Q?h00rcmaO3k+drfNor5USBL4m7mweFl4QDgLOTfgBUv9XjNYesu4MiEJ+W383?=
 =?us-ascii?Q?P5ATxufk0EMlWJw+h7h7yEqiQoIJmWJD1buCY7l6VR61SQsP60HqaQVfxlLX?=
 =?us-ascii?Q?zpB/mN83OIU+p34kqVGO3+0qsHBUXHjMC25X1F94cAgttC/0zrUqUHCcFcd8?=
 =?us-ascii?Q?AomDKxEUh4YraQHgZfiQOU3aKRzAp61w46vpWe6nov9CKnIAuEqTmE+FgTW+?=
 =?us-ascii?Q?/sSZpVT0k9VC41kDOaoTNQmT6OiIqSk9wkxRD4mOYisATUoqJPx/l2jrCqfB?=
 =?us-ascii?Q?LfU+RQi8USASg7PwcB2pxbaJFkJJHBNlUZcm9POtohygTq4JzwCLqDMNoR8I?=
 =?us-ascii?Q?WNV96RPAfpnwbZAHXpq7rwHXDyH49dlGNAy7d1PM5sqewWNZk76neC0NP1eb?=
 =?us-ascii?Q?wpoeh6RAmqgCTCJi9B4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f810e714-03aa-4587-d5d1-08ddb77449c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 01:20:23.7669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqwpYhxcJysW5BnV6/nKohDn1zujmmx4QSs/N6KE2y92bCC26q2pT/E4vRP5fqOL3bgXktOSW2eKe3HDsuuZZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438
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

this patch is Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Saturday, June 28, 2025 12:46 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma6: fix user queue firmware version check

Some of the versions were incorrect and add support for 6.1.3.

Fixes: 3de84812c702 ("drm/amdgpu/sdma6: add more ucode version checks for u=
serq support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v6_0.c
index 2f3250d30bb01..273f9a1567761 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1392,15 +1392,19 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
                        adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_=
funcs;
                break;
        case IP_VERSION(6, 1, 0):
-               if ((adev->sdma.instance[0].fw_version >=3D 11) && !adev->s=
dma.disable_uq)
+               if ((adev->sdma.instance[0].fw_version >=3D 14) &&
+!adev->sdma.disable_uq)
                        adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_=
funcs;
                break;
        case IP_VERSION(6, 1, 1):
-               if ((adev->sdma.instance[0].fw_version >=3D 14) && !adev->s=
dma.disable_uq)
+               if ((adev->sdma.instance[0].fw_version >=3D 17) &&
+!adev->sdma.disable_uq)
                        adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_=
funcs;
                break;
        case IP_VERSION(6, 1, 2):
-               if ((adev->sdma.instance[0].fw_version >=3D 12) && !adev->s=
dma.disable_uq)
+               if ((adev->sdma.instance[0].fw_version >=3D 15) && !adev->s=
dma.disable_uq)
+                       adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_=
funcs;
+               break;
+       case IP_VERSION(6, 1, 3):
+               if ((adev->sdma.instance[0].fw_version >=3D 10) &&
+!adev->sdma.disable_uq)
                        adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_=
funcs;
                break;
        default:
--
2.50.0

