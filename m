Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D82CD128A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 01:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33BDC10ED97;
	Mon,  1 Apr 2024 01:46:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rNMpavUc";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2094.outbound.protection.outlook.com [40.107.93.94])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3920C10ED97
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 01:46:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YontHuuJqTaSbOghAFtshyT7HPUcSRZiZ1zP+QkCIUtWfpX/cepMN+94AGv7wXAfDH51vrW7WgKzY/Wy6rOxtdzEW4hWdjK6S89RGlLl8HAj2gn837rRFOTTah+Rs8OLPItqM03o/Q72MU1vTPDxu9jzi6xyuLXw5m141kGtfVcIiV+Uwdgkuk75HxC0w5upgEhirnNrq5UcpP4q3QeWiorGQFqlcihJdJjk9Z25brrF1bdZ89R0wv3eXFgXVOrJp3sq1bdHzkldDSqh3vMI6IlPaU7A5gLjB4CC4Gyb4aqe6rVe4eQWU/CYFeAL/abY+ddJIGVmKm9NjD8n9SxuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5b8rW00aPo4c77Q5EWwG2RRXJkZqIgQznGz7WG9ol4=;
 b=BvQzaR9MEkhSOT+vj+1TAmT/qJmSC0jBbCptrFAnFlGZdPJG2Vg86s5cDqwkEDNtWEIjpeC8z2wRjiNOlQ4V/zP6gpUqcD0j/9UHCnAajWSl6WudYfzlRXEslB07wEtE/dq4ehSmBxXfsg/cVJccThW2UjZCy0HZ0S6BKIg00V/REWXh12nuoIjF14wLXpEKXac+s1s8sbwvvO9eQ9Qt+LMMCM5auulGd7TQhh0OGFg+NIlRmRjfdcQNbAL2gV90IBwcNEM0n+dBX7yxSo/sUPzUmknWdc/oYd2Xn/mzbl7hF5XtGD0XvRXgwAYskHft88S4oneZh3dWAYlDfh5p5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5b8rW00aPo4c77Q5EWwG2RRXJkZqIgQznGz7WG9ol4=;
 b=rNMpavUczxQBlGOFmdjM9YZGHZc/HhCGo1qE5CxGfNkXHdg6dGAb6htODxCIKqfdDDe7uI5WAbYx8oI6OiHza9AuXQ6Cp99snlVhDCBbIjAJtrMIQRUSveEu3urQ0hegsqG0agRCuDN75naMAoeh+8eoGrz1yuxkPQyuiV4E7Tk=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 01:46:55 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::b088:86ad:44e7:a075]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::b088:86ad:44e7:a075%7]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 01:46:55 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Bypass asd if display hw is not available
