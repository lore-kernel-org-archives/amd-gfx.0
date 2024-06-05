Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A372C27C52
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 07:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82DF910E092;
	Wed,  5 Jun 2024 07:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RIPw9imW";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC1E10E092
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 07:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVnqyLO/5AVgoxrRMvpB+uSs4tcnSbeJsqtMTUnL0p35EkGa1sxUcHl/huu8sDVdZB2PGYjf8fDCjSCSrvJp7tbzvnWkQkqUIMe53TOcvErQWnNcabQ3OxLMi5Mdq+Nd9GnOxGofQPOUkvYwvwa3T+7OkkmE0WJ3M4wWp8OZ8GS+e7Y889CiMDhPrfkHqhroXz7/SYPjVGBY1QX5QpfOioD8cOmS9M32uRIPWKCLmPMLmUrT/glH58NHjlEBqgJR99mehHPl6XBhMRQKXpIoyy61RrTjgPY9Jl0YLs+EjoEWmJQ4am/jg7m3inu8WVR7ftOiVDLtKbWJUdmWnuh5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMMgfjgE4YC2/Y8zhvrmux0Pn9oArTtOgX9m4t0JBdg=;
 b=XuA7LU8UrgESejO8RZHTcrzGmVvm4jmuasDm9UVqqK/cCTYJG0Lhg/2pGbTu7ktRIbbzHPJlYiGNt0F8bSss1MIz1QzY2DoqQQih84JzIyupVx/Anovv/C9PtQkBo8T0thVGnVc+z3HVjaOHdMpxcktBNeURKJMzZsgeg1j3o66F/drdPmHaV59Wkq8kbDEMtuf5050LIVz3O+3c27WM7RRj2Bniy9pK4Hxbsggi2oudNLWSImI7Jx5/d03YvBbujrTqv5QcWmrL19hu2aiUN8aAuC7ba5Ybbp7ehbrqF4Ks185EIF6wXtZaE6qxcPcTr2a/RLEkv0iTwwsBYn0uyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMMgfjgE4YC2/Y8zhvrmux0Pn9oArTtOgX9m4t0JBdg=;
 b=RIPw9imWZQHKWxVHvWqKuFrSrmBwiHmEkoM0y8UF/xKmOFBxFo+QMPzWgH/b3hPTnG+VRzEaYSgyW8iHImd4r2DGbu34Ms8MqZ+ioCbCN3zTvKHpUuAXuWFwk4cASLvdohwrAFqum2JtpRaPM05dPaVNycJliLqnmk/bdTg3uRw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 07:47:37 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 07:47:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/5] drm/amdgpu: trigger mode1 reset for RAS RMA status
Thread-Topic: [PATCH 2/5] drm/amdgpu: trigger mode1 reset for RAS RMA status
Thread-Index: AQHas0hACbAHbLL8U0WlYTL7ajPzc7G40p6w
Date: Wed, 5 Jun 2024 07:47:36 +0000
Message-ID: <BN9PR12MB52579A81D04E368D955CBA3EFCF92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240531104911.14748-1-tao.zhou1@amd.com>
 <20240531104911.14748-2-tao.zhou1@amd.com>
