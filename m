Return-Path: <SRS0=HC41=MT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB1FC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 10:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 859586187F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 10:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 859586187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9C556E11E;
	Tue, 27 Jul 2021 10:37:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB5816E11E
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jul 2021 10:37:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOj9GGIkpgmsU6h/JFnUV1emfoTNyUS83vl1IUW75G6lRDDvF/S5VBxqWXPSv3VqZl24cCeLQ0kOtXDkUOsTJ8V3on6G9CvfZOBCI8LbblCPtaa1EEc525yeHNiFmvsLab5BV/jhYpMUawOIK77zSA54MDoancTG2ZUWb45ufL+Top3PKGNqh4oKB9eIeTKmyNeJCJYUi2g/2zEA7aFS2lJwJYHK2ptvG3ya9ngdyk4O263/c4owGyzM5+u6xEc1IWpWwsQ0ztf4Wo/wZOKxpMSMoYp9uuZGx0X5c/oubDkHzvlI1PsojUq6ddM0PPIf9BZhrAw1tA1xIk1fgWXo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Egg5TkjOVAnq9lP18queoRTjQlSZgOq1W4OZvGE7D4Q=;
 b=ZulyTyvffJwhHzWAXrdOFghUMkDGKnMAui6R2hogD4o0MF5q/b5GGF4yb9Uexr/M06jzxSPE9/IYSpRJfJfn65gOcTrMj1F6wErRRPN0VHmivs+o/pGa3y3zBBh6/X0xK0UY1u/UhWNh28kRtYDLJICXsW3N9GjPJSpobpyANJDh8J1DNorTjhPT3mHp9w20h4PKYMAIx9NVRRq4OoH7ARD0iZT4/HEn778YwSSsRa7jELj5Ob9DCHtiMcM556cmmAikzXgAuOKsMbASZwbkCYv2jQ+Yv9+aCbQq9QQUI0dFRkUaqGiWP20wSV6qax7yjKpyLAXanThMul3BSHPz4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Egg5TkjOVAnq9lP18queoRTjQlSZgOq1W4OZvGE7D4Q=;
 b=pjpO2aRvUFOlVw8y+zoJTLrbqy7w4HdGt0XYqFrdY7E8pjlg+egewisk97Qbdwyxg3xYr6JflE+G+WmmLIaq2qq63l1BVLfwuF7z3w0uoV1cLvFfAIVMlVD486HZ9+yymLmf//RIRvK6PhLfWcFR9b/6Ts7wfKnLTmJu2bIPUA8=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.28; Tue, 27 Jul 2021 10:37:03 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::3512:a4ee:5aad:655f]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::3512:a4ee:5aad:655f%9]) with mapi id 15.20.4373.018; Tue, 27 Jul 2021
 10:37:03 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix out-of-bounds read when update mapping
