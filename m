Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1A5FF60DB
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 07:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D27910E8B8;
	Tue, 31 Mar 2026 07:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mSI9cVyB";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DD9410E8B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 07:32:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLSfJehLPt8FaatjfhU2pwp195I7fn5cWwo8s/qS0/84ZCoJ3ozQ4JA9gYFYTrT+wlHhRcZ8q36aHIFGQm9wXmTemtct+IPZDDWUHWN9hF4CWMI0CvY7uhgUdR1mw1j7ds6I5s8unJaGqu54AyzzDRln4PwgbyfKGtpuiBy4ZSG5NgDGazgKj6jaxe06ZicgKX+HS0AZClXX16MVs6Xu9/pTK3iojPOWKDqvLm0iZEoHPwhK9OTwbuDBOwLtpaUNlpJoZeVzMqgzYHYcKQJNIDjfO5n29oJo09ualGXalP2h2Anq5irET/k5pPGAkf0HjpRwvaO9rerrOtJ01M5ihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gRh+SXvUoL9KU1eda3xIBli2Do5BI4MplzyV1w5dQ0=;
 b=SIFD2iytoT4umyoiDP7fK/p3xr88kwUEN4KkdfSE5DvTwe2L39jmiyoMhu3G1w5rcIHuv7ix2+vWu03FOyIYeZmBJx69olJMShbaLLDzJ+2Ds+xeLA0C6jvd/OK6HmCpWCCe5pLrpvFVxt1t4Iu1nD3WTjXErjHWsAcp+SUZuuv1dSxGUOXBVW5xF+e4ZGxjurd84krFk3F7S9S3b1+TPhxi5ts7XYrOlLQL5tnEDV/sHmfYN513ow4yqcnll5A4qDXqCJ5g/VBLkkzC+ajxDvaI3knfjXfH1ibjCXGwnOW1tAlRp8q437UloMV7XaabDoqikcX3EyIGzMlB/cVsew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gRh+SXvUoL9KU1eda3xIBli2Do5BI4MplzyV1w5dQ0=;
 b=mSI9cVyB4zr6RB10k8qQtJhRPgPIcCeRh9j3NLta3UfR6+lMfiGDZoLNNO4JwyV2haSlDbQBXWY3BWREHdlYAHanQQhOmkzSRbwuX6500G1BGfYGlMmI/24vZqA0IeaynVwx32OkB+1Y/kmfNRR+k8cnH70xq96WhkKZBJbt8l4=