In-Reply-To: <20240531104911.14748-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c93c3493-0f56-4f86-81d8-489bee6ff45c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-05T07:47:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ2PR12MB8135:EE_
x-ms-office365-filtering-correlation-id: 69b35434-125c-4663-65c4-08dc8533c4ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZffbCXVqhets//o/GluHFFGW12z+6jjLVwg7hDmJV4Ne9zQ6tEpo1Nc4xwH8?=
 =?us-ascii?Q?s5El4y0E/EBoqxeCp/8kYbiCTuUMr3Zsn+/6lqm/aTTs6tgINF0uUr1hnkAK?=
 =?us-ascii?Q?a7ol+tdrL2j4Rr+DyrV0vk4YMTtzzWxO2xCvyqaClCu6PLGhz2+IHLdaScqn?=
 =?us-ascii?Q?6aX9cIhJkhD8hVb3rLIsoBUS7OCnaal7o0LehXSjyNfG0pxPgGVyqiOT6QrK?=
 =?us-ascii?Q?hnj3SZVxmLos1n8qfiBG6MWLxSycmyEizuDlNuD35FvrHpS40tkiGfJmUR4Q?=
 =?us-ascii?Q?mOFzrPzB6VwQf3ULsmVHiSFE3sh0WXTx5mWxkRB+s88RqqHrXHMAz8cwfrqt?=
 =?us-ascii?Q?sOfbUesGUGa0KRKmdUAMHQO/4p/HMDTAxJ4QLE7kESss9ftXySWfNk1neIjv?=
 =?us-ascii?Q?gy+B+ViXqD2h9IiB/9E7q7rBmS9TpmHjoCkoOzuKCye5tYeddIkWjB/rOcFl?=
 =?us-ascii?Q?4D/b0Rbgcm9OtfpH3M0FndFP69Wlv0du7OBp2QkMVos1A2+1FKnPUVN+CYO7?=
 =?us-ascii?Q?1IN3je39jYLqm9rDLW/NNPbHheFYheNFdaOudwIx8dSJwQFQQsw2yCGtSYRT?=
 =?us-ascii?Q?NgWpVVm5enKRNssocbXc9AoggSM5ZgrUh6JlKpE98PU9Jf5v76lW4Fxa5bQh?=
 =?us-ascii?Q?4zjYGgBBnlSfqZpAMzYd3r0FwlEhwoZnHyQfNH8DHlVainbjoBEXb2qET19/?=
 =?us-ascii?Q?OQGNEbKxKL13q4sFO+pRYVml7gt6J6qIlhhqtYmfQdHBuhmACyCwCOCv8a5l?=
 =?us-ascii?Q?FkcZys7UoUrdO6c0oPRDjT/WWk+w/jYubssyri5Kmmg4+vKRhxVzsZlLcMxL?=
 =?us-ascii?Q?HEIq0llv1r4LuFM+mqYC6RlBKCKmN6VtQRDv72VTdhReWdD+56DQDlpo+6T/?=
 =?us-ascii?Q?R/Mtq97MvlI+YV2Wqbt3YgMf5kn8S7a3rJ55cFTIDO6WyLnPifmtsMDH4SzT?=
 =?us-ascii?Q?NUI/x707UqGVoOhCJnH/B+SiI+5UpOFS1bgwQ6bHYDtc1um+Q9Elp5y46M0z?=
 =?us-ascii?Q?5FnrGfPPAbUWlxldm6pHzSlT5E7EuJQ3gq7YKOFJPmpWlUwk6YoxtyHTWsev?=
 =?us-ascii?Q?QT3ycaeSeWHMa5DKniO9V1X6orajqqpUn9X8Et//k4PACQlbOu43iFuZeImM?=
 =?us-ascii?Q?mHphcUJ9PQzxyX2m8IQkx5WuSHAiN7PXAlcgeOMaj7WZArwpFwkL0yRssTVS?=
 =?us-ascii?Q?Ev+MSiKNsSXZ0zCPkZ8u+u7fRmlIbASAdz717+ATE4Ukf9IAwe1VvmdhFQhD?=
 =?us-ascii?Q?H2veWh1G7COyKGLfcC7a/vdODOoe1dfjX7FzzywyvEpZYTTb6dqVEn2xmWp4?=
 =?us-ascii?Q?aSfVNp/GQZEPE9rjaoTDpaES6gVUGusMsvhbbh1r+35vpA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fbUoM95ykWPA/lxrtWl+4+jhjyhcJVUS1YN2EjTBSRW3ns0J9SBTfIV9ucJ+?=
 =?us-ascii?Q?3w13kTgegwDCaTrO0pU4e+PWcv5dTNtFu8xqyaJ+4NuEpuC1UZ5hYNZQzav9?=
 =?us-ascii?Q?eD5bmYvdRWHwyGcw9MjqBS6GRs3mzooUixkzDsPLT8aqPlXCmAMGaQjRue/V?=
 =?us-ascii?Q?iVzpqH5HxNF4qgeVRF1SUesevau7NROtWVI/+3RQtmBeONTipW51LpAOWgVD?=
 =?us-ascii?Q?13kL1xYSFQ4umnfF2OEWNhnPSd7qhhMD0wL+gF5jKObXh0li9V92S0EV+g1A?=
 =?us-ascii?Q?baYmZt+r3XHgVje2YG//0MfdIseT4R1/44rWTqZeJMS14yjuTlXfQUKX3WHA?=
 =?us-ascii?Q?jixJfW/xKz7EH9H24eRrbXAvVFdDXEJDByaHbaJdORewPWeHd/RvN3woU8WA?=
 =?us-ascii?Q?yvRZiM3NOUrt5+aY6diLUyIcDty1jJ9VhL78jjLvdoy2lgO2trB2exiibQrb?=
 =?us-ascii?Q?WaHkbR4g5tj8j9FZ25MJYQysCVh2Ldkw3lfgHvNeI9N+9l2MPQROujlK8AAl?=
 =?us-ascii?Q?guPbX9vH85u6zR+uHucmZQwlzUuoTBDJ1m38YCPIDMsNNAmLexAkNCZGSclp?=
 =?us-ascii?Q?HiTbBw/nySl1VvxwOgvlQUe+p+9Hj5pEpPE9MUVKGGPHmLrkKcwGOucS8V+g?=
 =?us-ascii?Q?79MsrT9ToexqM2BcKY0oCHISrJy9OlNxjtIEIm0//ZzVSDPoIsVZz1CtW8dF?=
 =?us-ascii?Q?deKbViCGvYECXnIKGWq/HDStqLB8XtOkruseVZLsh2QTAqavtr2m3sY4KVW3?=
 =?us-ascii?Q?7pQhX6qtbci4qjBe+9jC0iEBhRsA3uh4VbwVlRnSZB8QdzSJJmAxwn/fg1DV?=
 =?us-ascii?Q?BAF58pv8YjpDrwfcyhs7dRI5VlbF0jBv+yHKBQw++mURKyZamDWLF4fqvSG+?=
 =?us-ascii?Q?h+oTf2dfNDE7B4JRnvOfIRjilI7CttESeDfyZvzrx6ko6hImR7C1IFXZMDSB?=
 =?us-ascii?Q?m/lkJ65NyOvEU+S88HNhMZEUXdVwse80Qnkkn6ziZHqf8fu8/PnB0hl4l64s?=
 =?us-ascii?Q?Y0yJZzRLHnMTe0UHlHAGiyXf8OmUOtQEuQRdJ95D2GHtnK4FrOhBOnzEKiOu?=
 =?us-ascii?Q?tioTOvQVL4DYLfhWQw0q31w9z6SmMNUjGgje1VnBKmXFVsaz+oKIRwug9tKm?=
 =?us-ascii?Q?2yuI5Tf6tI3V0f5IhM5eXYkv5vNKIVJjFFr4o+uuJBcL/4pI+m3iN8zF9H8f?=
 =?us-ascii?Q?u1y0q83dvnBlkOaGzUy+BQUD/5M2ULQQ5t09B2/XWRfQXA2F/BQulYoP/VWL?=
 =?us-ascii?Q?9OLtsdMmES7NxW97tt2zjhiwCR/TTAYr8/sHv5k6OgMDehvQn2zNAmI3TFwd?=
 =?us-ascii?Q?bLLpyIJE9lWFhvJiTnhkJYE7yt8SNVlc1eUoEd+9rNp8pQKDqnhXF0jQFSjY?=
 =?us-ascii?Q?WBh76a0hRQARk61JlPqbIM7h2A/GVg6ujsF8SMYPX9NC/YKsw+Hnu2HrC/Tl?=
 =?us-ascii?Q?OQD6DF2HxZ8rebaMzqCMParQo9q7KndzwxAVBPtHmdbtipyCJFQfGyNZY5aB?=
 =?us-ascii?Q?g+FGVQTmakN0ND4XN9+PfSu5IzOcENFrlbkdVln4fqtYVTZHKM9cc/6TKpnG?=
 =?us-ascii?Q?pH/ZImSuXayPUg9qGt6HuPiJiGXNky5jx6BZ9cIi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b35434-125c-4663-65c4-08dc8533c4ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 07:47:36.9072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+JZkkcOAbZYSECH7jSMimi8iysIvW7oirQQSNYU29ZGN4bSGZzmDg63kDeeJmjbJngghpayDfpBthLOaUSHRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Friday, May 31, 2024 18:49
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: trigger mode1 reset for RAS RMA status