Thread-Topic: [PATCH] drm/amdgpu: Fix out-of-bounds read when update mapping
Thread-Index: AdeC0zsL3+9nyTeJTRqqb05YgrXbZg==
Date: Tue, 27 Jul 2021 10:37:03 +0000
Message-ID: <DM4PR12MB5165A564AE14CAFBDE8C948B87E99@DM4PR12MB5165.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2372913d-13b3-460d-91be-9cb03d164674;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-27T10:35:30Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e393fd6f-c198-412d-7b10-08d950ea7965
x-ms-traffictypediagnostic: DM4PR12MB5149:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5149DE1EC4A8453683B2D54787E99@DM4PR12MB5149.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Izn5oyS+lxNg3I8OLTrWXzVfGaEtElWXZf4nYf8igGNJtqsIGeVIg4TilQiX8f+FMBbgSmy6S9RhYZReFMdkr6sg/W5iLJ8ZLpCN88ehrpT5gIqRkxH+8riWksFi9OzzMoctcFLf2sD/DGFL/bCYXV2FleJ6Tr03TzB3ymaIJVoR1QbTLcEOqvfs2Rned/aGpelEUmOLkp6Bl0to0um5Uf+dSPRL4+wu0g0m3jClGbvwsKaNhkUws8HzLPmsXEHZ/GN+T02LqcFZ/qdM7VHQe9wfQL6T4brg+I635S4FOgYXOU6Bm7R9XP4lJMQHgOjJXX2Bh2D4SlkH+RY6w+FuxiNZjJCQ5ukjThutVNAo+Sx3+wYC4v6d/86EjUjYCqTKg6mbJNk79PyU+VRUlzb950rhmm/rYa0k5i9xlnpOzI2ndiz1fRm1s/2Om0RYHMaYVrQBe+i8o9CQCPT0pWzmb8T+P6UjDI+A7/a+pWShY6eGzEJ5xoch6nlYFZOTHy7hdv1krI4IOw23bf+y4pJfPqCW9UVZAeU+dHNgetxYH3ENYBdbrze1FytUkdZPT6SALLme0Vedcpb7L3O1dc8QPGVqWZ2G7+NTLQ6jE17LcGNIot4xDlet/PnCw86HVp72EY/wvT20ZNt4iB++jjbHZvnOYhrb2GfrWzZoOacPprcsrnvJSpoPHCHR7Daek/DkTx1ezn7SV6e8Vu8xMMqr7A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(6506007)(66446008)(66476007)(9686003)(5660300002)(8676002)(86362001)(66946007)(26005)(186003)(8936002)(76116006)(316002)(15650500001)(55016002)(33656002)(4326008)(83380400001)(7696005)(52536014)(71200400001)(38100700002)(54906003)(2906002)(6916009)(66556008)(478600001)(122000001)(64756008)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T+eBo+p0tUKUTiHB2BU+XrCC3OIknnGr+Nv8mNsJ3cxVWhNoMDU66ImjUv4t?=
 =?us-ascii?Q?EizFNoLtVW1Z75iQdhg2OtSK6XswrSZdli/Se1CRNRhd5ztnEtI5W3WVSGEc?=
 =?us-ascii?Q?bEoh+Lmf/gsYfOx7XdRkKcAmXU5Bnnd+BRFQlL0vXjibp7LcW3I3nMBk1P/w?=
 =?us-ascii?Q?eQt0ZWJoqmS4lVVFcGhXdvYPaDmbxYmeAlj3IxLDfRdSJBF89OcaG0Z5voG6?=
 =?us-ascii?Q?Vaxd8M5I9gilaVZMbAhPFYqvoUDbkDIyHK/Q8Dbv+dBgR1QaU4k4j9/91Yew?=
 =?us-ascii?Q?AS3lHKdWzK5DEGULQoca8rl0NDtGzuHDRoLjV5LxG+Q+Nls0oig6pqmid0oR?=
 =?us-ascii?Q?6coJ8kpl6Y/TrYH73U0aw08OkjaxCaV/zwsDATBa8pJY9WaQrS/6wfmTuBQZ?=
 =?us-ascii?Q?6Xb+ZC+mKAebbTtKn7MkvMzGLLwT54SmPQmHBZELqgwOcYZCuNGtbgtJHLtO?=
 =?us-ascii?Q?5EtYnUQezxOCmHsQn7CpULLErH1n5byzaa7VXY2+WxlPtGmywJ8alqBNZ8yM?=
 =?us-ascii?Q?pGStApiCWy2GzXoftrQR0etB5DKr4oS3Zqa0R62zi9cly0JTpzmRF6GMvwcc?=
 =?us-ascii?Q?gPCegoxejfkFWoj+e1ToqENnyBh9dc7BU8mZOA4xb+/UjNZlM9dUVmMjiISS?=
 =?us-ascii?Q?HX6eejTIxkxanxMElT2DYID75cQ+vwPdQhk63r1cxcHHcmOq8Zu8PZilZkiC?=
 =?us-ascii?Q?/c3gVe1L/YVte8gvX0N8TN+XnlvkMi3W7sAqucGev6Jn+d71bEMM+Wcpp1D5?=
 =?us-ascii?Q?uzgsTxS3LJoai6WqgKVM5fJCeyZ8s+9SUIBR+PKm9TFEfqQhpN/FbDfQzLdg?=
 =?us-ascii?Q?OUY5nym7KKXRvkP+itTKVFsrRg5+sy6K6X1zdIMUVRmw+t0lLTOQ8GsfSafg?=
 =?us-ascii?Q?2NG6aHWw9EGD1Dj7au/tpMIaNq8Yw5CqnuCxfyqp6bGx7n7WUlchmfv97cRf?=
 =?us-ascii?Q?bDWVxg8zLgbG1rOLISKoHTMyW+hXlIl+vQgfG03pMZ+g+pcvxlBvo/ZEYv5O?=
 =?us-ascii?Q?So4qg0fluLoaFdNYgYbN1ld4md1dzc0n1kTKMzL+mVi6I8NzEJMxMfyv5/fM?=
 =?us-ascii?Q?RMuVclhtf3L3SKm1eJ/nWFDZkJWiNkNX9aGR4kKqzY3TFGdst96nZdlZP6OA?=
 =?us-ascii?Q?UM7QzEO01QWVYp09+A7k5QLE6QZNv+rGPWvWwNsY7DEjyrP9+YYI9QpMC1cm?=
 =?us-ascii?Q?UIS+jVLjlrHz/SGMez293WXk12R3eyXiIiGAwNiNQf6ELGETPUO9dTXRsVT4?=
 =?us-ascii?Q?A/hJEVaD0E69Cgk6whwSnUVJPTwQqlQwo7jtL4XuOrHwTemVYTWd3877JzqH?=
 =?us-ascii?Q?BGoaRwtXc7JFuumNdc7L3yAu?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e393fd6f-c198-412d-7b10-08d950ea7965
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 10:37:03.7634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5K0m9Mdo7jvbQNI2gvHSN4/aNj/sAMclkCbPRSmK1icEVbK/E2Bw+M61YHLEGqUu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5149
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

