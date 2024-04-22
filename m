Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FD2C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 02:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 813F9112669;
	Mon, 22 Apr 2024 02:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FC2tFfSm";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AA7D112669
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 02:25:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCDPokGtrdw5R7xITEKRnH34RbRfNm31E4uxKsZTQ7mZxcw+LYX2wuEe3Nwh4Tymg7SQ+zqs8PvJJnp+D4oXPchhibLGGmr4o5SMd93kjDY1B9+jmSJuL7KxGMfft5UkMYR+hMF1E+ekpF+sL6CpkPEeqO8y5EmYcL4XBv2mFonSKN8os9bQIyaT/rJXF3xN1gCWXezMvCU4uKETfzstjbg2HHuedYmS9A0mJqr5jqOtOcRJOiryxn6wNdLsQ4ojxUf077YQVhXr1SVZLX/XEaZjjo8LttyaZYg6VkXSwJNIrYALQehmHkzF9nHjT5emOoJ4cJXkgff2lCY/hsshqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYAFBe+f91nRaylgP126a3cHUyF2OpcceodNJghPqR4=;
 b=nzdPcTuxzrIRDhJ6nD0AMamXbHin/1i+TaY4mXY8WMbknpYpyDEA7hJls8e15hNLK4PzWoLuWOS/yUTHEheXM1Dd6qODVwwF/C/u5+MIvFgw0exN6Hr1dm0n24+TRRP7U1v9dlHBADffG0i7x79w3bHru7iqDt1yx5J4AyhmXohNz7PEERL0l85hEBlAOBIg6mPHTwpqHW3mkBwxaXI++zgomf+Nte4Ws6r9eXyx2V7m2KotPtR76LNcGoZat/WWowJVZoa5BlEYXEKAsQZMN382c0Ug1h3xIM17dVdYg3X7lJKXcAqPLisInz2CyygnXzBnNjQmGVZL6OLR0eTbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYAFBe+f91nRaylgP126a3cHUyF2OpcceodNJghPqR4=;
 b=FC2tFfSmy81RYSNL+5QNtGFy3++zVsfrfFLdDK8uU3gKSW1PQ5+xvuCmM45JCYB300Om1Qp8uWX/L6/FH8VaZVmUBZGmKdsmNjm6G98iBgws+CQg7YHCEDevl9MOb+2gcr/ePBZiOthR3b1WtPA3fo1GKbeXRdMi4badA9kR0qk=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.38; Mon, 22 Apr
 2024 02:25:00 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 02:25:00 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 15/15] drm/amdgpu: Use new interface to reserve bad page
Thread-Topic: [PATCH 15/15] drm/amdgpu: Use new interface to reserve bad page
Thread-Index: AQHakTzYwC0hSXi0TkSyow1znVkUCrFzlfLg
Date: Mon, 22 Apr 2024 02:25:00 +0000
Message-ID: <CH2PR12MB42157A49513459D45CF500CCFC122@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
 <20240418025836.170106-15-YiPeng.Chai@amd.com>
