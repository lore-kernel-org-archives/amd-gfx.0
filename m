Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CEFCF9C67
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 20:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2631610E0DF;
	Fri, 20 Sep 2024 20:54:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ABz43Tf";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44C9D10E0DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 20:54:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMIrW8ZulEiOQTdW2isUx2v1eUcSd4Al6p4o5W0HavbmKpJsjnwPR9OwYPE6gH51bwSo7cgxXHZbhCw458EKw7pf4GNB8e66qdaTCXZZLbNGNkNICYTwONu2CwZhXBpwRg2Ztr1S98bRqrxhLCnMfdks0ePy3gL43qKNzJ37W76JPzj7eY4dvhpOYckutagRfvXDDfDkErDsuVIyySrwqJHtsCK7T/xVwKFkczDU7Rb49gK9qOYQQgs/oGBToPq99xcsQvyHVmYQ7VC+mJTqu2yh4KibT84FhRPyKEO9Oqx+zqP+00eM3ROEfhsjTHFMhjXtUf8maMmqHPGH7+h0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH1EjrV3sky5qtrTQTr+hUc0UyZh3gVff5Yst9EXbWQ=;
 b=o2T0MFfW7rIAnrE+WTURWVmoRrPMhrMDNJ9VwZBSzN9otrkpoxknaDa65UlIEdHszGVDFlcu6HXp+1kkh8kbGWxclllrV44MR6Pdm5SR6XK0SzP8T8epiixJrV8rMliBLQALbkRlVbgTjmvSPYOVlyxj/2vbvPqy1O5T7Q1bOIO6o0QLfnhqE3tfIrj1BlbWZfCNvm1ApBNyh0+1K1bjGqPAQj+zlPiVuFI4kXhcWQmIlNUKnaHABgvgZzYT0gHs7g0FXnq0eWyjH2Q8x1ng7wu3aeUYkruRu2UGqvIfI5IyU2YfUnrBmAVmXnkqwz4D/r4GDn90bUBTateg0GHwyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH1EjrV3sky5qtrTQTr+hUc0UyZh3gVff5Yst9EXbWQ=;
 b=4ABz43Tfk9qStvnnWovCZ+pUrv4XO0Z65C2ljReGKM7Sk9BbGPD0MJEbXeTjWnS1ryKSlJaCgVAn3J8+IrgMrzBDWew3FQemz6zDTrjIrAwyNu85yBtNMWIm31YJW4HL51QIXJtLctq9BqnPUoiTZ2Ym8TWzKNLrKaMePWd/qCk=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Fri, 20 Sep
 2024 20:53:58 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%7]) with mapi id 15.20.7982.016; Fri, 20 Sep 2024
 20:53:58 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Add SDMA queue quantum support for GFX12
