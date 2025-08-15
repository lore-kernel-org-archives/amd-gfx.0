Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5E4CA0EE4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Aug 2025 08:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4D410E8ED;
	Fri, 15 Aug 2025 08:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yRPMG3s3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B76E10E8ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Aug 2025 08:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zO9OfKgdCVgHQ2Y7UTiVj8h7FaHMptVChP58XZmZwxdM/wv1cpc9P6IdEoeGLvkmvyrFGukmZ6dSjeFNA60v0S9xhr6sap+9kO9AV14nmcBoRWgbcIFfd0w7Au363jlNiH7OLTUNqIpqWU4wVHNDCFs/QCCy1E9OTkzJlxfqY6C/0AfV4tgOWjz23lZLHlHTHOQTajTE4xSySSUwnv49WKjUpbQjVR0i282SQS9Euz0XKtUvp019oL1LRNOWNtg45LRHN/1Jx/riwxye5MMUHwUt8qPj+Z6uhjR2FsxhsVd6YkTV/Mk8z7GL0gtEKoGHSzkFFpjQX+008GpvaHIolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MV4At0mFx5vFWR7L2Tg5o1/iufZ0Mwf3wKvmSCePxQ=;
 b=wAdejtXEgYeil27BMH/C6qswaq8CDS+ohHQowTpLx6kAA47GDoSJSLJhjLnLPvBiX0Ccz3omUr6PRXTm1Ycr0zu+PdhA6/iE3v3iTTDJBqzf3o/DLZ8X+EjCahObbCvC3yaJGVjMRjcI1oX0ma37DWm0LICvR75d7gU7LpNm0GsYSbdsXkK4O/a9RXMqS/ZPtlOCeFX407Hw8ESY+7iwj9NhxxDdF11FnlYwDM2fXIJ+Nvd850Ov//mf8+MfOfU1fdEZISoOxZh2eQSotg1r/F5hGNKYX8WPRmMkWJMobUPqt2eGsehggA6jYT6pUABq670z0kP1ohCwmowfcDC5+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MV4At0mFx5vFWR7L2Tg5o1/iufZ0Mwf3wKvmSCePxQ=;
 b=yRPMG3s3SnmqFJUHn23HufS/THxzERXYvnVsGAsxAyC2WzPLBUxveOUV/5N3gT5X2rZw8fGGgYAZ41gv1Mu1dCFdgFXsOa4yCAXfFWGrXhS8piv2KBcblLN2Rfs/qCzrAcGx81GAvKEdOU+bRcnjyofKJ7BZAva7a76IYAsnMjI=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA3PR12MB8000.namprd12.prod.outlook.com (2603:10b6:806:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 15 Aug
 2025 08:57:12 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 08:57:11 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 4/4 v3] drm/amdgpu: Correct the loss of aca bank reg info
