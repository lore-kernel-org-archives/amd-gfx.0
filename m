Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9749DE7718B
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jan 2025 20:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076E710E1B8;
	Wed,  1 Jan 2025 20:41:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LpooiL/d";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC1A10E1B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jan 2025 20:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wC9Nf9DNAeGXXsxZ/SQTU9B5LsQR36ZrrtyCNAnzzs/HD8BXZt5QXEPGZki3g98syxo3ZxKLyruU2bPDxwy8U8zxvfCaDGrnoEEiOF3uIAlKuSA658RqatPeOJTYsbFYWmzr36BFfnd+9V+aqEWn6h0yxXbdncxbpocr1/EG1cBPNefLl6H3kmsd4S86cfwXiqORQ4VznuS4OdhWHxJaEhiPOl/7Oh5Vpc7yvB4Vd9qzkee9Ltz9wCEhaXhwYXcmQ79iwuG/u1iku0qoD58VvqOUFHb3yb/JU8tyZZXnq1o7aKpycaV933jWrVS+FAaDYLgugK2mtjjIMr3zvc5rvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAdd2quXJK4mI25J7a/xxlWdRjddKZ85glqzI9IGRSc=;
 b=vVoXsl8EJaOl1FlQN+AOhdc09eu2FNQGHW7b34deXqiUevEP9BbQxa+Z95G2xtmva7aLtafrr7yX5JYZT4A87gPf1gKToYpEcdUh03x1wfLZ5BAQiCRU0nYpNiYFS6u/7kcC3ezvHZyM9tEYYJ9KPmUHGu5qmoOXY2uY6cvLPj4qa5/pBiDE7UJok3qgqqR1+7JeKzpP5ZNbW3uW54TMRXF3clqZFmBBe0TNi8eL++p+HXJD8i0bo+YfwqCHBHwoI6zsfsnWGk8M/NsFtltFoF0FLBgVwrzfnQfxzLE5/2U3bsWsqquqdkK18PkZYfkAIugMv8VUiUKHFy1X0vFHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAdd2quXJK4mI25J7a/xxlWdRjddKZ85glqzI9IGRSc=;
 b=LpooiL/dC9G53hY5NUTAbySvsnNp51hRLQmpsSRhwC/9G46f43hGmYURWqupsMFaPCE5tzOWiAYi8nB9sgcc6pwz2LYhBmvLEG9HBPblmcREkKDlRRDuVsxMMqpwtq1N+mKSBEPUfTCCOhgIaP2Tog4M1KkOCMjaqfdkCNKOm24=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Wed, 1 Jan
 2025 20:41:10 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.8293.000; Wed, 1 Jan 2025
 20:41:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add handler for SDMA context empty
