Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E786EC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 05:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB0C60F01
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 05:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADB0C60F01
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F46E6ECAF;
	Wed, 28 Jul 2021 05:56:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C6756ECAC
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 05:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2OdC34goqX1bxDXPTqKMpSHecBibAc66wAYHlNZ2vIvU3FVOur2d09MnJPknLVViD4kEByVM4hrABT93W+ZARct/Ugs/syrH3E8ldHhfEsHzvGp2jFifih1T8jU6QGK3FxesZRPeW+2Rhy3aQUHUoOhimrw3ZdaX45AUcrursrMWDsYV9LOjnGL1N+2MECBtYrPbkAV7CRQIYKwxyf9Hf3YHilON3XUnGeGKXvXkGCqr9UM6bMQrbzMIeiqx7kBhpIH1zrhlEXnMloOOGlXThFjbaaPJETUwZxcIyyvo94kEGBV36ceieBqCAlNOM3coqFE++gKFGIxvSW9nS6o1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GhAiyOrYat2F6xjI5vq0femhsoy8D48M7bJA/+g3Yw=;
 b=Qp/n+eQ5DG3L66CSvqKyIg5LMabFi0jFvPCqDHfi2xEuaO7s6XCepjxSlx9j0YMb4gnFQz1bwWYhUloSAWt2wYZ50wY8qqwLug+d6UFFk2InqPavhJVhb9/Ha1OKBPIIk9rEdlNRn7r1Brz4PYEcgBfxH3VTPu8NC3s/8bVV98DVNkdvjKfdM91ETVGfDyvV84VczOghJ1qSEqcaDODSPRanIkcBGvTSbFZtAPUZixH1s0uOhkWc9hwhPboAoDhIL10vcqY8W2XCjI0o8Q5fVF5+P3OCwf43gnZC4ZBqZUWUsFmx9VGTc59L/13yr1qxPYzW2ttKn0MM5DJxfQy6Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GhAiyOrYat2F6xjI5vq0femhsoy8D48M7bJA/+g3Yw=;
 b=oDf/ohSmSAnuaAAYM9kcSA2tIBHo8wYMT8hgnRHOIzXYFdi0hiE8uzHK+i9V01kL4gkxMrfI/QaFIaMCN48IQ2TunAzXXRQN/2Y18A4zN1bM/ztx9sAUarO1Qj7yOJXmTGfY0dQz1cGEFSUgazezH/k0lqcVfnnPj9ZIgUBgIjY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Wed, 28 Jul
 2021 05:56:15 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b%3]) with mapi id 15.20.4373.018; Wed, 28 Jul 2021
 05:56:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: adjust fence driver enable sequence