Received: from PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 07:32:07 +0000
Received: from PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::17d6:3ce4:21e6:8c8d]) by PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::17d6:3ce4:21e6:8c8d%7]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 07:32:06 +0000
From: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deng, Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH] drm/amdkfd: check if vm ready in svm map and unmap to gpu
Thread-Topic: [PATCH] drm/amdkfd: check if vm ready in svm map and unmap to gpu
Thread-Index: AQHcvQyJBMZqBIzLOkOVScnH2Sj5TrXIRinQ
Date: Tue, 31 Mar 2026 07:32:06 +0000
Message-ID: <PH0PR12MB5420C36AD1917E3F2924A9DBE053A@PH0PR12MB5420.namprd12.prod.outlook.com>
References: <20260326103656.487304-1-YuanShang.Mao@amd.com>
In-Reply-To: <20260326103656.487304-1-YuanShang.Mao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-31T07:29:37.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5420:EE_|IA1PR12MB6651:EE_
x-ms-office365-filtering-correlation-id: 09559bdf-037a-440b-db3c-08de8ef79c67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: eJeia4cprhy15lYMudF4h9ka2wr+DeGvP+VPFo+gzFPM+OuC331iGNZyQh15viKFVzsv9cPtzHgFF1NJU/PL3ITvunb2gEv5PpzAW5zG47Dy/oQQTHnnjn2OaRp4fAE/vQ9GYN4FCWKdzDOWsWrQBzCZrX17ciabFqQjhW+K9UyGIixSsQpGGtBFZbNisZtKLMeFtHswOAk2PTlkxyXBzYfi7MNeacPTvr5yeFMNp0+NKsHr8z0XB5nfZH6wbuNl3qHgd8BIGpmrkYE2dw/ZvKH1Tfdxi9LQmKx6Tuvx+mFBe0LsmErUGUmjD4ygy5mECg5Rrln4xi7I61/0MD+lvXOPKuFNgKu1DuhjWLnmla/Zw81NVa7QUWU1/hutLsh08wQFZhFds+5ZJNLqNg663MG2K0MGMF/Vv666Pc2swrIagBH4pD2CmeZzqO9U5KdFsCH/54Q4L1C9wz0hdAzstxUepScLj0gEk3RHQO55z9S35k6bOdRJeRx51IF6zh+Vd5T/OgyEh+EY+n2JW8xURPT0lPL7H+bKEDoOobbKWMPf71zpFDd6BaSd7vUhCPwDgF8H7UCjEepKH+5eF7p3Kg4S0PFwit2fHm98a6qUtk1DXOhwSRPrPeGyfFYcc3kvUwuY+UP48DqAXU6PfkgGgEqYcPi0idE3uAQxgh9gqBUMoBRSy2WUE616b/R4C8fN/siYhOzQNrCI9AE7NRyV2kPb/j8glGO0HhpEQQUzhIhATd1bO+j4TxoLvmdbJ2319wfBFQnHFvxXCj/jIrigjPVOXo6ahk8KqFfD5KrmJsA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4UcpmuMR8MD82xfz+bIO7dBC6gA+b2Sz8wL4aa2vZfxw/Gp8kqTpJH3rktSh?=
 =?us-ascii?Q?GXyTjYMZJbn/8f8EuPGO8uGA+diwm291GnWzJnR4Y6+EkmyFXN6XscfTD5zX?=
 =?us-ascii?Q?0r0XRT9N2MRnb7xS3qQ5AkC2RH3IGuWDW8YdNFk37Oq2nICYiYluT6lZkrHG?=
 =?us-ascii?Q?zUAv+uW/k6AJwZY0GgsGDGk5PKPot+vVIJmG2SdT23q+pFlNyJC7gUyIDH/Z?=
 =?us-ascii?Q?ixLKp4jZsBtS4wR3nol/9GUuhHZNIbPEdWYJeJAwGd+K5P3DusCgfOWs7MHp?=
 =?us-ascii?Q?5IPhQXJTvZ34ohX8TbdFV3RG2pBtNUUzUfcWTBgW/ulrNXbEORXlZQD1/kBK?=
 =?us-ascii?Q?UmX1Ka9/Jsf+3DFMKZh9DVP+kQV3L/sPqZ1JyqvAdQb3jaH2uRZNOcmSdsW2?=
 =?us-ascii?Q?GtTEHYTy4MkU8YYUEgXA9TzIBSwkL50MLcTcrPUvbla9pkTVNezaiApJWzfG?=
 =?us-ascii?Q?5zgzQBowSCZPvZLHF4C6H19HnVQdW98lleZYe0ovdD3E7KyPYPanf+/oz0Ia?=
 =?us-ascii?Q?o3IWBQApE4/cfMZ6LFNcSNJcKeCEUlz8RfPsG0p4lXd5OT9U1rJYvdobqoL+?=
 =?us-ascii?Q?sh2ZJihKtj3mvb31s/2hyQ0/O7JNEXwAQPqtyqC4cfcWvO/pqXh3oFXZ6hzn?=
 =?us-ascii?Q?lPY2TYqLSYQ0XQ1u5ICnJUzGIf95SrDOjkcqr3wdrW0J/DM3k7HcYDwyg+kJ?=
 =?us-ascii?Q?UHNPvDbCf7hT/jQkiC0H5oy4aLFIuQ8nJaZEGuyo5TU6DI40Y/OtsxBJFnxs?=
 =?us-ascii?Q?3i8pc2r7kNuOcavXgwyn0gB8fuAA5he9aojYn2g4gdDLnfYUdNPdQqYOAUk+?=
 =?us-ascii?Q?pWIUKrDDvtqiMkHgQ4cjeURh6rXzLaV8Btf1LL3+sBaa2EfShNfDqRR722vg?=
 =?us-ascii?Q?SxrEaDXFpqp9DfO0Oojsx+/XqPEOs4uHIDc6U+Rt4DrwYRf75Ph8VegJF3YN?=
 =?us-ascii?Q?KZXvC26ABBfZp96Z2BqNwzouiHS7iG35pNYtsfQliiBwLaEOgF+Kl8U6KRid?=
 =?us-ascii?Q?mfwRWscv5tQJKEbC1xC1xj4BT8/Bj48X0Vf0fbuEgeLbKIaIktF9xTiOioBb?=
 =?us-ascii?Q?KnDSlJ4DUjc/X8OF2jn/R2mAvboNs+KZtrWrbWmekXHZM70fJxMEgFC5Bibv?=
 =?us-ascii?Q?90ByBVnZuggu00SquwgSulHTki7BAdLa7iRrpPp9gPx0sH/C/Xf0FXsUhXna?=
 =?us-ascii?Q?6eQ1yfV6RFmAthfDdR/2gJg+BsbTMi5vf7ok3sN/DrXAZWin4bSNCRaPjqIV?=
 =?us-ascii?Q?9qJ3xKYDv0+E1cqntVFIeSXB7VoLc/UFeDjmvu2zTkLvYjEbPmMad8dPhPG4?=
 =?us-ascii?Q?homRTXDOmwNxKLAKk/1mzMFrmyBIJ+ApFt2UXAkvn2ttF4Hjp+BtY0sPvQAL?=
 =?us-ascii?Q?kFfgdLJMMLt9oEr7jVsR/AhgeTMyINs+RdREAZ4T8gKSFli8shpGMQhB+ikJ?=
 =?us-ascii?Q?WW9JR69eugmDQvP+MSQEqXGqeV90VJUjZlc2Cri308jID5RrUj59emDzOvM/?=
 =?us-ascii?Q?IhbJbpoaACIV5FZV7IT0H6l79shuyXN3BtmLvIvUxFfo5eA0/7S4eUA/uJXw?=
 =?us-ascii?Q?nnXKQNze2iezenhAc5fdg6ECmYXhO6gEhNGYrFJAcBe6QrEGuEP56WnLqgSS?=
 =?us-ascii?Q?Evj8229M+9tq0uW4nDbdzP4Y8yOlUKPyJNI6BUeSjXjwIyJmho+tQIP91G5r?=
 =?us-ascii?Q?OMIGbNAGAlrTJpLuqzrMGxCB7eaK7k+QbxDb/IHMWgitWMmT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09559bdf-037a-440b-db3c-08de8ef79c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 07:32:06.4817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8PqBBjGr+5+m+FaV58t3EUEgG2J0DlKNJssFu5/jUAcwNgEC1mQ6ULCpvdgjblACczZ+m8l+1l2XfNT5tRMrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651
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