Thread-Topic: [PATCH] drm/amdgpu: Add handler for SDMA context empty
Thread-Index: AQHbXDOzBWAGl2MzPE+ChUUDi7w4hLMCYnxg
Date: Wed, 1 Jan 2025 20:41:10 +0000
Message-ID: <BN9PR12MB5257915B4F3B2E0F1DE52E79FC0B2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250101095758.847057-1-lijo.lazar@amd.com>
In-Reply-To: <20250101095758.847057-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=178da2d2-96f5-40fb-a2bd-4a2e7b83348c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-01T20:40:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW4PR12MB7357:EE_
x-ms-office365-filtering-correlation-id: ff1081fd-60b1-4eaa-f603-08dd2aa4a025
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Qv3Q8zlrdSYCm4HSpqMe5gtLUlM/gRFRsB+nEd+yh4C0Z8oWSLrNYaWCWWfd?=
 =?us-ascii?Q?xz65taHNsVBvdlC/F4zpwMV7ERedkZziMIsFerbqnZU6zD2wJhqZ5G8GV6nz?=
 =?us-ascii?Q?P5XRaNARikBlDRPTSeOla6hHRYSfQxR0s2dqpR2gRPPZyJ5cL10JlA+CID/r?=
 =?us-ascii?Q?OMrmGtGk5rzBm5lHnKSB9fCwrAoTDtsxMhdOzt798JEhmlHN1uR4czw8a9r4?=
 =?us-ascii?Q?LDCVaYIP0U9ECMzzC2SnBoS10KkoKbgGzrOAO9aFDmJaZsmPxnuwyvMsblml?=
 =?us-ascii?Q?ZB2KP6dWBvc9kXmnFhtCINIFVjkhU9fRBmbktjNlcmhphYDDuxQtG7SqlA7K?=
 =?us-ascii?Q?Kgzf6+vn/zoxn/i/yENFWPClWwnQcfIsZu9FStcHnUdazSj0uXq2HfnvSn5H?=
 =?us-ascii?Q?fXE1P8nJk19b6Ct4TYns01aSykpQylaPrphpulnTlbWvARh9YzxFnkKoRJDj?=
 =?us-ascii?Q?TRNvNoOYUDhfmP0JYT28UAo+YMLG/dwgr7CUO+VHdiAOIKbcrYE6IeZSkbbp?=
 =?us-ascii?Q?D//VEzRBxt7tA5oGutbn3TYtWK7ZCmwuDMDDp7L5XEFycfYXud5Keie+yV+f?=
 =?us-ascii?Q?YNJtPsvmRgTzo8TvpGd9xbMcM4gPEgxythhd2KIcwP8297fpej4nwALy1iLx?=
 =?us-ascii?Q?dV0zPlAVwVN5GarEOXYv37lTaaoJ0449GJdZiYUwprHlZD9TFzPW0JAUiqFS?=
 =?us-ascii?Q?0z+HV++yy/X0zpI6nggz9lYwBbdH2kzwUQyuwNPO9toTrui8NvVa6dRGAkNx?=
 =?us-ascii?Q?5IpMcU9NF9cZaQolC0tdTZx6xijjIcfdPkgxvOAEFzxJ1+xRNW2SInt8p5Kf?=
 =?us-ascii?Q?fabOlg4IuTwM1P9DIl5NEsUhCMzXyn5viHXkg1TdOMBmsYkvRlPsBLKtFCV7?=
 =?us-ascii?Q?9zUJbOHAO8iDV/U2y4YOMKmtIHB6OJj1KjYgMBd4SJjbhg3TpOCLez5bNZAh?=
 =?us-ascii?Q?gytX6tsGTsfGOoegenrgrvdyTHIQZc0pUzg0Eq8Sc33pFXG3L61yrISdwRUE?=
 =?us-ascii?Q?8qvjHN5Wvm2Em68y6ztBmpq3BCb+BbvTbMNyiyjlO6ecJ4RpYzaJxSc6xnSH?=
 =?us-ascii?Q?YEFJd0G306VnoluGed8Vh1TT7PAPgQLiwuCGA5RN1x1x5QYcX9om/Jh9zj3I?=
 =?us-ascii?Q?gOJTk7Q4NCkDY4jJnwexTMxFwfBWNSTWBbs5eRHIdZykC8LcexfizYfD7fzV?=
 =?us-ascii?Q?d28wCqit8z4C4ClJYrE830+35l1/e5Td4F63tdjURFxMKjHb6jBhXBn4SotA?=
 =?us-ascii?Q?pA5Wfa23HhPPskYsQ5bLIylNnMsyqUg02UHJLElKklRxei9ocHJEQE9Lkxsa?=
 =?us-ascii?Q?VciE0E65CE8JtOX7VPDu7o+l63779n8CjrciNhtimG8LG/pWnSP5ZX4g7zop?=
 =?us-ascii?Q?N6JNsdGIauBF7GZk7k7Efg7JKVQ7zAPkMeYqZIpKseL+sHvpVgdHgERgM1x2?=
 =?us-ascii?Q?JPxe2+qL3D3Wix+I6K/hcT63S57mx9AO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3SkYoodIo8C3EH3mVTQf4CCRtG3yltuCVwJu+Psz+VjH/gGvuPdTyhneiTcH?=
 =?us-ascii?Q?yXa1P9wXHv3uiq6GSFAw0O46dSN++TmGY/cMJ00vumaDPIf1ZUutxaJ6FbGf?=
 =?us-ascii?Q?8k7775RiSZWVLipeJKuCCnAYHWvC4lKH4tztKwbAT78GY7QBG5uir4+rxxuW?=
 =?us-ascii?Q?S4E7v7aKAPrjYfszfys7vNCO2sukcZ/QbMnJ+JQA2jy0XYRoyCEq/fNXR/Ac?=
 =?us-ascii?Q?ZlHlcdGx5GhIVO5sfWU7ikFRCKDeVfBkQKLlHcFD349BGFhYKjtVfK0xbbVG?=
 =?us-ascii?Q?KOAAHDu+cP+XWKOEmZcvFh90YQAxOVvtXo1SaHmk+RGpDtZkQUhJo9xh8AtX?=
 =?us-ascii?Q?d2EJOZRlUsb2QLLp0zan7LWBoV11lvDKiaTrTaB2VETMuVGAxkeVz8IddGjO?=
 =?us-ascii?Q?IYHAoT6+ALJ44q9HR1cUa4+fIDZIrbiaN9eNSaxOx7mSLxmpvkb96P2K79fA?=
 =?us-ascii?Q?c4pN3NIGDyh9cV+CXiGxtLBrb+Rr4fcog2+/1idiyUA9YODTba3I8UGbDtuZ?=
 =?us-ascii?Q?3wUE+4jb3KivX8RGwxeISJFA85U7NNnYdxKRtTVviwvBVfoiv9DeZ19X0+PT?=
 =?us-ascii?Q?XoyPSzowZoDjcOPdGHFf0lUw3z710D6EkD4acbctvkpWYeJ2kZAzOQFLvRD5?=
 =?us-ascii?Q?4GJSNL/9K3grWaHI7k3S9KAtB1g4K6kW3IVLBNk/8AxGXH7AdXzWCe5UeTvI?=
 =?us-ascii?Q?7WUL03dnwgx+J6k3hs10K4HblFaaRIQ7jw/NSfVBjeQLbR+njhPCShNsD/tq?=
 =?us-ascii?Q?9lPyHS7V0252lv6rDrdu0AHvD35qRLQ5IUxieM2t3vdKh2Tj4mJkqDOW+qBJ?=
 =?us-ascii?Q?wV99dVCwCy4JdSmE/+Ph5lQFfXAODBS0Irn6Muhv6GHgFiuMvq0bqIF6YI+q?=
 =?us-ascii?Q?+cT9WIfSO8wQT5UryT7+oDzZl9Poq6uZ1M0YUmObK1jbCabOjWUvs1G7lah2?=
 =?us-ascii?Q?pgD1aEqpOf2EQ65JChOELb0XZLYZEdIuQASyXSPCZcUrnoEvy3ncX149huvU?=
 =?us-ascii?Q?r0wfmpvZRbeXcGKjcs8erVTXPa5nuWuXLmFOYtagpiLPqfev3iwfP0fXghBY?=
 =?us-ascii?Q?sbKadELW/kiWgFtdFzbEujZiTnRRCHf04PZ28xpK9RXF/0pQp9/Ah2dHgJOm?=
 =?us-ascii?Q?oX+594qh7W0NYqr2KCFSdH4i5kZSIw4yURkkBKlgCVGpEEflzCBlpDXrLzGD?=
 =?us-ascii?Q?CxmviXHvL+Bq6Wi3bs38jSKhZ+rEeSNQwT3uPgyuOLTSehY/+sAG/zoqkz6h?=
 =?us-ascii?Q?SqMfnrhDTYgB6NGt13fGoDSeby8hw/iudpC4yMrZJfdU+qyciSs4Ez90ADkL?=
 =?us-ascii?Q?MO8veQwYaF/BI0i67ovb6jtft5DH3CnUE7us+7p4An+Mdi9ztq/iI+QzSTOD?=
 =?us-ascii?Q?1KOiXAVcP2JaKpc7r95Cr2Km0CuuLPiWspHNG9/gQtI/dCmb7w2Ei/8q+zyO?=
 =?us-ascii?Q?lk9lM8U2rzkC0q1E14P4GajyM5hYzlhmubR7KD8yhTuhTo+MolgMlH0UXB04?=
 =?us-ascii?Q?LC7G+crT+VqFucPFP/kWtOgKFaf6rlOOQt1AW5totzE5Fhnm6lmjJ8vQ7hdv?=
 =?us-ascii?Q?Gb3ggBhpyBkTtduu5sM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1081fd-60b1-4eaa-f603-08dd2aa4a025
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2025 20:41:10.6015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dO+V/qSSylFZfSLHbUFpTWACMP/d8bMlItBM/28CdFXMEiZr6cVy1BkwUChXOTgrTqpXzRFJXoVG4gheTUt1Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
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
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, January 1, 2025 04:58
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Add handler for SDMA context empty

