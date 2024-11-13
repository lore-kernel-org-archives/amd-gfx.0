Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F99D41C18
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 08:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8947D10E1F1;
	Wed, 13 Nov 2024 08:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kDoIM18Y";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D11410E1F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 08:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqfWr3y+A878NiUXtHry+ujfDxZogtmUJMpkmM+1vwtSQlNZD3ALZnPMXMAaJXlkiYLMBKU5OnQ2YiJYVZ45N8DXsddhzekqODvIBNE8hG8KT7ShGLhLuihHJNT70DsWEddkCThDbIK+VuRQ6cwv8xdFbXPpv57T1AY3ZNXMjaol1/NTVJhV2ISWaNqSS+3Tpo8ldtZrfpMhZSDh9VsFnasyfsOTW/hG7wmiekHuDrdusuSkm9RY+vIDbPAekd9dOSwMElAg6qpOLvERDuQj5QD/aaHx/L9oHnUBD3IDaKbnyl5lY/bsGAIlEFruheAe5Xl5fAXMG14ZL/U7aHIQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJ+Z7kDPDb+DnIEN9aotf0is3d57skohSpH6GbqOxfA=;
 b=Kq1ovHWg/fWmb4phuUrTq5yRc7GpWukMMd05nA11UILQLJ3v4gnE7E5cSpVcM1Y7kIH6Uq0TQQ5EyYi5Xxqr/Rdy0E5JGPZ520y00qoF4Ce+4sGLYsPm870AIcYcWvhY82Feo9VX5waXCfnJHnP4eF9JkY+n5GwI+jI+ZW1dPhTncW0Kl+fsDa/LnCEikGQJ884fIrJU5m1PZOP/794JGoBRkeVEf/Izc83Mtjq7ao86BpINunKO71XoFplO/A4Wj1jsJey6xDCr0INMs73KaExkXDiYo1Ypiqt5iAj42vLr+ej2XOKLAF2+ipx4sNvLXW5536kc7nUGvipwICi0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJ+Z7kDPDb+DnIEN9aotf0is3d57skohSpH6GbqOxfA=;
 b=kDoIM18YhvHMgtcig4KJAa6EIJSu6NApLzd3CyLcFIUDV881esj5qLQtPFehxrm0AhGYhfes7hAkpBTi8w/aer6XPT3AM/juDqv3DPmboyGpBqbL8wU1tQef1Wy6r5pzFC8W589/KtUTirgQORl6dTbHH9fzKecunoreDDHuv1Q=
Received: from SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 08:46:19 +0000
Received: from SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::cb36:d7c3:c354:e74b]) by SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::cb36:d7c3:c354:e74b%7]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 08:46:19 +0000
From: "Fan, Shikang" <Shikang.Fan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
CC: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Check pending job finished or not to
 identify has bad job
Thread-Topic: [PATCH] drm/amdgpu: Check pending job finished or not to
 identify has bad job