Thread-Topic: [PATCH] drm/amdkfd: Add SDMA queue quantum support for GFX12
Thread-Index: AQHbC3g2OEAbBbrhc0q4EduZAHjPWrJhJ1lw
Date: Fri, 20 Sep 2024 20:53:58 +0000
Message-ID: <CY8PR12MB709915BE625ABA24F01690598C6C2@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240920161406.877600-1-sreekant.somasekharan@amd.com>
In-Reply-To: <20240920161406.877600-1-sreekant.somasekharan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9267fd86-3f8c-4e6f-a106-f3ad24265a72;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-20T20:53:28Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|DS0PR12MB7747:EE_
x-ms-office365-filtering-correlation-id: 410e406a-3df0-44ed-55c5-08dcd9b65908
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UiGtjNjutfSzu6MTD+Pt5M3d+0hPoRnhBFU1tQyaPnM5jN8EuT2IvmvknFlr?=
 =?us-ascii?Q?W1oyuPTR5kox4qTAkwsdcFR9dN6RHDUfMksfA8g75Ibq86fORHyppkg0sphw?=
 =?us-ascii?Q?EHErs4qpXUQdwMr3AMimGtNjt8ILYMfEVq+cle91ZrF9PEnxrggvGDeUAXQL?=
 =?us-ascii?Q?kL9OHK6iCD0EQ2FzCdu+RWWkRmLMfaOuzLc3UhHS3dgjNj9BoD+LLKnpmxoZ?=
 =?us-ascii?Q?6vgAIWCDWuEvpGlRSpBmzvDPs/xxzcHZSKzHP1W+EeP5O5DriucstHVulxFU?=
 =?us-ascii?Q?6rWcHSffhnwjE/GFj/kNe80hvdZB+7tGW/dvKsFrQblDuroGMavuDzAvUGdJ?=
 =?us-ascii?Q?QLb5+hlMx+13Ol85rheB78UwjXVaGIY6AHxyv78kfiBcdSmpS9SJwj4GltYk?=
 =?us-ascii?Q?UEERv4E7Q36P5r6AFwfhjjZnBE+hwUhDAukWHsK2yYJhyAoSBMseepozJiu5?=
 =?us-ascii?Q?INlE4s09vk3KyirsBV06BuvHhg8bbEcYhJvcfqz7zouOa7YMU3mBSeH/g/p0?=
 =?us-ascii?Q?rfpa8S1cFzq1qFzByZjNlPBS6FCpwWowoQKNSd6XK+US6DCiMhFa1K539orr?=
 =?us-ascii?Q?HYbRhGxujCVunrkdOzhaq+alsbmCdWcBSvRn+FP0R5ZpTo5PDGCTKJY8Ra+e?=
 =?us-ascii?Q?08Saqj7m1A4pBeoadiZC2/rZ9YjIb8sFaWSWC4p21me8/s8qeEpvDyqa/HyC?=
 =?us-ascii?Q?dD3gvsCh56EzyITpNxJZArXO8RElxWw1UAiSByTxfeq3JLSPStuTRZPtLpDn?=
 =?us-ascii?Q?IfLdMKfOms0qhqskdOUhHXERyxmTD4xDQmX3AydnURuOKbB+Sb5Tz7GcayN3?=
 =?us-ascii?Q?jco3n+4N/uZ/lekCKYRQyZzuW3MAHNrKEZjV/+h3HLsl93GkeVu0YB2hW0bh?=
 =?us-ascii?Q?vzB0I0t1bvVs985U60rkJvd9NXwasXFxE+ofUx9Kbt7Y+E92l3LOAlBPa1zF?=
 =?us-ascii?Q?HxoIQXeHww8ap0u077IT912ie9406ap0pVhp6+nsLcCoJDHvw0CVyCr/sbW9?=
 =?us-ascii?Q?ntppuB/hX3G4fZ7otItrWHqS/GhnAIdxTl2XeMZxOfiusFodanYWDL4Y0Lsj?=
 =?us-ascii?Q?tB0hGE/vpkkFKztv0+lCSV3/zN0TpJPrXrnWgg9z8jACdqSvBxN8rHjepYmo?=
 =?us-ascii?Q?xrq3KOkrdcN/UIBZjEvn1ODu7t3iYqaKXmnD78H2el+Z52ggheIXAqqiw7it?=
 =?us-ascii?Q?CsjyWKgXzfaCgRICn/ZD5aGDJGEajVu1t3HXdd9VHw0xaMtnyT2mPGl6sTo9?=
 =?us-ascii?Q?Yk3mxJcsHa/+0P5es4Jv0YZzyqG4VRI1rkuDvRoyaYmY4blB8DvzmrKTh+N3?=
 =?us-ascii?Q?K65P3I/7JqAcO27XKV3FITk3BS6wrWBQvTQzk4rtSGEQtx9Eyhd93OsPxG7z?=
 =?us-ascii?Q?5x53H3j/y7/L1JhPFPoxk0qN68xXMOpPaz3oCKXG+iw5RXny5g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nNSdjuUpAUuS8ZMasUy6JeNEAv3c47xwvt6x+Pe9EA0bvJaVxcf9SjK8Ibtn?=
 =?us-ascii?Q?CsFy5lJPhm52K4nckNh+xZc3wiJ/m6K61ue8AijPmI61/YQKK+Z/3zz+7QKc?=
 =?us-ascii?Q?IOBeOjIJJw1UsVNDfGyaSyqfGqytfd8nBR9FxoPHdzVCMurPSoV+x2SBVBf7?=
 =?us-ascii?Q?LzOSYLwGUVNR+zcJOvlf3alxXUFxK9AvGKVBgEh3bRZVn0GSLLNWMwTJuGId?=
 =?us-ascii?Q?XdGDZmod+DGMAp2T10nekC3aTCHtGxPvKKYxbwozNMK3+LuBTGmcSgmR6kxQ?=
 =?us-ascii?Q?F24uNM9RZtLwNPQHRNcpLT+ad0QZWiiGjnzQQOpAXsvhPYAD3NspRctzAUiI?=
 =?us-ascii?Q?WVMcW35VjmcFkB4zX50fCqJzE8He18rbUBgjwtIZVEHFnSQ+I5bXpE1tDtqB?=
 =?us-ascii?Q?RY3cFA9a16FT3NKvGeQ41yK4XKi4I2TRLIIIH4iqHByuzG7kmzwOUzuSq34e?=
 =?us-ascii?Q?4LYzxjnP9U97dLNKQOc3ihSyTYgKu2XFTc1mwueIKeSMrWIwaZHpBeP630rl?=
 =?us-ascii?Q?ZjHUBc7HK9VHVQzLP+1BV4IGaqqUp334gBUen1YppEDoScE8yN4HcsHtSzum?=
 =?us-ascii?Q?VIuNUORFxIm30HGddo5tUSWGy+hO38I9Pdr/alpwyJKqshRkxZMDXvHpRN0j?=
 =?us-ascii?Q?F+M1hnYaLYAq5nCt2uSMY5ijj9eZmCMnf10IZ9UzOg5VjAeGQ1o54ZI/8Ztd?=
 =?us-ascii?Q?M8Dt1s/+QtnQkdlxxtZGW99NI6BCFB6kyahaf4Zkx5uQ1loSuwWc9G15Y5ho?=
 =?us-ascii?Q?Ny4SX3p8Sz6/m5qMFw4lMvYqG3JYipqg2SGSx8lru62yRVtmuFjPa/iFRhZ6?=
 =?us-ascii?Q?oNes6I5DBgmb6CxvoGaRkjhL7Tox10O04hbrv5kxhNHtwIsYBBag7oZqTet3?=
 =?us-ascii?Q?pihmrEcUCCgu8uplCcf3PkPIt0v5kcg19sm18N08my/6QUTWIuK73TzT0Yhl?=
 =?us-ascii?Q?QVRqsUFgbjLKiH/UDYIRv0iAZPCdaumVGQUMz6RG116BEzD5vpJsQGNREDsg?=
 =?us-ascii?Q?UFsEHapwtbUAUNWcEm/RUNq2cOdnwq0ViqzolEMgVDBnGhMzr7zbUay9zmOl?=
 =?us-ascii?Q?5rVYB9Wt5goCCv3w3e8Q9u97Ke3NkvLPQ424S+lVU7fE/tK+b/7YojbsdLmE?=
 =?us-ascii?Q?7KTD8T0ISNbbU4w3twNicuj2xMSxBQpfkcdtRNWbrBVGCGVw1E/T4R+7IKiG?=
 =?us-ascii?Q?brp2BUxpnLwmxXu5D6LXLSbd3S27yCrRiE6trdimGEI1eml0incQLd6pkSNd?=
 =?us-ascii?Q?qc1Sf387Yfq/9rzy69ycZ1RSWqcKJvQp4gSxOYEmQrCyb7rBRMvbwgU+PB4Q?=
 =?us-ascii?Q?BOWKrXsnvK9zn75dC3zB+UzN4rdQupsAA5QxCPMstKA5Jz8QjRo08n3BK+qG?=
 =?us-ascii?Q?XQYrN8+aJ30jGZ7uHqX4pPMklp2GJh9hfCwFuOFZihk51ENd5Bl40q/feCwa?=
 =?us-ascii?Q?Lb4udLFMlbSI6aiv17xRu57wtSvePIsjRkspJ9W92R7ArtrKF7F2ytQMMkji?=
 =?us-ascii?Q?vIM0soakllVWhH4yhy+fAznHJR8lSskda56nU624fq3hs+yJr9u9SqOkNnFh?=
 =?us-ascii?Q?h49oNZLJN6k5plhzm4c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410e406a-3df0-44ed-55c5-08dcd9b65908
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 20:53:58.0701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUxt6g/wwbCf0WlFl2vxS+XdSRAd4THpSiq2bZpL/UEFbm7BuvLXVUbUyMNbPDpE+sd/KIBAKGrCL7xPtgq+wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747
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

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sreekant=
 Somasekharan
Sent: Friday, September 20, 2024 12:14 PM
To: amd-gfx@lists.freedesktop.org
Cc: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>
Subject: [PATCH] drm/amdkfd: Add SDMA queue quantum support for GFX12

program SDMAx_QUEUEx_SCHEDULE_CNTL for context switch due to
quantum in KFD for GFX12.

Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index d163d92a692f..2b72d5b4949b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -341,6 +341,10 @@ static void update_mqd_sdma(struct mqd_manager *mm, vo=
id *mqd,
        m->sdmax_rlcx_doorbell_offset =3D
                q->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SH=
IFT;

+       m->sdmax_rlcx_sched_cntl =3D (amdgpu_sdma_phase_quantum
+               << SDMA0_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM__SHIFT)
+                & SDMA0_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM_MASK;
+
        m->sdma_engine_id =3D q->sdma_engine_id;
        m->sdma_queue_id =3D q->sdma_queue_id;

--
2.34.1