Context empty interrupt is enabled for SDMA 4.4.2. Add a handler for contex=
t empty interrupt so that it is disposed of fast, and not propagated to KFD=
 layer.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +  drivers/gpu/drm/amd/amdgp=
u/sdma_v4_4_2.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.h
index 2db58b5812a8..5f60736051d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -107,6 +107,7 @@ struct amdgpu_sdma {
        struct amdgpu_irq_src   doorbell_invalid_irq;
        struct amdgpu_irq_src   pool_timeout_irq;
        struct amdgpu_irq_src   srbm_write_irq;
+       struct amdgpu_irq_src   ctxt_empty_irq;

        int                     num_instances;
        uint32_t                sdma_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 56507ae919b0..5f1c6ae7202c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1406,6 +1406,12 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
                                      &adev->sdma.srbm_write_irq);
                if (r)
                        return r;
+
+               r =3D amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(i),
+                                     SDMA0_4_0__SRCID__SDMA_CTXEMPTY,
+                                     &adev->sdma.ctxt_empty_irq);
+               if (r)
+                       return r;
        }

        for (i =3D 0; i < adev->sdma.num_instances; i++) { @@ -1814,6 +1820=
,16 @@ static int sdma_v4_4_2_process_srbm_write_irq(struct amdgpu_device *=
adev,
        return 0;
 }

+static int sdma_v4_4_2_process_ctxt_empty_irq(struct amdgpu_device *adev,
+                                             struct amdgpu_irq_src *source=
,
+                                             struct amdgpu_iv_entry *entry=
) {
+       /* There is nothing useful to be done here, only kept for debug */
+       dev_dbg_ratelimited(adev->dev, "SDMA context empty interrupt");
+       sdma_v4_4_2_print_iv_entry(adev, entry);
+       return 0;
+}
+
 static void sdma_v4_4_2_inst_update_medium_grain_light_sleep(
        struct amdgpu_device *adev, bool enable, uint32_t inst_mask)  { @@ =
-2096,6 +2112,10 @@ static const struct amdgpu_irq_src_funcs sdma_v4_4_2_sr=
bm_write_irq_funcs =3D {
        .process =3D sdma_v4_4_2_process_srbm_write_irq,
 };

+static const struct amdgpu_irq_src_funcs sdma_v4_4_2_ctxt_empty_irq_funcs =
=3D {
+       .process =3D sdma_v4_4_2_process_ctxt_empty_irq,
+};
+
 static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev)  {
        adev->sdma.trap_irq.num_types =3D adev->sdma.num_instances; @@ -210=
4,6 +2124,7 @@ static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *=
adev)
        adev->sdma.doorbell_invalid_irq.num_types =3D adev->sdma.num_instan=
ces;
        adev->sdma.pool_timeout_irq.num_types =3D adev->sdma.num_instances;
        adev->sdma.srbm_write_irq.num_types =3D adev->sdma.num_instances;
+       adev->sdma.ctxt_empty_irq.num_types =3D adev->sdma.num_instances;

        adev->sdma.trap_irq.funcs =3D &sdma_v4_4_2_trap_irq_funcs;
        adev->sdma.illegal_inst_irq.funcs =3D &sdma_v4_4_2_illegal_inst_irq=
_funcs;
@@ -2112,6 +2133,7 @@ static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_d=
evice *adev)
        adev->sdma.doorbell_invalid_irq.funcs =3D &sdma_v4_4_2_doorbell_inv=
alid_irq_funcs;
        adev->sdma.pool_timeout_irq.funcs =3D &sdma_v4_4_2_pool_timeout_irq=
_funcs;
        adev->sdma.srbm_write_irq.funcs =3D &sdma_v4_4_2_srbm_write_irq_fun=
cs;
+       adev->sdma.ctxt_empty_irq.funcs =3D &sdma_v4_4_2_ctxt_empty_irq_fun=
cs;
 }

 /**
--
2.25.1