@Koenig, Christian Could you help review this patch?

-----Original Message-----
From: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Sent: Thursday, March 26, 2026 6:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Subject: [PATCH] drm/amdkfd: check if vm ready in svm map and unmap to gpu

Don't map or unmap svm range to gpu if vm is not ready for updates.

Why: DRM entity may already be killed when the svm worker try to update gpu=
 vm.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 8167fe642341..7f905a7805fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1366,6 +1366,12 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev,=
 struct amdgpu_vm *vm,

        pr_debug("CPU[0x%llx 0x%llx] -> GPU[0x%llx 0x%llx]\n", start, last,
                gpu_start, gpu_end);
+
+       if (!amdgpu_vm_ready(vm)) {
+               pr_debug("VM not ready, canceling unmap\n");
+               return -EINVAL;
+       }
+
        return amdgpu_vm_update_range(adev, vm, false, true, true, false, N=
ULL, gpu_start,
                                      gpu_end, init_pte_value, 0, 0, NULL, =
NULL,
                                      fence);
@@ -1443,6 +1449,11 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd,=
 struct svm_range *prange,
        pr_debug("svms 0x%p [0x%lx 0x%lx] readonly %d\n", prange->svms,
                 last_start, last_start + npages - 1, readonly);

+       if (!amdgpu_vm_ready(vm)) {
+               pr_debug("VM not ready, canceling map\n");
+               return -EINVAL;
+       }
+
        for (i =3D offset; i < offset + npages; i++) {
                uint64_t gpu_start;
                uint64_t gpu_end;
--
2.25.1