Thread-Topic: [PATCH 4/4 v3] drm/amdgpu: Correct the loss of aca bank reg info
Thread-Index: AQHcDZrLioAR+LmIl0KcelcTsDuwprRjaC7g
Date: Fri, 15 Aug 2025 08:57:11 +0000
Message-ID: <PH7PR12MB59979593A1F345722DEC282F8234A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250815041158.301031-1-cesun102@amd.com>
In-Reply-To: <20250815041158.301031-1-cesun102@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-15T08:50:47.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA3PR12MB8000:EE_
x-ms-office365-filtering-correlation-id: 71382d5b-9d83-4467-691d-08dddbd9b90d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?caSnsZ6zjRdpZl9ePbRuYX3pktMviGI+ExRrofnl3wAvaTYnXL2bUlmXfuqt?=
 =?us-ascii?Q?r7a5Gjao9MDQXFXXhS0peUPdRoMOLS6yr36wx4ewBvF1EkEY13VmCsGT7OJp?=
 =?us-ascii?Q?sPWPu/TnozVQEEXQg8jeRVBdRxc8ro9JdJZmIYPWrjxNp1BGHuSlMaqbGNwA?=
 =?us-ascii?Q?k3my8SMQevgc37DqrzVQqXYti6TySbzrakEfIUXBXxgEgvwZiecNK2wdTW4l?=
 =?us-ascii?Q?TxL8fPINelwD/oXX4kqZ+bIyf/GrHZlaFz11beAVB82n55KVkZNfHOl6kLRe?=
 =?us-ascii?Q?RW7D9kjtgiFpOvF9uCtd+gFSPtkVeCnzjUZAWdLTvog/HP2Y8VGoSLGPJopT?=
 =?us-ascii?Q?Xc0uBGaBh1/ppDl++5EcXEdfdZAJOyxhJi60SF0r5ey898mi+VAzyjZUyukB?=
 =?us-ascii?Q?jaIsno9gj5faKR0ZnPdn0GPZH2WU/1HxzFVkRmnP8+uyuF6425c4zYCt9D/7?=
 =?us-ascii?Q?2djHVdGKhj/97jJ3BbhCcbSeY7oAmss1IiIvEkVoxItmq0gdBKfkT3eZ5KC9?=
 =?us-ascii?Q?XUwsvgu+KDUVDRy9GTEjbn8hyaD3Sa73wJmiVobRozorLNUYMItTfZSh6SKd?=
 =?us-ascii?Q?j+13AKV+VsBLw1tevHTxp/z9ApbIkznpRbmv9XKzsH2Y0AloeeNxPz+WHICe?=
 =?us-ascii?Q?Ufa+ElvvylmM13x4JCHv/+a983x/GNKMmqdQGk699P7W7L94yNigafG6Y1Hf?=
 =?us-ascii?Q?vuTi8X2FqgzjkGrOTQFX+wSL2r3niQlAgEMQHGMtIVqQLX+XzcWDPRcBUAfr?=
 =?us-ascii?Q?jvp950rQCxvWuFRTx3esMJtsOSeISzaBpiy7KPO17qaMyDu9Mw/gugx/A55O?=
 =?us-ascii?Q?4CytZMtxHIdEpAbNZQkP0EefpqUxkT30dvIwurmzfUsgz+UFZHiTQ8/OJvc8?=
 =?us-ascii?Q?AgYfskKYKCWBHQ5/uu49mOv8DwpiWxoR5ioSmNeoHAkH/MTlA+gwDeDpVGjn?=
 =?us-ascii?Q?RJQecG1b+HUzJYoSqO5IN7GnIQMGLn78n00lebje3R8w8xRaZyfT9F1UFDyd?=
 =?us-ascii?Q?1zeoI42EC+K1w4KCK9O8frW4tnSpOoEy4VBANSn3OxE8dhQ3CR9CRkfgoMfU?=
 =?us-ascii?Q?wMG0zb2PRDZjr/hC3UKEz0GIWL3gftfAHZLo4PnzH+9FJsVRTqsVYGGsaWj7?=
 =?us-ascii?Q?JNjgybsRT1So892+M/BxABTjJM+qO0Ue7ojRKfb92bZS85PEpsZfUPGBpRGD?=
 =?us-ascii?Q?+Oxvqvvtm826IeALWat/IZlSoakUKr8zUwh3xUPoaO8p9Qdm+/eIEgOGXGQ6?=
 =?us-ascii?Q?ekJsfeTJpauPqXufFAJy+jtPEQd7GSE+JpUa6Bl9BxrSpY9NEtqNvujybvet?=
 =?us-ascii?Q?BHxBRZKthm/hX2qDg7GhLb5lrHMnr3GfpV2Gdht2nNI0FChPHwqhddWUxHIJ?=
 =?us-ascii?Q?xeFZAOv6ymyOq0moJtjA3R8N2mgiSUyFc4Z4bDGxiGB/e/ALV64oybD7eCU4?=
 =?us-ascii?Q?ZcNCq0evCs6i8o6+98nb9/1VVeAQBh8Mj+RYeSkt4EwZRs4mzbe8qIDV+0BE?=
 =?us-ascii?Q?BcIM/e2TKMHiPaI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lpdfZh4kVkOWxJht5GDcttcX7m6shEyD6IshL+IQ/3aseNj5jky1M0zrstGZ?=
 =?us-ascii?Q?xlQOT7Sa4nnF5l+3x5XOyIdqkVV1zrLbYGbQyX3+Qugl6MLOmz/w49FGEu86?=
 =?us-ascii?Q?oMXhXYyTQuhrNCO3lE9vapV1bJsjs2dV/WyzGv8HepsgxoZJRGR5yGUJhTIk?=
 =?us-ascii?Q?bPtfkz9D+3gYSv50o0E6Vnwijiq6MbpeoLP+/K+SA6oLvbmFhSk+LCQ5L7fb?=
 =?us-ascii?Q?9eGd/v1r0r8n1ENXqdHTeAnMQjcZJtgKMIiqJBya4RN9DKdgR+UmTvXQ7wcD?=
 =?us-ascii?Q?k8jZhp3uJeJH4IhyBcL0agnux94QhHmddNlGHnPZdhk4NU73b7dpxAH4PaBe?=
 =?us-ascii?Q?6opu6Yr9ELxdyfG2uFZtXDy64UDNb0jgjulGdzX8Fz/k/mRWCM0RO5gMj+e0?=
 =?us-ascii?Q?Loz4GIS2nM7H4qQ4YLpb2AotGX0YA6/oHKVO+BsW47RCzGFEQxLadHsAHZZt?=
 =?us-ascii?Q?KvO6TS0OzopcKvnO/MB5agn09n9iGmpKchdIVw0DQRPXpHV4J4I5aVn2h9s7?=
 =?us-ascii?Q?TR4qQDrGpnJJA2SUfA3E78AWrCWNduIh/NL9xJW7tp8dy2f3+lS7Lt9LeNie?=
 =?us-ascii?Q?FsPBczg5jpC/rjCAmJlYEXUQz9MrImDiQDvV+bgPsqpkPDJgtAw17H4A/7C4?=
 =?us-ascii?Q?tFpXZMqhjr3ntu/n2KonJrhSDpRZT0iMAfKFvQD1qJGIiX+TVYge2q0nIrW3?=
 =?us-ascii?Q?HAFzQ3XZFnfpguPAm7/9N1K3cQgSiT8fQBe8526sHRRWlE+1rWelDfFQ7IEm?=
 =?us-ascii?Q?jDjXP20ZArWr5xu6BeuboOhcxSgcx8QBkZEHT5mJ0JKALnTGboubgQG/EwiG?=
 =?us-ascii?Q?JVHdkKu1B9OKqK6eP6oQcsrtGYMDk068W0QaU+/8EKvYyEarCosPAT23ylco?=
 =?us-ascii?Q?QQOMTI+cKha9pvuhcrTUN+1ux5QpY/j5Nzc8HyR+8Y7O6x1CbkjPc+oypHPQ?=
 =?us-ascii?Q?hWwjv6QIny5w2/RLS3sJfNYgVsJbRjftlH/0Zt8k2VVuo+TieUX5ai0xzQo9?=
 =?us-ascii?Q?7GZT/uJNfiL0uUGh9G57v1hk/yy4G5NhN6ZCDe7MWkMLAwjw+T+xKde0i/zD?=
 =?us-ascii?Q?A1MT29+U1JfONF7AXq/adXM/zZYw8QHF/pIK2dpsK96NI3W0f4WLD8/gsyoe?=
 =?us-ascii?Q?azmuR67Q4zpCtPEkZXtBtG/YKk400THH+Ae1mvzESGZq/VnGIxNASx+jzdgS?=
 =?us-ascii?Q?WzKUzgl4V0RlK/Yf5cg7GVxOP7quDZ32e2zvunBF2N78Xg7i11s89pZwzfqx?=
 =?us-ascii?Q?ibfEfkv8azLNii6pDVCVtXnA4fihwGk99fjj8GYhAvNMsPd6qhiqgghG4AD6?=
 =?us-ascii?Q?A+DkP02mCgSOZhlMjwZQEtDXNlX5EdnkxV0NDgzjVomtd01+5MuODdG6Q2+E?=
 =?us-ascii?Q?+Yvv9tKyI3zLH/CljIc2uY4WjX1ZbGEjmTxP8sPIeCRJum0Ixr1sXg6EzkQb?=
 =?us-ascii?Q?DOWsAYbQAl3SvVAvlZUXTAUsE4UrjqphtIvmJqkGLVIZU9HoEzBEuLlyv6I0?=
 =?us-ascii?Q?0ipJiMOd0yxAEgmZruhzE5gsWcpr7VmSNNthr15XrW7JX/7y6s1lTAMK2OyV?=
 =?us-ascii?Q?/ZEXooFwl93WPt77rqM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71382d5b-9d83-4467-691d-08dddbd9b90d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 08:57:11.5319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9OY7RWvM5Uzsq356/pFbqwqhHWebZqNIrCGE8b6X41l1aj+v/eGcOasbcvtAAHwz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8000
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