Check RMA status in bad page retirement flow.

v2: fix coding bugs in v1.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 28 +++++++++++++++++++-----  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_umc.c  |  8 +++----  drivers/gpu/drm/amd/am=
dgpu/gfx_v11_0_3.c |  4 +++-
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 616dc2387f34..10cbcc0d1a1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2049,8 +2049,9 @@ static void amdgpu_ras_interrupt_poison_consumption_h=
andler(struct ras_manager *
        struct amdgpu_device *adev =3D obj->adev;
        struct amdgpu_ras_block_object *block_obj =3D
                amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);

-       if (!block_obj)
+       if (!block_obj || !con)
                return;

        /* both query_poison_status and handle_poison_consumption are optio=
nal, @@ -2073,14 +2074,17 @@ static void amdgpu_ras_interrupt_poison_consum=
ption_handler(struct ras_manager *
        if (block_obj->hw_ops && block_obj->hw_ops->handle_poison_consumpti=
on)
                poison_stat =3D block_obj->hw_ops->handle_poison_consumptio=
n(adev);

-       /* gpu reset is fallback for failed and default cases */
-       if (poison_stat) {
+       /* gpu reset is fallback for failed and default cases.
+        * For RMA case, amdgpu_umc_poison_handler will handle gpu reset.
+        */
+       if (poison_stat && !con->is_rma) {
                dev_info(adev->dev, "GPU reset for %s RAS poison consumptio=
n is issued!\n",
                                block_obj->ras_comm.name);
                amdgpu_ras_reset_gpu(adev);
-       } else {
-               amdgpu_gfx_poison_consumption_handler(adev, entry);
        }
+
+       if (!poison_stat)
+               amdgpu_gfx_poison_consumption_handler(adev, entry);
 }

 static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manage=