In-Reply-To: <20240418025836.170106-15-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5ace0545-8bbc-4eb5-97ec-9e9ffe3e5d67;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-22T02:24:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|PH7PR12MB7258:EE_
x-ms-office365-filtering-correlation-id: 91e8da59-7e65-4c8f-b719-08dc62736909
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?zSU/fZMIkMT+Kx6Fl7JVWpilvPnYlrOIrm7/e+NBKaO3hIY+E34rSIRO6fXi?=
 =?us-ascii?Q?RQ6dvEVpRAKw8+Tee/qMi9jovnG+DhYu/Q5D+kI0aEcx0bbgvKn4qmRwzUai?=
 =?us-ascii?Q?52giBfSVjo3kwRD13pM06k5VrPpDQC3J3wEdiTmu7SdKB1a8q1tWztXyR+YS?=
 =?us-ascii?Q?nc2XyL+nkH8tPcSD0S/11584tW3RpVKdd5I1PIt1BAbRdi3ZRAxMqeZOnwV0?=
 =?us-ascii?Q?W+r3CYSQlljIsr7cfdiH6zqsQ57y0j9tYwSRIOB/B1VxQXql5+TT1ld1NPzq?=
 =?us-ascii?Q?405REdJQm3dZW1I1z3OKXchuGF/9iDHwEHytt8BIwqd8+dT1tQT5KRCE4LGG?=
 =?us-ascii?Q?uvxp3QMiXoq6Of38Gz5/iv3lnwMas5QEc9wGqyiwtEifgy4ZpNyKJP6CS7lP?=
 =?us-ascii?Q?ws2SSc6YdfOGGGTATerxTJYpl7UyV33ORuNwd1JgjaZJgNe5CziwBEBtpUb4?=
 =?us-ascii?Q?2b1qTyhpGyniVSRb6Z0zhCMwaIFwvp3bKjnPqXAeHXTRnz8CTpyvkW++lBLa?=
 =?us-ascii?Q?gUTte/rvu4Wj3C5vsn+y6nczJC7l0ODhe5Xid5sbNjnBGifAvhoQhODSnmUK?=
 =?us-ascii?Q?8hfZTHFjlFpjEfqU7u9fWktm+nkzu5eQz5uaNCY/SRtJ4E+jWIUsLPP7HSpk?=
 =?us-ascii?Q?LGxVx3ShhUd/GrLt2ou9FFTHqUqB83WiHMJajH/HryDT73fJuvAI6HJHkJoY?=
 =?us-ascii?Q?cYyQofMGQefVIHe/DtrAbOYlLs2HzKXUdjyQiF1F4Yjp/3vyHVIPIz7gguCi?=
 =?us-ascii?Q?Tfp0ro1H3c3JoqYyVzRHcADsVKh592CSCc/99RvtAVBPdL4YPifF3JYU3j9X?=
 =?us-ascii?Q?TQl04BEarl46elVcRrisf9GJP0t+9mWWoX0pxEN4gDHyg+EhhvhITa0+2YQn?=
 =?us-ascii?Q?uFjRzyDB2FLDglfnY2bfTFchOVFEArDD8ySEFIOTM2L6qN3YgSNWEpz3SsCE?=
 =?us-ascii?Q?SgHz41un7oPGHYwAzjFw7H4/ZbyXciYXXs4p9iOHeAFqB8MX1BhXkYPhEZMa?=
 =?us-ascii?Q?xfvgfxgyqd9+wCkZZ9iRl7j503dyRdIcAvfq+g4k7IEDXR224Npu/+cokb51?=
 =?us-ascii?Q?mCDb+TZep9Zpbu6JFZXTIjJQy6mACUglPfQxrdfKibWkWrqRceHPF5A1tVdW?=
 =?us-ascii?Q?s/A0ppo5F1y5sbwfrcyK4/yWNU/iUO5uiNctsPTAZeL/5+sjAHy7SUrfVDsR?=
 =?us-ascii?Q?4/lYbXk2cuOh6LbKbJ03Mx+nKVK+RBThbFHtP2Y91Dfh5FczBi6j9riFb2bB?=
 =?us-ascii?Q?GopucjEYiy50h9JfAKpbQaLu4rT3UDSf5G3D747C1gJ7hdf1Y4OxWGlrDdmQ?=
 =?us-ascii?Q?DwK8H85drUsp7iOkjxVXcju4G/jbhrHQHEa0RsbdJ1GgMA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2U5EUi8NCAgj3kYihpopouOEyY6WVf7Otffca2MDOoeNbySsPUAOlHrte3iL?=
 =?us-ascii?Q?+xffXvJLMieBQUfju9gndM2SoGLLcn/fgGWMJJoHTl6yS7XZH4P6I/mDpheu?=
 =?us-ascii?Q?7DppQs0w26/W7/qsMFN94652lva2p2A7AhnJ8qjebBTHYFNE2Uc4HEWyahwI?=
 =?us-ascii?Q?tB4dCXqKwim2Y/TaAPSSybQitIYu2bTb05reFtHvS4IWKVxh8PN+iDo9rX08?=
 =?us-ascii?Q?n/5fugkVWjeLRdEz1Jdgs/TcHhd+k/UztfypZpfqM+N+ic5Zcr9W3r7D8nB5?=
 =?us-ascii?Q?au40BIbcFBx00NFDv+Dg6VijUmcT7WcKlxtkJ0JSnkyS6wKdtnjFbgt52bjX?=
 =?us-ascii?Q?PI/BsqSgnMgGe4ZGz1g3OMR+1if0qfevOMZEDxO/Zb3hK4MxMQ2yXmkLRqR+?=
 =?us-ascii?Q?rQADzxVNeqWIsylt/lreSd+zm8BlQVwTMdqoKMpZMFh41cfZPRy+ACAURARh?=
 =?us-ascii?Q?W1BcyQ0ZIdJoPDHOTEkvpbGdC1PKiJa/bvSJarTE8ouGHl3GkrfKZhVoEmrP?=
 =?us-ascii?Q?sWDEim6CMJra6eVxMN9YSUC2JT3YiDppd/8VIxdIjaKVwpoDAx7KkXAGOGQY?=
 =?us-ascii?Q?VChnJcaMDqkJVhQ2K75EHk7BABSRtAYcPL7QYPtLWs25yKR0LbA4fgVoMAD5?=
 =?us-ascii?Q?unCTGI46EyO6rMsmoCJSD5OJNo6iWrhqKadbdU811pAYSnKna01WVHTYxHTR?=
 =?us-ascii?Q?gkNnXFhsaY04fKFUZMDK+sRkw9gkA+OzwjfxL8DEtr6M6X4hJJanv7PD+zxj?=
 =?us-ascii?Q?iT/FOhz3jFWZXn2naQ3y53lhqH9WFl6Nsogoegy66MnAoWGZ8Lgwr4WAIst4?=
 =?us-ascii?Q?DWgm8Eu2vWLuAfYcAEPR4lwrPFy964PoFlXka+jsz8Y/EgdTgvVBq31Ovbci?=
 =?us-ascii?Q?iHuGrZLhva49lgcGss4JzpepcyU3k+Bij4Qmn2WHkivNtXmJ9uK5Jdref9tR?=
 =?us-ascii?Q?xz5MDyUPwR4nTl4IcDv1MnF2ie97uhfUMZGLe5Ef4qI1nD7ZdePZ2kZjN4gW?=
 =?us-ascii?Q?FwWU67QkXs57eXYj/zlz3wwWagQ1Ycf98afNfSZMw4pUfq8Q4GxgnOpL0BeA?=
 =?us-ascii?Q?xO7I8Zaj4jGSKtTy2gIiuMvmUF2QLlVAVDdHFsxjzQmT0Wz7fi6e117WybBw?=
 =?us-ascii?Q?UD1x8nOkSXRGFOxK57IEXQ+47HLZm6Dz0l9hRNZebSPR8N1BmxbA5vL7bMBI?=
 =?us-ascii?Q?A0MLE/dXgXoIq1YhH0HZBxMJoR+7509dForgpJQ3eXGDDjxA+AZ6HJ2eO2eJ?=
 =?us-ascii?Q?zYkQItsWnLghdZrJRyxDlpQdd2TcrnReg+mwWgFtcsDIimqpxeBY+CCHQUku?=
 =?us-ascii?Q?35YyHhOsuPbLYxLfTUIHPkBX4COpmbzdCr69LKlggw5jDWLF1HkHcMjlVy80?=
 =?us-ascii?Q?D3P1s+o5Js9s+k7wTq/5wWlYr0Dn7b+h6hMaOxgWoCRFlrT/8hKY5jYjwH8i?=
 =?us-ascii?Q?5IkSLoM1fdyV8cklbNDziuL1vO9erNvZTrLCSZYGzvxscOLlHrgmOR6XEXbi?=
 =?us-ascii?Q?AZBXrHYvBXI43ukm5kdGWNZtZPona8GTlc6Qi0aTZZXl2Qw1/ZMQDeJGVli7?=
 =?us-ascii?Q?QHXoM0T2AVCBTYcgFsA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e8da59-7e65-4c8f-b719-08dc62736909
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 02:25:00.2535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTDSVB33oxOsfhSumiD4LYf53fag9zVdGWYFjbOSYvCG7gCQzXu5uPUerP6zkQVEpLInHqM42J/5ltGX4L1GRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
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

Ping ....


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, April 18, 2024 10:59 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 15/15] drm/amdgpu: Use new interface to reserve bad page

Use new interface to reserve bad page.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index d1a2ab944b7d..dee66db10fa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2548,9 +2548,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *ad=
ev,
                        goto out;
                }

-               amdgpu_vram_mgr_reserve_range(&adev->mman.vram_mgr,
-                       bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT,
-                       AMDGPU_GPU_PAGE_SIZE);
+               amdgpu_ras_reserve_page(adev, bps[i].retired_page);

                memcpy(&data->bps[data->count], &bps[i], sizeof(*data->bps)=
);
                data->count++;
--
2.34.1