Thread-Topic: [PATCH] drm/amdgpu: adjust fence driver enable sequence
Thread-Index: AQHXg2YkseDAMEE/z0u63ftoCQxKEqtX4xtA
Date: Wed, 28 Jul 2021 05:56:15 +0000
Message-ID: <BN9PR12MB525730BD802980F5A114A471FCEA9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20210728040741.2734771-1-likun.gao@amd.com>
In-Reply-To: <20210728040741.2734771-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-28T05:56:12Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=40b1ee99-31ad-41ca-a7dd-63007542c153;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73d73630-9e31-448a-7f65-08d9518c696d
x-ms-traffictypediagnostic: BN9PR12MB5131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB51316288CA0ED197032FCA26FCEA9@BN9PR12MB5131.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gWcxMpkgLd9aULmO5uA46AE5RO0vr4W46WU7qoi1TqKrW4+jpss8AMAwfJApLs5qjiiIlF+NtJyYagurFCtUg/0OQZc9DLheph3s6q0AqWz1MRqX5svU/6y5EB8V2TX63sEKgJbVsJf+H7cOWd6B93vej6a4CAO8JtYGvNexEKdwXEKcy/2izgLx9ZLMsdsRHrFk6QoTqV4mOchmcfiUFHo7Rbm48/aOK84kJfdQb+/t/wNeD7KOGahB+yd5zbgLEQzejg5oEilo3EtbA5Txe5m2J/7ZOYQD9XRUUncneuR5ExqSVTaNVY1go2wq/RpRylN+aQjFvxAEamsYb+mGSc/UAhwC+YtI81ggz9m8uKjWhPu8N6VfD7yXZJETWhxWj7LuiB0Q+Xw82M4hGNYUMJlb0KhNlKF1KM+hBpxrnkATVXlK9kt+5JNwZX573aSzZ56xquXz8OWNbDObCq7ldUWRbz3maqNB/ZS7CXqSjd/eTqsRezvy2GbaYn6sW3Vw/SPwM/o5BtXq+dEDFHBxMZnLFWHfvnH1qjqR2FX8cFyWvGeQDiI/UlOUN+CC4/jjKJYKoUI3p5vErhRXUkgYXFlQDELentaYi+UQBFDsKqwiGJZR14O9L/pcOQrrDlfkOW/kIHtyJCAmoEBc8FE1ZiqPSQ4t9KtW70KBUYp0x7xM2+2b04jIcY9f+UgrAjOODVzzLZW3SD0RYuiOzJb+2A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(53546011)(66476007)(33656002)(2906002)(66556008)(66446008)(478600001)(64756008)(26005)(6506007)(9686003)(66946007)(8936002)(38070700005)(86362001)(83380400001)(110136005)(186003)(316002)(8676002)(7696005)(55016002)(5660300002)(76116006)(52536014)(38100700002)(71200400001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/jUw+YMfcgDAgD9s/zeQekC2Mr+v0lYPmq56tt2EuS18NGjfu2l7fpCdYh/i?=
 =?us-ascii?Q?bkFIlHU+H6v3klUzvotnntjZ3oav/w8ZJJPWyU8UL3nS/+P5yqwHpmf15Bmk?=
 =?us-ascii?Q?azCCEWuNziT2ZuTJ+pMbDpO/vdHOmwfp9Lyv5Wddydxq8sJE3o1KVq64lQeB?=
 =?us-ascii?Q?GPz/8JyGSIYbeaVTI+2xpcMjARh38wL5Lh7sf85lb/byLPEDzFfxS7gyyf7F?=
 =?us-ascii?Q?wzI+A7MOEBJluWfFUcglkKy/YBJOpvHRvgYcL6FbhoFayiaau9R8iFHI6P6y?=
 =?us-ascii?Q?8wJIbNSfw54yTijytY3jI/ad5BTCnbvkeCAvoDvMhN5A54HZ3uaBnG5envWe?=
 =?us-ascii?Q?DJVv5lAnl1s76ra2u2lB/NcXtDt4QtBVBtEp4QbzaYHhikbypQz8LrbXtCDT?=
 =?us-ascii?Q?I/F3p37VCNVYIQddLYQ4BVlrxJGFO819VQ5l3RCfuH9RixhyYfNmim1a3gIJ?=
 =?us-ascii?Q?xJ5ixQGxLp3xk2nUBuPLY+JSHUJHnrgXjhlkMT2MOKoXULN22cHsFvvAEQO3?=
 =?us-ascii?Q?YixOVZYo38QAL0rvS4Y3e5GHgUKkVk15rGp4eIEfxISgXt+WXE4fRzwqp9zt?=
 =?us-ascii?Q?HoFpAQXkOHgoEI11gY+/YUj7qMa+1m0bJqbVX2Weh98NjNXDBR36fLWptfEY?=
 =?us-ascii?Q?IuXy5lzidTFo7qUewJvlzBZc/wEtmFW8VXIOweoFIYL2vHUdtlXgPTGesIAZ?=
 =?us-ascii?Q?wr2hFywQzP/lXhvdXJe2pjJ9EwgyIrpNCabhumSTaajJ2TZjBBaizvzOTD3o?=
 =?us-ascii?Q?nMA1x+SKrOT8mt30lYHmmcgX+uBZ3k5hhuVEbG0LpugR/NRc88xFgfebZtWy?=
 =?us-ascii?Q?eMVcGjJh7MikYMaqhgjcz88aepdARKMoolUi+UcWdOgLWQ3CluvSHX9XY86N?=
 =?us-ascii?Q?h1mStZ2GXJKL+QLaCkSo/bm+I0cSm0OClfnEayDl/zGNwgE8yrePl+emZdc2?=
 =?us-ascii?Q?g8JlHL2dZvBD0ODI13e1CZFEFrCHPxLc/7OtLtWTPM/OYt/Eq0/I/bALsUA1?=
 =?us-ascii?Q?u5VmX8JiMxsh6QrgX/hyIkK9XJLK3EFEVDQjhcMGm0VhT07Ie3yjhWrGLmRJ?=
 =?us-ascii?Q?fhVeQFa8CcbxSSlAsrOwpv5urLrCIjh+4JSRClUFVGS9c4FI7a6MZ/KqrmnV?=
 =?us-ascii?Q?wa3DY7r7p1XKLG65ryRxyfr+3nhbes07Ci3IwhBVLjd00b//WQNCvqG/Qjtw?=
 =?us-ascii?Q?H0GSWiZAe00y6fpK3BouVoaMS4pT31meqfo5X59jgG2QVNM3hVh3sw9Lc5bZ?=
 =?us-ascii?Q?aXhQMQeOTOl4+1xuXXs0AGNq4gT5fYTkqv55azwymi0xYk+g+3rQD7lVDvx7?=
 =?us-ascii?Q?8W7qBQVnzNaV6Vtg6QHn0voH?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d73630-9e31-448a-7f65-08d9518c696d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 05:56:15.4476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6smNLwkFZgUpqDbyy4FhmN/aQYUqcR0S8x5dnajYlEsGi4SIn/gR3WwtqDKidrAvJQo/wU9L9DLHd5l7yDC6zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Per discussion, please reuse existing amdgpu_fence_driver_fini_hw/fini_sw by changing their name to hw_fini/sw_fini as the patch you worked out in topic branch.

With that addressed, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Wednesday, July 28, 2021 12:08
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: adjust fence driver enable sequence

From: Likun Gao <Likun.Gao@amd.com>

Fence driver was enabled per ring when sw init on per IP block before.
Change to enable all the fence driver at the same time after amdgpu_device_ip_init finished.
Rename some function related to fence to make it reasonable for read.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++--  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 15 ++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  4 ++--
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d3a4299b1f30..77195a4e5c59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3675,6 +3675,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		goto release_ras_con;
 	}
 