Thread-Topic: [PATCH] drm/amdgpu: Bypass asd if display hw is not available
Thread-Index: AQHagyiPnpUUIphyT0SEJoxxQpH4+bFSplew
Date: Mon, 1 Apr 2024 01:46:55 +0000
Message-ID: <DM4PR12MB516526BF44AC73A429B309688E3F2@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20240331050152.32608-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240331050152.32608-1-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a4046d32-8560-4939-a141-f710cd9d9ab9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-01T01:45:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|SA3PR12MB9158:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M8fsj1n8Y83khJTZPN19jrpQj+R2LnuQD1haCOG3MLpuRsTnYqcz8yqI7KxSZu2esZUhAwMlTs7HavnnhotTO//+nR+fD/Sdl5hOq+z4LPvQSDYBilH8Cotv8wWFM4WViStbWoOhyFz17nsMgY20THifPRqNz7oSAs2N4K9sl49sS/YKDfng0yGefAz/MoW0NRLMo/hglAKX9161ElnFkSvb428Ymz4kYRijDKKod0NWEYv7mKo1oKBBulBRf5wP/kUweHWkapqQBMlSsVsGAB4yXX0MvTt3h2VlcE8lOcBScnn+ObXKYQVowKBK5d5wNIwHOrShm+CtAb8I6CBftIlmyHEdHdYRMgD9TFVweVJdY0tNKhcuIQ2KEbNqILrziIYIqR4Qzkqu6esATorEP3bsumulCeJB3ApUGnStjE4KS2NYxNvf8cyFStOpqvvKaQMWJW6iBeilPqwe93++U5gMbECgrV+LPlBNEhR2bx8d8ugbxL4s8uWazV2V9f0oMa+zlV+atTKuI9FrZme50v0963HMo9bzDFDxJ+pI/sp3Sl9aEefqLcx2803sCT6lWptt50OFxsoGMkKBcMRevVIqovnYRAiQQYrE7ut257tdHCBKLeYJhb88Ko4O+r8vQfa2FPsg8REzAXDxUYdfM4V9TP3yXkZmPiB5b7t0Bbg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TUSJL7s/khp0N6b+pzTLpyYyGlngD82HvVJGXyQ5peuDgKNQkFQ9itHPAdJE?=
 =?us-ascii?Q?7cyTNMba/0aEGqTNqrjbXzsHFY9ZJp09QXkHDG70pIYU8ju14Auuj7QkQQDY?=
 =?us-ascii?Q?bt/mhCuvDArI52jH7ve9VAPehl5wJKORdI1HY4s42I8reLBcBcGlEvtd2jqA?=
 =?us-ascii?Q?ngcxa8DWKzM6++Yhp68bFR1Wy+lMCitisKlBnwavvK0OeRHu7wduZNVuwmaD?=
 =?us-ascii?Q?weEC/DeMK2I6R8oxN4F8f70077MNCCjX/9U8nNRtWhsyW6S1KfNGuzNd99R2?=
 =?us-ascii?Q?SwywrxVH/8luT7IrfiHGux+9+1J7MUjVypSisqce9NEhl8jw8fHp7XAe8rLf?=
 =?us-ascii?Q?ly1jN4m6U6BKxx9lxbuwidLx9hFRCxjI8iOT8T7tMlK/YyfaJuYx24shquv2?=
 =?us-ascii?Q?ZTkVUxuaCyrH/aEsjVmPObzGixyXL6R2TUT2pXyOXEj3HQItPdBqPOgGrAB1?=
 =?us-ascii?Q?Lfk0Vl1KSEZKjLttkXqMVV2X+n9nBOwaQzk/SijhIJ4osDXdMfhupQftxfmO?=
 =?us-ascii?Q?BVYw5xjzALYbuWnCfeaLx+YsWfYs01zfg9KtAFPE1iwwO+Sg3OxVdqTye4Li?=
 =?us-ascii?Q?gxdlJii7YJDK1gNWKXegvUwteWxwHdrMXPL0NeOIW1eX6c1BfNM187xI/BiX?=
 =?us-ascii?Q?Pu/QCln2uidQ4JJft9ACbij59HpSNkj8ALzltVzpEb67uoGbEzI0071Zuk53?=
 =?us-ascii?Q?Mk9P6JQO6lNsmLtMFNFrIk+XmeFH7EYyVCS+2Z1jWnW7HKaGYxq9KltaWNt6?=
 =?us-ascii?Q?IiHL1eOkece0Etpb4bgzuRejK1v59pzscRAETR5ZQb04ly6ESshkglk6WDKc?=
 =?us-ascii?Q?i8OC7vM4Kl6xix51JvolrmPosgnkgQCZu/CUvGGw+w1aqM84Xfh2c3vRPpLk?=
 =?us-ascii?Q?XNVN0gKG0xLQGkq1+tk9alZ21iaS86vmPXCneI/zAsuTYEk39GqEojREu62B?=
 =?us-ascii?Q?9h3Hh6UYLtwLxddr5xoZCVHvy6CffUHWh0Q8jplTsJ6BH7G8pinurxPBKS78?=
 =?us-ascii?Q?+8b1yLCD81mQhnML0AwXr6G78QF55910KPvpsRHTNXdheTV/6OxtANaPF32R?=
 =?us-ascii?Q?wr9wPg/mXPOb/pMd0jOMHKSsEYjQV9GlAi/vubFWBLiX02iYxEbVqytIp0Ge?=
 =?us-ascii?Q?HwqVIhm+HfYmDS0nXNaDig8dqEu8KgPfd4pM48STXG+Sj1GHPYuz8TRcPuQ8?=
 =?us-ascii?Q?pjQOp7A6amv5HgONAdEDaYlzAVaFvnQJy6wj0TPcOYV2Ao2bZmPgEcQom88t?=
 =?us-ascii?Q?alWHrc+Ev0LfVYg+xnwbYYESus1G36KeX/ShJF7F7ycxcjbTT9rUboNWh9Z9?=
 =?us-ascii?Q?aa5q3tG2tFFAENbRCgs/bTH3/u7/p//2YqFYuJBKyLv+NyDVPLG+cBh+WF8F?=
 =?us-ascii?Q?zndjcRXIkY0udnn+7vAyMXW7C83qE9ZKnW29BODV8c4Yj8vEAt+7K3QAFdw2?=
 =?us-ascii?Q?ty4YUzJKtn3Be8TBxSKRHiwB5P4GYTwQnOo+Dw1acGQ8LbN2t9xY0aaV2NKJ?=
 =?us-ascii?Q?41Ve9/kWl8RwKhKK2dZCIKUUIkWMQwmWu/PljdMBAmPUk2dUctNrv84X2tYw?=
 =?us-ascii?Q?v7N5bSZF1fvAE9fLLIc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8574a17-3558-43a1-68cc-08dc51ed9c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 01:46:55.0629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wo13sUW6ELgpGbvTIndZyoS/NserIjxAZDI7YKWBJdNixIHrlv0LVcauJhVpRTpU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158
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

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Sunday, March 31, 2024 1:02 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Bypass asd if display hw is not available

ASD is not needed by headless GPU.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 94b310fdb719d..83bf86352267d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1053,6 +1053,11 @@ static int psp_asd_initialize(struct psp_context *ps=
p)
        if (amdgpu_sriov_vf(psp->adev) || !psp->asd_context.bin_desc.size_b=
ytes)
                return 0;

+       /* bypass asd if display hardware is not available */
+       if (!amdgpu_device_has_display_hardware(psp->adev) &&
+           amdgpu_ip_version(psp->adev, MP0_HWIP, 0) >=3D IP_VERSION(13, 0=
, 10))
+               return 0;
+
        psp->asd_context.mem_context.shared_mc_addr  =3D 0;
        psp->asd_context.mem_context.shared_mem_size =3D PSP_ASD_SHARED_MEM=
_SIZE;
        psp->asd_context.ta_load_type                =3D GFX_CMD_ID_LOAD_AS=
D;
--
2.17.1