+
+               bank_count =3D amdgpu_aca_get_bank_count(adev);
+               if (bank_count) {
+                       total_bank_count +=3D bank_count;
+                       amdgpu_aca_clear_bank_count(adev);

I seem to have misunderstood the usage of 'bank_comunt' before. If it is on=
ly used as a marker, it is best not to record it in ACA as it seems unreaso=
nable.
If you only want to confirm if there are new ACA banks available, you can r=
ecord the bank sequence number outside and compare whether the new sequence=
 number is larger than the saved number.

Best Regards,
Kevin

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Friday, August 15, 2025 12:12
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@am=
d.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.c=
om>
Subject: [PATCH 4/4 v3] drm/amdgpu: Correct the loss of aca bank reg info

By polling, poll ACA bank count to ensure that valid ACA bank reg info can =
be obtained

v2: add corresponding delay before send msg to SMU to query mca bank info.
(Stanley)

v3: the loop cannot exit. (Thomas)

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 65 +++++++++++++------------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  4 +-  drivers/gpu/drm/amd/amdgpu/u=
mc_v12_0.c  | 12 +++--
 3 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 31850a47a41f..9ccc1fbca14f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -122,7 +122,7 @@ const char *get_ras_block_str(struct ras_common_if *ras=
_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)

-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  300  //ms
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  50

 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms

@@ -131,6 +131,8 @@ const char *get_ras_block_str(struct ras_common_if *ras=
_block)
 #define BYPASS_ALLOCATED_ADDRESS        0x0
 #define BYPASS_INITIALIZATION_ADDRESS   0x1

+#define MAX_BANK_COUNT 12
+
 enum amdgpu_ras_retire_page_reservation {
        AMDGPU_RAS_RETIRE_PAGE_RESERVED,
        AMDGPU_RAS_RETIRE_PAGE_PENDING,
@@ -3306,8 +3308,8 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_lo=
g_info *ecc_log)
        mutex_init(&ecc_log->lock);

        INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->prev_de_queried_count =3D 0;
+       ecc_log->consumption_de_count =3D 0;
+       ecc_log->creation_de_count =3D 0;
 }

 static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log) @@ -=