r *obj, @@ -2801,6 +2805,7 @@ static void amdgpu_ras_do_page_retirement(str=
uct work_struct *work)
                                              page_retirement_dwork.work);
        struct amdgpu_device *adev =3D con->adev;
        struct ras_err_data err_data;
+       unsigned long err_cnt;

        if (amdgpu_in_reset(adev) || atomic_read(&con->in_recovery))
                return;
@@ -2808,9 +2813,13 @@ static void amdgpu_ras_do_page_retirement(struct wor=
k_struct *work)
        amdgpu_ras_error_data_init(&err_data);

        amdgpu_umc_handle_bad_pages(adev, &err_data);
+       err_cnt =3D err_data.err_addr_cnt;

        amdgpu_ras_error_data_fini(&err_data);

+       if (err_cnt && con->is_rma)
+               amdgpu_ras_reset_gpu(adev);
+
        mutex_lock(&con->umc_ecc_log.lock);
        if (radix_tree_tagged(&con->umc_ecc_log.de_page_tree,
                                UMC_ECC_NEW_DETECTED_TAG))
@@ -2867,7 +2876,8 @@ static int amdgpu_ras_poison_consumption_handler(stru=
ct amdgpu_device *adev,
        if (poison_msg->pasid_fn)
                poison_msg->pasid_fn(adev, pasid, poison_msg->data);

-       if (reset) {
+       /* for RMA, amdgpu_ras_poison_creation_handler will trigger gpu res=
et */
+       if (reset && !con->is_rma) {
                flush_delayed_work(&con->page_retirement_dwork);

                con->gpu_reset_flags |=3D reset;
@@ -3983,6 +3993,12 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)=
  {
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

+       /* mode1 is the only selection for RMA status */
+       if (ras->is_rma) {
+               ras->gpu_reset_flags =3D 0;
+               ras->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+       }
+
        if (atomic_cmpxchg(&ras->in_recovery, 0, 1) =3D=3D 0)
                amdgpu_reset_domain_schedule(ras->adev->reset_domain, &ras-=
>recovery_work);
        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 1dbe69eabb9a..4a72ff8d8d80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -195,7 +195,8 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_=
device *adev,
        kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
        amdgpu_umc_handle_bad_pages(adev, ras_error_status);

-       if (err_data->ue_count && reset) {
+       if ((err_data->ue_count || err_data->de_count) &&
+           (reset || (con && con->is_rma))) {
                con->gpu_reset_flags |=3D reset;
                amdgpu_ras_reset_gpu(adev);
        }
@@ -211,6 +212,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_d=
evice *adev,
                .block =3D AMDGPU_RAS_BLOCK__UMC,
        };
        struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &head);
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        uint32_t timeout =3D timeout_ms;

        memset(&err_data, 0, sizeof(err_data)); @@ -243,9 +245,7 @@ int amd=
gpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,

        kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);

-       if (reset) {
-               struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
-
+       if (reset || (err_data.err_addr_cnt && con && con->is_rma)) {
                con->gpu_reset_flags |=3D reset;
                amdgpu_ras_reset_gpu(adev);
        }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0_3.c
index 9e7ce1e6bc06..9cd221ed240c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -85,6 +85,7 @@ static int gfx_v11_0_3_poison_consumption_handler(struct =
amdgpu_device *adev,
        if (entry && (entry->client_id =3D=3D SOC21_IH_CLIENTID_GFX) &&
            (entry->src_id =3D=3D GFX_11_0_0__SRCID__RLC_GC_FED_INTERRUPT) =
&&
             !entry->vmid && !entry->pasid) {
+               struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
                uint32_t rlc_status0 =3D 0;

                rlc_status0 =3D RREG32_SOC15(GC, 0, regRLC_RLCS_FED_STATUS_=
0); @@ -96,7 +97,8 @@ static int gfx_v11_0_3_poison_consumption_handler(str=
uct amdgpu_device *adev,
                        ras->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE=
2_RESET;
                }

-               amdgpu_ras_reset_gpu(adev);
+               if (con && !con->is_rma)
+                       amdgpu_ras_reset_gpu(adev);
        }

        return 0;
--
2.34.1