+	amdgpu_fence_driver_hw_init(adev);
+
 	dev_info(adev->dev,
 		"SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
 			adev->gfx.config.max_shader_engines,
@@ -3939,7 +3941,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	/* evict vram memory */
 	amdgpu_bo_evict_vram(adev);
 
-	amdgpu_fence_driver_suspend(adev);
+	amdgpu_fence_driver_hw_fini(adev);
 
 	amdgpu_device_ip_suspend_phase2(adev);
 	/* evict remaining vram memory
@@ -3984,7 +3986,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 		dev_err(adev->dev, "amdgpu_device_ip_resume failed (%d).\n", r);
 		return r;
 	}
-	amdgpu_fence_driver_resume(adev);
+	amdgpu_fence_driver_hw_init(adev);
 
 
 	r = amdgpu_device_ip_late_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 72d9b92b1754..e2f606bca779 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -417,9 +417,6 @@ int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
 	}
 	amdgpu_fence_write(ring, atomic_read(&ring->fence_drv.last_seq));
 
-	if (irq_src)
-		amdgpu_irq_get(adev, irq_src, irq_type);
-
 	ring->fence_drv.irq_src = irq_src;
 	ring->fence_drv.irq_type = irq_type;
 	ring->fence_drv.initialized = true;
@@ -572,14 +569,14 @@ void amdgpu_fence_driver_fini_sw(struct amdgpu_device *adev)  }
 
 /**
- * amdgpu_fence_driver_suspend - suspend the fence driver
+ * amdgpu_fence_driver_hw_fini - disable the fence driver
  * for all possible rings.
  *
  * @adev: amdgpu device pointer
  *
- * Suspend the fence driver for all possible rings (all asics).
+ * Disable the fence driver for all possible rings (all asics).
  */
-void amdgpu_fence_driver_suspend(struct amdgpu_device *adev)
+void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 {
 	int i, r;
 
@@ -603,18 +600,18 @@ void amdgpu_fence_driver_suspend(struct amdgpu_device *adev)  }
 
 /**
- * amdgpu_fence_driver_resume - resume the fence driver
+ * amdgpu_fence_driver_hw_init - enable the fence driver
  * for all possible rings.
  *
  * @adev: amdgpu device pointer
  *
- * Resume the fence driver for all possible rings (all asics).
+ * Enable the fence driver for all possible rings (all asics).
  * Not all asics have all rings, so each asic will only
  * start the fence driver on the rings it has using
  * amdgpu_fence_driver_start_ring().
  * Returns 0 for success.
  */
-void amdgpu_fence_driver_resume(struct amdgpu_device *adev)
+void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
 {
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e7d3d0dbdd96..64471018f5e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -117,8 +117,8 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
 				   struct amdgpu_irq_src *irq_src,
 				   unsigned irq_type);
-void amdgpu_fence_driver_suspend(struct amdgpu_device *adev); -void amdgpu_fence_driver_resume(struct amdgpu_device *adev);
+void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev); void 
+amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
 int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
 		      unsigned flags);
 int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