Thread-Index: AQHbNXpPbwvTgMvpTkqnvCRfkIefvLK05cAf
Date: Wed, 13 Nov 2024 08:46:19 +0000
Message-ID: <SA1PR12MB7343D24CCFC921D157E2CDCCEB5A2@SA1PR12MB7343.namprd12.prod.outlook.com>
References: <20241113031411.698366-1-shikang.fan@amd.com>
In-Reply-To: <20241113031411.698366-1-shikang.fan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-13T08:46:19.004Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7343:EE_|DS0PR12MB6486:EE_
x-ms-office365-filtering-correlation-id: f06e4f35-226a-4eb5-2388-08dd03bfa4c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?sNkcz3PBPUBr43G16g1Rbp/d1Lw63e1UWPLg+gCTsaojKjEUDTie66j68WTu?=
 =?us-ascii?Q?SUTyUkoZCDFhw+/LdEbFaVX7UkEw0+9wmpnB7cdDZ5Jl70kwRX0jz4cL/vsQ?=
 =?us-ascii?Q?FjynfCn2DWd5cKDoheAUtz+u1RqPrkYNxs0kF1x0Xa01FYM6Yw9yorHnlV6o?=
 =?us-ascii?Q?mOdUB943aMuPjmQ81dMhcRUd/rT2T3cTUuzPP4Zny9yj1Ppjv0xqm134t3sO?=
 =?us-ascii?Q?P9clqqDiMq37ZHXG2eEANTx12mPwAkKsOg45X6dNYGFxB5VtDrKBlBFPXIUt?=
 =?us-ascii?Q?P8aK6U173GMnnXjo+TlqHVTJZwfWqXiV8tbNLpaNCmhZFkzV7nh+w55DkryG?=
 =?us-ascii?Q?RuLIuXn645F+XoJGnOr6qoQJOvm3p4bvTrdqqTJnn5kOvSAutKSwmJWtLrK9?=
 =?us-ascii?Q?EOvCC2B+S/2ne6cVP6OHXOGcuQRbaMC722m7NXz95qKp50G4od3pWFxxgpco?=
 =?us-ascii?Q?RWx7/AyeYwK5pWZdkv1Vt60E9grvY4K9tGgFvJsm19wNzYkiVjrQCA94J+Hh?=
 =?us-ascii?Q?x3Knby7mSMCsSVlRGHJaje81wskVN0+gBcqDPBZ3/Lfd2c30pzMCWJ1AlrpO?=
 =?us-ascii?Q?SkZMlU7V6PQRAM/lXRZQmjVc6EK7sC5wPJtFnDx38DO8yObzuE6CiaOhEML6?=
 =?us-ascii?Q?jcGKNLqDU6i8eR9bGMF9IWfGjl2bCZvLZLKJt4FPqCkRVdGzeemjNwWzkb1t?=
 =?us-ascii?Q?FOPctnIZ+rAADxxQYtntdIxWfInKULzxViS6nH5bZhDDdBaBCo2brNNBppBO?=
 =?us-ascii?Q?7ho0JQ159qDtvPrYgdsB6uL+vk05v3/pShKoaBBOLBwXXvnYIWavCE0bskvO?=
 =?us-ascii?Q?40QgUOf02qz3Mzhxzqf0P/XO0I7/GHEz2u3sy0V/Mg/HHekM0ZMzVS005OZ1?=
 =?us-ascii?Q?jDI5WExEMtUIDB96s1VM7dvOoH0x88VNS8N5Cj0Ro7PSz8RjiUFtXQgwuoP+?=
 =?us-ascii?Q?AaXAbO693kXSeU0AhRjAnkfrBXk+ppuddN9mzdxDmEwg1Fm5wuLrgR7ZJUlR?=
 =?us-ascii?Q?Nd49/+GmMBPBGG5Um1jxcKbheFDHQ/404D3faNYKgFVyegP1MxdhEB71xBnJ?=
 =?us-ascii?Q?82ZaA04bS9PPBGyatvbB+XTezMHDekK/zmlBemSYHQju7YUeIZWH3poyPO1N?=
 =?us-ascii?Q?kVyZxZvN0FfDiQVThyV6R62mTxk8vTLY4XZveMbgj8hVEiJVDMJXpwx2mAui?=
 =?us-ascii?Q?ZwMPgs/UocOHUmNKRmMXBqiaEowxzeQx8tBFtomNfho7icNSkbHmZvykm/aJ?=
 =?us-ascii?Q?kub3aLFHOniiX4vNlRw+6RTe7G3Xe1jnu8zQahxjIOtAbhj1lB0oU5sWnG7D?=
 =?us-ascii?Q?fmsLszJeo+6/FCL8OiJXeTqmS4QH/lnRN0LmlJZVA8iq6VJwTpBWGmJcOk4i?=
 =?us-ascii?Q?8uwtIvw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7343.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zb30w68Ofw1lpzUnv54Ey0GwMwKpRpZa6bzjZJGnyNR+b5H83OC4neKUjruH?=
 =?us-ascii?Q?R7WAKGR/mZ2j2NrsOOZuxlTCS+7T/xOy76ake5RSLe1BYNfhNL0HHXI796YV?=
 =?us-ascii?Q?v64WMCZlU8l1PqfkhXTC9ONqr/uU89lytr1OGHpnxDL02Os4O9HhYbVfX2yi?=
 =?us-ascii?Q?YCDsySeEwhUx25B0aOkgugMzmAIkc1UgjnXaacV6T4zTyGAwQIwFAgj2yPWC?=
 =?us-ascii?Q?m6EaUGt0LCYP0/mYLkF4mrIkYcK0zfkB8rDZwv4LnFLlKG6pbO2RH4j6xzyo?=
 =?us-ascii?Q?ZUOeVeTftWsokUGJBw0cqpGuFjuz4BAn/Ch5C+KIjVCFLzvrJNSYqcRgrwaV?=
 =?us-ascii?Q?n1ncU4yxuGb+5tDOXGvpu8IEEbU3oYRRmf/XXgMmYJVXlB7AZuVEzeggMJC9?=
 =?us-ascii?Q?LWedSU8RsWOikUxEteBh8tmlwFPvQ+8nOrBgbRpwkmcjnL23LcaYdzzq2pBP?=
 =?us-ascii?Q?xsAPzo8fyW/E7APVJT/1slcbAwQQOlZR+Wt8XcMSh9TfyccohsPBfX1hYJoX?=
 =?us-ascii?Q?EnBY0m97FOO+jxt7PqbDqjZlLw1VQJKulDI5rqgL6Pe7wiFsfY3k+8YAsZUu?=
 =?us-ascii?Q?7NJVWwrZ8nFP6YlMCf1fWElpKeNEL9lSWC7c4mwGlJCQo6crfvRCXQuU8hlb?=
 =?us-ascii?Q?JPegMFl9iLxMhdOHnDXIn96e3ksjH50mau/GLUHGx07zmiY4OtZVCoQDPjMy?=
 =?us-ascii?Q?ozatR1mPlIjlQLtzx+cV5wU/bjc3qI5xeil9gORIn6fmCRf/kIlZbavViFEM?=
 =?us-ascii?Q?mkbv943MGWZ+MnCHi6EI7HujJC5v9lQBvStf91ZizZtuaMmbyOkyHRtVK2bN?=
 =?us-ascii?Q?IglMRXSZ3UMcqm6WlWxOQaXrambq5lYyKga/44/qp///8leWllUoPWpU9Hxc?=
 =?us-ascii?Q?UMn+VaIjzRxM+h6RtHEv4wPS5gd9J94JycXXVrgYjQ7qcENJc6XHxY3BqY3H?=
 =?us-ascii?Q?B+5Vmp4c2wjcsR4+TT2FjSpjgJ+uCWyYhfW/WFZnYnkvzSiOSIGftBptCJZ0?=
 =?us-ascii?Q?MwsMzbYNwHLCmQ6nbjCBr4T59cZ2ALSIEmicrneFw9cbDGttoEZrKpQLYXba?=
 =?us-ascii?Q?KnscIwZ4d37aeAy+jpgwgDhPGO8QdvndSuhyN+bu7ymmQRuH25JShfsqwiCQ?=
 =?us-ascii?Q?7b78K8qd+olN9w5wBa9IsDRQuW5CisGz9izs8+MMOV9pb0kexuafJff/xP6H?=
 =?us-ascii?Q?Vur4ySqgZfQ+s4RFastfGmnfzhwp+xDATjKRHnvJmsCdXX2GVZ8bhGETC7L+?=
 =?us-ascii?Q?SL1GD8U/PeR4LAgMhqP4bxZCAVxu1kQF9sv7oO/6Q8JJGxZo4XM8DFwnTkUQ?=
 =?us-ascii?Q?aUOmKiAfRubs0K36lga7mH/8mok+DJRVytNxSove3ni7nSwsw5+rke0ZaCMx?=
 =?us-ascii?Q?PmMCn4lxqVP/cBWA44p0kuOp5xv6JlQvjAeZb8BovWH41G2uFKj+Mj4eZuMi?=
 =?us-ascii?Q?mbDtfXlfe59KTT8y0ch/T1Kbbl2XgxOS4Ipx74xmJFOQD9xMAn231QubhDxn?=
 =?us-ascii?Q?CfywXWGK3zdh3QlDVDihiFdeRpRFZFDMroWayYsP/vHvYWaFHkop2wyrsDwx?=
 =?us-ascii?Q?gBaco+L/7N+Lnsgd4Es=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB7343D24CCFC921D157E2CDCCEB5A2SA1PR12MB7343namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7343.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06e4f35-226a-4eb5-2388-08dd03bfa4c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 08:46:19.4114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYlWpnoYTOro3QN3Et9zpzK/oZ0yDtHvoh+qtDNv1OhmM0rwIeGUfJT/JPfGjbyifpsvqYiEv+QvFCmRHVrkQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486
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

