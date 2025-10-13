Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E7DCCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 11:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A3D10E435;
	Mon, 13 Oct 2025 11:36:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L/gspN77";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447DA10E435
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 11:36:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEInYz40HkuvilA8YeGvAdWy73pMFzFcOkY1H4PCSwCR/RQAzj0qLOX8xFOG0DcKgP3SlddmUO5FDH59gnRn5Gs2G63tN83yjojuGSY1oQndBswSq5Wtwp6zJmvO/Nofa/I+byfPKwjhO8Ap34HPPCHhJIW8SUxOtaat0a+LQPH2BMjMm7Ze/uQCfG3GKf5aE7xEOF9zJTJKHmlCIOaa0VoPdRZyJS0W6CWXZEnOP+Rj+ZGt+fVjT9M9W6louhwQiGdG6kiUYZtb1hqt2lYRhFmsVsF4RQ0DhE2/eN1Psxx/6fapjE+fAcE1qgA9TwgeAcS1Y8gVZxvlYoGEaignMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67A/2SqLmlTVYhTXwaxO4Gdb+AileTQUValdaHYv7aM=;
 b=nnRZLLyskm70Fg5WWZqiRElGYxjfLcnCt4vueWLeaRmJ9yeFhvJjqtgqhq/8nsrxMvY2tiGClcB7IZ7jSXq0i/WFfoWAth5ib8T63R71vOys+yaOAO2f3eGlNGbqtPkVaT3M7fkslPuCqFw5vK9oxrR1AFC9DsZ/bvnDABS/znT+X5Kr6LYhuSSg+POnJZvbD2aQr4asLW/6u+FEtnY6pV4rduev2ckep1G4VLFTiPEsXxNCpN0XJE4HbA38GItG4n2L8YmR+H3ybG/SF6CKtdAaQu0StYCUfjyrRhZRgYkKQVOJpqSiKu8kHjCDiMezNskmTIKdnSPwggvePGUgeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67A/2SqLmlTVYhTXwaxO4Gdb+AileTQUValdaHYv7aM=;
 b=L/gspN778q3Tp0ESOqdA6vnQfb/5ifLfgWb+itKpH8nn/jNuLhbpw4WSBzBiyqD0ZagC31yYnjl/JAb0BreSHrn8pIDhsIvHqgjKFy1c5/RQcsFECOY5ySozoWkEd+WymeMrUSSPJ7mI++hPXgIP8asLytdLTmSJ0OzxCERQDkk=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Mon, 13 Oct 2025 11:36:02 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 11:36:02 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Zhao, Victor"
 <Victor.Zhao@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: use GPU_HDP_FLUSH for sriov
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: use GPU_HDP_FLUSH for sriov
Thread-Index: AQHcObgi042WphYWk0SA4GlDWVLkGbS/9xKA
Date: Mon, 13 Oct 2025 11:36:01 +0000
Message-ID: <DS0PR12MB78047DAFE54A848066BCE3D197EAA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251010073246.204178-1-Victor.Zhao@amd.com>
 <20251010073246.204178-2-Victor.Zhao@amd.com>