If one GTT BO has been evicted/swapped out, it should sit in CPU domain.
TTM only alloc struct ttm_resource instead of struct ttm_range_mgr_node
for sysMem.

Now when we update mapping for such invalidated BOs, we might walk out
of bounds of struct ttm_resource.

Three possible fix:
1) Let sysMem manager alloc struct ttm_range_mgr_node, like
ttm_range_manager does.
2) Pass pages_addr to update_mapping function too, but need memset
pages_addr[] to zero when unpopulate.
3) Init amdgpu_res_cursor directly.


bug is detected by kfence.
==================================================================
BUG: KFENCE: out-of-bounds read in amdgpu_vm_bo_update_mapping+0x564/0x6e0

Out-of-bounds read at 0x000000008ea93fe9 (64B right of kfence-#167):
 amdgpu_vm_bo_update_mapping+0x564/0x6e0 [amdgpu]
 amdgpu_vm_bo_update+0x282/0xa40 [amdgpu]
 amdgpu_vm_handle_moved+0x19e/0x1f0 [amdgpu]
 amdgpu_cs_vm_handling+0x4e4/0x640 [amdgpu]
 amdgpu_cs_ioctl+0x19e7/0x23c0 [amdgpu]
 drm_ioctl_kernel+0xf3/0x180 [drm]
 drm_ioctl+0x2cb/0x550 [drm]
 amdgpu_drm_ioctl+0x5e/0xb0 [amdgpu]

kfence-#167 [0x000000008e11c055-0x000000001f676b3e
 ttm_sys_man_alloc+0x35/0x80 [ttm]
 ttm_resource_alloc+0x39/0x50 [ttm]
 ttm_bo_swapout+0x252/0x5a0 [ttm]
 ttm_device_swapout+0x107/0x180 [ttm]
 ttm_global_swapout+0x6f/0x130 [ttm]
 ttm_tt_populate+0xb1/0x2a0 [ttm]
 ttm_bo_handle_move_mem+0x17e/0x1d0 [ttm]
 ttm_mem_evict_first+0x59d/0x9c0 [ttm]
 ttm_bo_mem_space+0x39f/0x400 [ttm]
 ttm_bo_validate+0x13c/0x340 [ttm]
 ttm_bo_init_reserved+0x269/0x540 [ttm]
 amdgpu_bo_create+0x1d1/0xa30 [amdgpu]
 amdgpu_bo_create_user+0x40/0x80 [amdgpu]
 amdgpu_gem_object_create+0x71/0xc0 [amdgpu]
 amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x2f2/0xcd0 [amdgpu]
 kfd_ioctl_alloc_memory_of_gpu+0xe2/0x330 [amdgpu]
 kfd_ioctl+0x461/0x690 [amdgpu]

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
index 59e0fefb15aa..4d8058121678 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
@@ -54,11 +54,12 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
 {
        struct drm_mm_node *node;

-       if (!res) {
+       if (!res || res->mem_type == TTM_PL_SYSTEM) {
                cur->start = start;
                cur->size = size;
                cur->remaining = size;
                cur->node = NULL;
+               BUG_ON(res && start + size > res->num_pages << PAGE_SHIFT);
                return;
        }

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