--_000_SA1PR12MB7343D24CCFC921D157E2CDCCEB5A2SA1PR12MB7343namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

+@Koenig, Christian<mailto:Christian.Koenig@amd.com>

Hi Christian,

Could you please help review this patch? Thank you.

Regards,
Shikang
________________________________
From: Shikang Fan <shikang.fan@amd.com>
Sent: Wednesday, November 13, 2024 11:14 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Fan, Shikang <Shikang.Fan@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@am=
d.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu: Check pending job finished or not to identify =
has bad job

drm_sched_free_job_work is a queue work function,
so even job is finished in hw, it still needs some time to
be deleted from the pending queue by drm_sched_free_job_work.
here iterates over the pending job list and wait for each job to finish
within specified timeout (1s by default) to avoid jobs that are not
cleaned up in time or are about to finished.
if wait timeout, return true

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 071d3d9b345d..da2a22618f42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -100,6 +100,7 @@ MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
 #define AMDGPU_PCIE_INDEX_FALLBACK (0x38 >> 2)
 #define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 >> 2)
 #define AMDGPU_PCIE_DATA_FALLBACK (0x3C >> 2)
+#define AMDGPU_PENDING_JOB_TIMEOUT     msecs_to_jiffies(1000)

 static const struct drm_driver amdgpu_kms_driver;