In-Reply-To: <20251010073246.204178-2-Victor.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-13T11:33:54.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|LV2PR12MB5728:EE_
x-ms-office365-filtering-correlation-id: 57a3528b-1bc8-4780-c8db-08de0a4cafff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?u3v33ex4VWCdrogY08u+Gf4ZpIa4Rakb+HhhF7G8L8mV7+tMWpvsRN52qC7v?=
 =?us-ascii?Q?54Wm5g5ig8ULAS7XW4ehTFncoXq5TjfynV5b89nH3NZZFxVsjDFEQARPKd1U?=
 =?us-ascii?Q?Ue1i0/0Eq2fWhqLOlUM0Sv3tIejQmZCOyoUoEhS7Z7XIs/ofGn2nuMH4FAT9?=
 =?us-ascii?Q?RA4Ba5sdRRcGVRJOa7lW0a8olrtVZkMIMIrkbKpJXOHWWSVNo394d6Znoe1G?=
 =?us-ascii?Q?HC0nDEIH7UEbZhHLChRNqgwmB1UVLu0uimIQQnyivhjqzzr1B98qSBUKka/1?=
 =?us-ascii?Q?mcTWZfTn9pPXnFHk9Sl3skFNIea2qlhLvtXYosG7yNZP51eytd8Rdbph5Msw?=
 =?us-ascii?Q?bRclDHnWwKf0ue0WAj66sBWPLAxhy/Ihl5gETHsP2uyYn2fZIwOa6nlpdCuf?=
 =?us-ascii?Q?KcjemK+GzozsQ+5HGF4a1mMrXr0sJcbTkHmB0+xwhqDZGPBJ9f+mNrUelT8D?=
 =?us-ascii?Q?he+ViHsiQ87bJfJe3BrLA0Fe4D7k2GMR52c9bI4hn0bymxD1C/pDxA90dsiU?=
 =?us-ascii?Q?cymZDwI23uM7OCIIL9fsdbW1q5M2K2OzAURMB9eig6synLEw72jwrV5pINhw?=
 =?us-ascii?Q?6LdYk4+3Y1rYBg4nZqlg4OeW5yPZcvzet9Y5NaFL1Up3Axcu5XkKaw1RWhoe?=
 =?us-ascii?Q?dbpvtF6nxFT0kIAcUDyxN0mMdg3V4yr7xYF/oCQgj33rrH5LNWLzbIkT6vX1?=
 =?us-ascii?Q?QV2Z5EjNO/V6QCzG8Hfp+1bXI3wUt8gPDVddQ2dUoRCe+C+Uj/jGbrGbk6wS?=
 =?us-ascii?Q?I8ukiMkBjok66WrFINVbY5klW53J7xW0ywXOdUxxwXnfOTxCmJWn4X0myCHe?=
 =?us-ascii?Q?zSAZ9OKSBoDjXYKfnUyXsnm2skbUe9PqCuG2hbIgv88epA3+oxnIHI4HOpCi?=
 =?us-ascii?Q?5U96QcMr5pSA3nIiz8ub3HhOFiXM9BSb+SflsXs3m9AIXZ8d6OtPNVLY0B5S?=
 =?us-ascii?Q?7Cjofr3M+Ho3f95IPJetEbXBopbvCL/bVT2xFBz6kXMuvvpOk7IDnAiB2Aw9?=
 =?us-ascii?Q?1FwhjWyDigVn3IWvltEqF0KZKzM5HCynslwO8GJ5LMhXC6G+Fqd5widxR86U?=
 =?us-ascii?Q?/zzBeCHp1ibD+LThd5cT2OFiIbjQl7adzOtNcTlDAB4tQqvUY3XmCDacndFT?=
 =?us-ascii?Q?6+eeX8TRHdsKsIGEDyagWBuINUbrfjccUOVAbhzV8+oJ6wCQhznqLTm+puk8?=
 =?us-ascii?Q?CNnX51/7/VrW/w6zdcaDhUxKlGS/Jnk0Wc/qWzqykmylHGADnBfMx/yVl/8z?=
 =?us-ascii?Q?IDIjNPrzD+SgTmcnXPjT3FagIxZ9tnJIyqN6cLG/ehByIy0O1MejFEoXPVkP?=
 =?us-ascii?Q?3pm2cCzS9VONpobtHQa9taqeCvIEEQhjoebcj7IE3dB+iBtwjZnEXx7veqtF?=
 =?us-ascii?Q?5I2e6hYdVOqXuHLc9kEsTDdaGjhRUMtOE7FxuwyXMf2Wcr7vB13Muoo1WK8M?=
 =?us-ascii?Q?2CY0hZ64nblQTtkV8lVLBBaYbSaT+rSW9VJlZXmqJFqBy9YtuSxeUjYO428N?=
 =?us-ascii?Q?a+ndqyy9SKFC+J3BL9DDoFaqLNd0+W/k3rS/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zre+tk5w4O7lSSVXghhzF3bh21VAPM3iVZvELdR9zFRbY5OPMC268msiWZ++?=
 =?us-ascii?Q?QCOdLmr/Z4I5ySiIxOT9FFveQWK8Q0AJQ6u0LN8rFdDZAlTFON+lLogx2TGW?=
 =?us-ascii?Q?+4L5a+cd0XeicEdP/RKKiqrJ1IRat6Zc+e0vb5jmSZKkJ/f8Ka58ivwL4tV5?=
 =?us-ascii?Q?8OAs2J+mjRrFJzkvDId5htvx8l+toILf1g2mNmO8GKmmhrHYktTrjdt8CG+p?=
 =?us-ascii?Q?grNlIg5nBoarB49H8lJtsrbAL0xxvT0LR1JH+bJRpcUR9PdHcovsqTB3wU1F?=
 =?us-ascii?Q?obtig7e749WTjsrSlDiWYE2ZKnU67eWPbgbXu5NN+R4QhMFiwL3MpmOSvkvx?=
 =?us-ascii?Q?yAWpz4peWD98OcCKopv2FdgBW7tCpogRUq6/SOH8r2HG+VSKi3ukggr4QWzI?=
 =?us-ascii?Q?DZ9oO6tNpXcE8LVZO5aWrl65H2f2YTm4dHY6wosBYnEEbXRhZiszKcGN8Q+g?=
 =?us-ascii?Q?8gEc3JhTbBfEnJwa8zTNQz67hP+qgt2hh/V/2M2+Ahy/ACga68MF2Pv4cOWA?=
 =?us-ascii?Q?RM2ygJQXgc8786QPQzjNZVHz59igUTX7LPZLG9StcOnHMf8dPrn3OoVBtr33?=
 =?us-ascii?Q?ZN9VCPa5huKWMsSQ1NNOAr0nHP3LJLLithw5qnhElFnk0CpKcKMyfFDubEyX?=
 =?us-ascii?Q?CwmeuMXweyIIrom8wmxaE5L5F0GjwAzO7pxf3IqF3G5yPPkDdqBg6+XFuoRN?=
 =?us-ascii?Q?FWeV9J0aPzF4tN9obGDpKdg+x2gQk/trlveeVzy+GqbTihvu3V5u69gTX/CT?=
 =?us-ascii?Q?bMVlRHONRPILa694AEytmeYdazlnD/6g+jispmEYQkMq5satNCxC4LaLPzFg?=
 =?us-ascii?Q?nAb/6VvFnmh05SEKi+6oyH2FIWWoBJ2z01UIThox6nHKLZrjHl8t2d4vQfuq?=
 =?us-ascii?Q?oXWIgnY94OBIJUesOGtZpm9B9H7t6h3EYnSNh8mZMKevB129n+LIks17m0tW?=
 =?us-ascii?Q?3VFOVLMvHVGd+/3cinpSUh4GzZ0wGxDV6On421NmaYVuync+XEO7hURr3xbc?=
 =?us-ascii?Q?2RkWj2KmRJVTMDJU4/PlUeRCg0TY3X3YLltCW3Idp6i1gj9zaPC4CCJNOB1s?=
 =?us-ascii?Q?HTKG0UMu7E+n9tIGQaYXnms1t9V9SJVqCIlewSZgHdtUDuZocofJdmty8xio?=
 =?us-ascii?Q?pb48rfZ+3QPc6TotgNr8brFCGBQtSLz4ttI+BIljZUVuvBnNSxxDCG9ibZyM?=
 =?us-ascii?Q?gxogKQHhJG2Y3cKOBDlY+Aq1IfXQTS4DZH7B648EPg9eBkmbvc4l2D9HZoOd?=
 =?us-ascii?Q?2uayyuiZO6WAl5lqXZqWZi0I21KyHNEOOZG8dzYcOdqehse59D20Dm3E4cvD?=
 =?us-ascii?Q?uvJFCXqn8evMArCAoie8gujgpIdULzpIc1kd9kK06bqg5JYoN8+QhCnihG+j?=
 =?us-ascii?Q?JMzo43JV+Gau6/U2yj0Eab5Y9/VeMC6e0wi+mFPKtZ8q4aPEHHbxUX08iDYI?=
 =?us-ascii?Q?+eDWBZSgSktRfKyksPwr+yArgrTcLonBAsDG6rQfcHs4+z1UrtIfVMKh9VoH?=
 =?us-ascii?Q?TlXYup0vBQ/jFWDbE5jRcNlHM5oV2zdXJPpK4XucSe0kJ5fYQ6OPL3mqgnro?=
 =?us-ascii?Q?Xgwj+HZehjuwAeKbnTo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a3528b-1bc8-4780-c8db-08de0a4cafff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 11:36:01.9386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ER2g49yi2DEsC/R6X3pthEnRdJIdN7mGf/ahDJJTImzuFQKIlknqAOa9fuhGLULB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
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

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor =
Zhao
>Sent: Friday, October 10, 2025 1:03 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Chang, HaiJun <HaiJun.Chang@amd.com>; Zhao, Victor
><Victor.Zhao@amd.com>
>Subject: [PATCH v2 2/2] drm/amdgpu: use GPU_HDP_FLUSH for sriov
>
>Currently SRIOV runtime will use kiq to write HDP_MEM_FLUSH_CNTL for hdp
>flush. This register need to be write from CPU for nbif to aware, otherwis=
e it will
>not work.
>
>Implement amdgpu_kiq_hdp_flush and use kiq to do gpu hdp flush during srio=
v
>runtime.
>
>v2:
>- fallback to amdgpu_asic_flush_hdp when amdgpu_kiq_hdp_flush failed
>- add function amdgpu_mes_hdp_flush
>
>Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 71 ++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 12 ++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  1 +
> 5 files changed, 95 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 7a899fb4de29..65cc6f776536 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -7279,10 +7279,17 @@ void amdgpu_device_flush_hdp(struct
>amdgpu_device *adev,
>       if (adev->gmc.xgmi.connected_to_cpu)
>               return;
>
>-      if (ring && ring->funcs->emit_hdp_flush)
>+      if (ring && ring->funcs->emit_hdp_flush) {
>               amdgpu_ring_emit_hdp_flush(ring);
>-      else
>-              amdgpu_asic_flush_hdp(adev, ring);
>+              return;
>+      }
>+
>+      if (!ring && amdgpu_sriov_runtime(adev)) {
>+              if (!amdgpu_kiq_hdp_flush(adev))
>+                      return;
>+      }
>+
>+      amdgpu_asic_flush_hdp(adev, ring);
> }
>
> void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev, diff --git
>a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>index 7f02e36ccc1e..bf28e8ef6c14 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>@@ -33,6 +33,7 @@
> #include "amdgpu_reset.h"
> #include "amdgpu_xcp.h"
> #include "amdgpu_xgmi.h"
>+#include "amdgpu_mes.h"
> #include "nvd.h"
>
> /* delay 0.1 second to enable gfx off feature */ @@ -1194,6 +1195,75 @@ v=
oid
>amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint=
3
>       dev_err(adev->dev, "failed to write reg:%x\n", reg);  }
>
>+int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev) {
>+      signed long r, cnt =3D 0;
>+      unsigned long flags;
>+      uint32_t seq;
>+      struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
>+      struct amdgpu_ring *ring =3D &kiq->ring;
>+
>+      if (amdgpu_device_skip_hw_access(adev))
>+              return 0;
>+
>+      if (adev->enable_mes_kiq && adev->mes.ring[0].sched.ready)
>+              return amdgpu_mes_hdp_flush(adev);
>+
>+      if (!ring->funcs->emit_hdp_flush) {
>+              return -ENODEV;
[lijo]
May be EOPNOTSUPP - i.e., this ring doesn't support this operation?

Apart from that, the series look good.

Thanks,
Lijo

>+      }
>+
>+      spin_lock_irqsave(&kiq->ring_lock, flags);
>+      r =3D amdgpu_ring_alloc(ring, 32);
>+      if (r)
>+              goto failed_unlock;
>+
>+      amdgpu_ring_emit_hdp_flush(ring);
>+      r =3D amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
>+      if (r)
>+              goto failed_undo;
>+
>+      amdgpu_ring_commit(ring);
>+      spin_unlock_irqrestore(&kiq->ring_lock, flags);
>+
>+      r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
>+
>+      /* don't wait anymore for gpu reset case because this way may
>+       * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
>+       * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
>+       * never return if we keep waiting in virt_kiq_rreg, which cause
>+       * gpu_recover() hang there.
>+       *
>+       * also don't wait anymore for IRQ context
>+       * */
>+      if (r < 1 && (amdgpu_in_reset(adev) || in_interrupt()))
>+              goto failed_kiq_hdp_flush;
>+
>+      might_sleep();
>+      while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
>+              if (amdgpu_in_reset(adev))
>+                      goto failed_kiq_hdp_flush;
>+
>+              msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
>+              r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT=
);
>+      }
>+
>+      if (cnt > MAX_KIQ_REG_TRY) {
>+              dev_err(adev->dev, "failed to flush HDP via KIQ timeout\n")=
;
>+              return -ETIMEDOUT;
>+      }
>+
>+      return 0;
>+
>+failed_undo:
>+      amdgpu_ring_undo(ring);
>+failed_unlock:
>+      spin_unlock_irqrestore(&kiq->ring_lock, flags);
>+failed_kiq_hdp_flush:
>+      dev_err(adev->dev, "failed to flush HDP via KIQ\n");
>+      return r < 0 ? r : -EIO;
>+}
>+
> int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)  {
>       if (amdgpu_num_kcq =3D=3D -1) {
>@@ -2484,3 +2554,4 @@ void
>amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
>                           &amdgpu_debugfs_compute_sched_mask_fops);
> #endif
> }
>+
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>index fb5f7a0ee029..efd61a1ccc66 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>@@ -615,6 +615,7 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device
>*adev,
>                                 struct amdgpu_iv_entry *entry);
> uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32=
_t
>xcc_id);  void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg,
>uint32_t v, uint32_t xcc_id);
>+int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev);
> int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);  void
>amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id=
);
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>index 8d03e8c9cc6d..be62681b0c3a 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>@@ -523,6 +523,18 @@ int amdgpu_mes_reg_write_reg_wait(struct
>amdgpu_device *adev,
>       return r;
> }
>
>+int amdgpu_mes_hdp_flush(struct amdgpu_device *adev) {
>+      uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
>+
>+      hdp_flush_req_offset =3D adev->nbio.funcs-
>>get_hdp_flush_req_offset(adev);
>+      hdp_flush_done_offset =3D adev->nbio.funcs-
>>get_hdp_flush_done_offset(adev);
>+      ref_and_mask =3D adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
>+
>+      return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset,
>hdp_flush_done_offset,
>+                                           ref_and_mask, ref_and_mask);
>+}
>+
> int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>                               uint64_t process_context_addr,
>                               uint32_t spi_gdbg_per_vmid_cntl,
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>index 6b506fc72f58..3a51ace2fa14 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>@@ -427,6 +427,7 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,  int
>amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
>                                 uint32_t reg0, uint32_t reg1,
>                                 uint32_t ref, uint32_t mask);
>+int amdgpu_mes_hdp_flush(struct amdgpu_device *adev);
> int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>                               uint64_t process_context_addr,
>                               uint32_t spi_gdbg_per_vmid_cntl,
>--
>2.25.1