3326,8 +3328,8 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_in=
fo *ecc_log)
        mutex_unlock(&ecc_log->lock);

        mutex_destroy(&ecc_log->lock);
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->prev_de_queried_count =3D 0;
+       ecc_log->consumption_de_count =3D 0;
+       ecc_log->creation_de_count =3D 0;
 }
 #endif

@@ -3381,49 +3383,48 @@ static int amdgpu_ras_poison_creation_handler(struc=
t amdgpu_device *adev,
                                uint32_t poison_creation_count)
 {
        int ret =3D 0;
-       struct ras_ecc_log_info *ecc_log;
        struct ras_query_if info;
-       uint32_t timeout =3D 0;
+       struct ras_ecc_log_info *ecc_log;
+       uint32_t timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
-       uint64_t de_queried_count;
-       uint32_t new_detect_count, total_detect_count;
-       uint32_t need_query_count =3D poison_creation_count;
+       uint64_t creation_de_count =3D 0;
+       uint64_t consumption_de_count =3D 0;
        enum ras_event_type type =3D RAS_EVENT_TYPE_POISON_CREATION;
+       uint64_t bank_count =3D 0;
+       uint64_t total_bank_count =3D 0;

        memset(&info, 0, sizeof(info));
        info.head.block =3D AMDGPU_RAS_BLOCK__UMC;
-
        ecc_log =3D &ras->umc_ecc_log;
-       total_detect_count =3D 0;
+
        do {
                ret =3D amdgpu_ras_query_error_status_with_event(adev, &inf=
o, type);
                if (ret)
                        return ret;
-
-               de_queried_count =3D ecc_log->de_queried_count;
-               if (de_queried_count > ecc_log->prev_de_queried_count) {
-                       new_detect_count =3D de_queried_count - ecc_log->pr=
ev_de_queried_count;
-                       ecc_log->prev_de_queried_count =3D de_queried_count=
;
-                       timeout =3D 0;
+               creation_de_count =3D ecc_log->creation_de_count;
+               consumption_de_count =3D ecc_log->consumption_de_count;
+
+               bank_count =3D amdgpu_aca_get_bank_count(adev);
+               if (bank_count) {
+                       total_bank_count +=3D bank_count;
+                       amdgpu_aca_clear_bank_count(adev);
+                       timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
                } else {
-                       new_detect_count =3D 0;
+                       --timeout;
+                       msleep(20);
                }

-               if (new_detect_count) {
-                       total_detect_count +=3D new_detect_count;
-               } else {
-                       if (!timeout && need_query_count)
-                               timeout =3D MAX_UMC_POISON_POLLING_TIME_ASY=
NC;
+               if (creation_de_count && consumption_de_count)
+                       break;

-                       if (timeout) {
-                               if (!--timeout)
-                                       break;
-                               msleep(1);
-                       }
-               }
-       } while (total_detect_count < need_query_count);
+               if (total_bank_count >=3D MAX_BANK_COUNT)
+                       break;
+       } while (timeout);
+
+       ecc_log->creation_de_count =3D 0;
+       ecc_log->consumption_de_count =3D 0;

-       if (total_detect_count)
+       if (consumption_de_count)
                schedule_delayed_work(&ras->page_retirement_dwork, 0);

        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 6265dac0e1c0..b4eb427409ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -492,8 +492,8 @@ struct ras_ecc_err {  struct ras_ecc_log_info {
        struct mutex lock;
        struct radix_tree_root de_page_tree;
-       uint64_t        de_queried_count;
-       uint64_t        prev_de_queried_count;
+       uint64_t consumption_de_count;
+       uint64_t creation_de_count;
 };

 struct amdgpu_ras {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index e590cbdd8de9..11b99095efd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -536,8 +536,14 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_d=
evice *adev,
        hwid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
        mcatype =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType);

-       if ((hwid !=3D MCA_UMC_HWID_V12_0) || (mcatype !=3D MCA_UMC_MCATYPE=
_V12_0))
+       /* only creation/consumption defer error can access here.
+        * MCA_UMC_HWID_V12_0/MCA_UMC_MCATYPE_V12_0.
+        * It is the hwid/mactype of the consumption defer error
+        * */
+       if ((hwid !=3D MCA_UMC_HWID_V12_0) || (mcatype !=3D MCA_UMC_MCATYPE=
_V12_0)) {
+               con->umc_ecc_log.creation_de_count++;
                return 0;
+       }

        if (!status)
                return 0;
@@ -582,7 +588,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_de=
vice *adev,
        ret =3D amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tre=
e, ecc_err);
        if (ret) {
                if (ret =3D=3D -EEXIST)
-                       con->umc_ecc_log.de_queried_count++;
+                       con->umc_ecc_log.consumption_de_count++;
                else
                        dev_err(adev->dev, "Fail to log ecc error! ret:%d\n=
", ret);

@@ -590,7 +596,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_de=
vice *adev,
                return ret;
        }

-       con->umc_ecc_log.de_queried_count++;
+       con->umc_ecc_log.consumption_de_count++;

        memset(page_pfn, 0, sizeof(page_pfn));
        count =3D amdgpu_umc_lookup_bad_pages_in_a_row(adev,
--
2.34.1