@@ -5224,7 +5225,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_de=
vice *adev,
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 {
         int i;
-       struct drm_sched_job *job;
+       struct drm_sched_job *job, *tmp;
+       long r;

         for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
                 struct amdgpu_ring *ring =3D adev->rings[i];
@@ -5233,11 +5235,20 @@ bool amdgpu_device_has_job_running(struct amdgpu_de=
vice *adev)
                         continue;

                 spin_lock(&ring->sched.job_list_lock);
-               job =3D list_first_entry_or_null(&ring->sched.pending_list,
-                                              struct drm_sched_job, list);
+
+               /* iterates over the pending job list
+                * wait for each job to finish within timeout (1s by defaul=
t)
+                * if wait timeout, return true
+                */
+               list_for_each_entry_safe(job, tmp, &ring->sched.pending_lis=
t, list) {
+                       r =3D dma_fence_wait_timeout(&job->s_fence->finishe=
d,
+                                                               false, AMDG=
PU_PENDING_JOB_TIMEOUT);
+                       if (r <=3D 0) {
+                               spin_unlock(&ring->sched.job_list_lock);
+                               return true;
+                       }
+               }
                 spin_unlock(&ring->sched.job_list_lock);
-               if (job)
-                       return true;
         }
         return false;
 }
--
2.34.1


--_000_SA1PR12MB7343D24CCFC921D157E2CDCCEB5A2SA1PR12MB7343namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
+<a href=3D"mailto:Christian.Koenig@amd.com" id=3D"OWAAM717321" class=3D"tW=
KOu mention ms-bgc-nlr ms-fcl-b">@Koenig, Christian</a><br>
<br>
Hi Christian,<br>
<br>
Could you&nbsp;please help review this patch? Thank you.<br>
<br>
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Shikang</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Shikang Fan &lt;shika=
ng.fan@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 13, 2024 11:14 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Fan, Shikang &lt;Shikang.Fan@amd.com&gt;; Liu01, Tong (Esther) &=
lt;Tong.Liu01@amd.com&gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Check pending job finished or not to id=
entify has bad job</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">drm_sched_free_job_work is a queue work function,<=
br>
so even job is finished in hw, it still needs some time to<br>
be deleted from the pending queue by drm_sched_free_job_work.<br>
here iterates over the pending job list and wait for each job to finish<br>
within specified timeout (1s by default) to avoid jobs that are not<br>
cleaned up in time or are about to finished.<br>
if wait timeout, return true<br>
<br>
Signed-off-by: Tong Liu01 &lt;Tong.Liu01@amd.com&gt;<br>
Signed-off-by: Emily Deng &lt;Emily.Deng@amd.com&gt;<br>
Signed-off-by: Shikang Fan &lt;shikang.fan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++-----=
<br>
&nbsp;1 file changed, 16 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 071d3d9b345d..da2a22618f42 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -100,6 +100,7 @@ MODULE_FIRMWARE(&quot;amdgpu/navi12_gpu_info.bin&quot;)=
;<br>
&nbsp;#define AMDGPU_PCIE_INDEX_FALLBACK (0x38 &gt;&gt; 2)<br>
&nbsp;#define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 &gt;&gt; 2)<br>
&nbsp;#define AMDGPU_PCIE_DATA_FALLBACK (0x3C &gt;&gt; 2)<br>
+#define AMDGPU_PENDING_JOB_TIMEOUT&nbsp;&nbsp;&nbsp;&nbsp; msecs_to_jiffie=
s(1000)<br>
&nbsp;<br>
&nbsp;static const struct drm_driver amdgpu_kms_driver;<br>
&nbsp;<br>
@@ -5224,7 +5225,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_de=
vice *adev,<br>
&nbsp;bool amdgpu_device_has_job_running(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job, *tmp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MAX_RINGS; ++i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D adev-&gt;rings[i];<br>
@@ -5233,11 +5235,20 @@ bool amdgpu_device_has_job_running(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;ring-&gt;sched.job_list_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job =3D list_first_entry_or_null(&amp;ring-&gt;sched.pending_lis=
t,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job, list);=
<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* iterates over the pending job list<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * wait for each job to finish within timeout (1s by defaul=
t)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * if wait timeout, return true<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_for_each_entry_safe(job, tmp, &amp;ring-&gt;sched.pending_l=
ist, list) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D dma_fence_=
wait_timeout(&amp;job-&gt;s_fence-&gt;finished,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f=
alse, AMDGPU_PENDING_JOB_TIMEOUT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt;=3D 0)=
 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;ring-&gt;sched.job_list_lo=
ck);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (job)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SA1PR12MB7343D24CCFC921D157E2CDCCEB5A2SA1PR12MB7343namp_--
