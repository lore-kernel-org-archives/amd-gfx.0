Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D16EC47082
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C07560E0C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C07560E0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F4446F49C;
	Thu,  3 Jun 2021 15:11:40 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D6C26F49C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 15:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPKzqHoRJ7pTAwxGX/Q3MbPyG5weTLMs10YVz3/fHIxAFGVGqDfdWzb3v34fXpp6GxnBKsFYEaAQtnYAcZ0lWP3JqNiY99vRCztzNVguw9GC8iNxFe7YPeZCGtqIUDN+E4b6hOjKWokV/o/bXEDXIltJ4aho7ZBs7R2+BSVdRiv5kVpMmwGksBmH2/rd6cWQrY2zBarGRRo+lUWersHE346j/mRJSNSregu5gKYwEs1XvzHi4n+HC2LagFeYPPzQpHSen0/zNu1o+KKm7czB5wbuW5PqCAaRHwXuS5vjj12aWObxgLdn/mSB905IMT44BkAIfCOy7X86dWIvaNuYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGH6WmgwCFUYdkROUQ5QNLI8jaua5Jedm3hFr3lBST8=;
 b=dMrw6g/VyVzPriHWqD8y0vJbjnXxbvd9PxsQIaJdb5FBnFBxb3TQIU9sASp8zd1cFSLUojjjAvGU5UfR38Nukk6OcnPrpOg2bPo/OC8lEFpUBGWWDU8qiHeg0SSRBFyFcUNhPNcBvHttLRtzdTFBc+9xH4/5Ruax43fdXx1DC0sU9hwKyermA40p1IdemXY5ZSsJjgtsHL0LHx+Ley8Qmafb5n5dQSqzu0OokWH56LPDXIdnSP63HmE9HplJFRXMTmhNXgaJW16P+jJ7OVN15FRdbXhKQrN9FIq6aJwRNJjyZ6b6Qh+JXLUtnodix9B6DzoSHch2IwhfDLUhcXUtKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGH6WmgwCFUYdkROUQ5QNLI8jaua5Jedm3hFr3lBST8=;
 b=tQk0SAEB/D/EuNO1k+ZZv8v1iuHzT7lzQfOzTuduJSEcmC3cbcEZxEHDlHKQVHcADNVc/Rdtx+T6eTF6H30PHuU85I+/HVxI4AfgHcRKMjwxs2JRG3LWov/TQZ4nUHnUrJu0WusIWWr2sjZamRn6vRz00mLH2GVLVfA2aYwWNQU=
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.22; Thu, 3 Jun 2021 15:11:36 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::a8c8:ff39:a981:445c]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::a8c8:ff39:a981:445c%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 15:11:36 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/5] drm/amdgpu: remove sriov vf mmhub system aperture and
 fb location programming
Thread-Topic: [PATCH 3/5] drm/amdgpu: remove sriov vf mmhub system aperture
 and fb location programming
Thread-Index: AQHXWIKnxGlEX6HV4Eu0M0X63FB2qKsCZGPg
Date: Thu, 3 Jun 2021 15:11:36 +0000
Message-ID: <DM6PR12MB55342CC0790CF1C7DB620CBDF43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
 <20210603141305.2542-3-zhigang.luo@amd.com>
In-Reply-To: <20210603141305.2542-3-zhigang.luo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-03T15:11:34Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=67c0e97d-665e-4e40-b135-04f1a7030b0a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb2cd3d5-f612-4014-befa-08d926a1e177
x-ms-traffictypediagnostic: DM4PR12MB5214:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5214510DED9BDA1EE8FA19B3F43C9@DM4PR12MB5214.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l6yhoV7FM2f7YI7hEVVIJCBsjRkX+RQGMp22Qf15uNZ42jxJi/ekC1p6Y1UbU/gaDTQ0m4ro12MeyJCka9dijvHxLTfPo6KNBfMMlhx5jYX272Q2J3N4x2t6JHz0BWgSdvoQ7R4ns1BNNPnbKu/F0y42ac7b2teUFBzn0sc4cTb/Jp+OK4xowkVldAMaZkWGfKs3r9xAx0CWG8sTDpJamDFQ0qXLneo8KN/MqsOEKVU/hH6Dax0yhF2lKAJ5s8oiEIo7M3uEupzMpBNA/CpRbqC8XplG/s8tiIQZxgP5oZmScwoXn+wksftY00ABvalQY82tgzArc6jCuhx/Ip09yoFrIMz8XoZIVcF3HsPTs5IZN9YsvFcLGlnIIgZmW/R7hmbx0JQigH9jIbNOhm+3xaXUvOJg/gTr17rA/ESbg+SKDbuz7TMV2W1/ZzpYDF5YVtF1HjDB1ZvhivMYw0HKbkZfTdXyHs0aNG07Lv3vHbD2TwtxH9ycZCkFEOoXhBcteIk4m6sSa68hrR+SgiTySdkQkfCbvpvkX2JTq0UESCjnNHJIPdET1hUI34gSc2UQ7gVY5SiNVDyRF7wc4GavYfbkSyNOVFQz3MZ+2581F6qzJSf+5q12ejuVGcCUYWyTMacVo1l8tfqkaNEEkXtI9w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39840400004)(966005)(110136005)(478600001)(83380400001)(26005)(45080400002)(38100700002)(8676002)(316002)(122000001)(53546011)(33656002)(4326008)(8936002)(9686003)(66476007)(86362001)(6506007)(2906002)(76116006)(66946007)(5660300002)(52536014)(64756008)(71200400001)(7696005)(55016002)(66556008)(186003)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YqHs0f4Ky+ZyAbbh0g3ynVGycvBLULeAyZZkJnXbJgLmyEUFF4HKDYwJbr0X?=
 =?us-ascii?Q?8jnjCtmQp+01SRmitm0rW34fmaLCzYkWVOZRLB2bNAQZHlg+sOwoMgYV6nVL?=
 =?us-ascii?Q?pnF1/LQWDssr1qQRlUQ2BDs6h4k2UvT+mjM3WQL8T+Lx8GaiNNEVi7pfBUEu?=
 =?us-ascii?Q?qw+kCoF8ZYB7kuD0aKxs6/nbevbyj30HQnX3Ariv7PWi4OmZohT1o5dAxd59?=
 =?us-ascii?Q?11AJMO7WldF5DMdXq3xZx5q3lGgUGpDt9w8ESoyHgF9XpJUMKA6uaboYtRQ/?=
 =?us-ascii?Q?afLwCGFry53F1WYorOfMbFQEsU1mIwfm2p4uF9Bk0dtH/CVmIQWRwyzbVJGa?=
 =?us-ascii?Q?9bbELMJRm41Cu6EdOYkvfWb4Ab8mnhdFlOp1q2MeYbEn/mlDhjHwZ8VTe1Zd?=
 =?us-ascii?Q?9z5pSc3otk5co4Lj8CrW9q8vzbNAoV7EDk3Zh3/iIpZ/z2fN4JDYDMsbrFs8?=
 =?us-ascii?Q?zzt7vSSxx+MWOQLILbJMfwlfl6ctVKlKhCMHnVbPVODt34zpWJUImk7/mXqf?=
 =?us-ascii?Q?5/9RVWecwlZ6sejHz5S2J6wdZpMJOUWxK+IxvodJJvUsQfAS8au6NslG6rt0?=
 =?us-ascii?Q?Pd+3R02bty1xO8UefMJN/29pyCXmi+nXqqgy7x27D8nFicgVUY7FAD60CFhf?=
 =?us-ascii?Q?KSrLgKEMRaiRz0RbZC+BHan2wIxZru4NhaGXUw0wKaEyfNaNIlmPmlIqaQPS?=
 =?us-ascii?Q?09UxQ/QuGQC79KPjiPDdSVwGd/580b1nfbXQ8qxSP1EpgS+9rJC0Iu0QuxtG?=
 =?us-ascii?Q?qwpp75oz/0xZ0eAqIc2KHduN/TrBYptsbwlDQUELYIenhZCMQh7oxglQq0Cs?=
 =?us-ascii?Q?YBDsGHbXOioVJxcL24P/0KEDFm24VN+JlfM3M4HCxId1H45kCuRtRFAmihVb?=
 =?us-ascii?Q?HKrABt9v5xmEF3T+AQ3gKTTMlqHPAbTsjGbkSnQTdj0/xOUBaBjXz/NvYjH1?=
 =?us-ascii?Q?eM2EGq8D77mjkblzF5/8NFaniHSZoJgmtb+Xo6G7UbPZibbV+jIxxajJ/yi+?=
 =?us-ascii?Q?U0BFQHmAElhzDgKIJYnod2L5pf1VbhWC/GFT7vWPWXdoc9z3VG3nkuGIUjwS?=
 =?us-ascii?Q?hl36zSdXZ1JiT7q4kLYsCHSPyftEuo2Cp1rM0b1HxiVfkEb6M7ZGcYgMv2+p?=
 =?us-ascii?Q?yhN7N9bZxP2/UNuDcgtpF1+gxZCoimtRaxD0ot0vHKlLj3Gin6sltPvFpRgk?=
 =?us-ascii?Q?5JREQQR1MEteWMcafk5QKaWMuxqOeNXBn1LciwO4yDtX2dhAUmJBWDVPorlM?=
 =?us-ascii?Q?O8y1pxn2Yv2a0FOHYZJRBspHJDgS8x7Ub09fKag1tGLAkA83pyCgfKB+1nnF?=
 =?us-ascii?Q?EcTDK9fi0RuIqPf5SFwRY++A?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2cd3d5-f612-4014-befa-08d926a1e177
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 15:11:36.2583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yjaH2bnesfYeEuzrqmDKGjrlVZY4OeF6/YRZg2+wSCkgYUF31BlwXlHbxGeI8nXPgq24Ay7R9bn7LEv+6AMgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
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
Cc: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Looks ok to me .

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang Luo
Sent: Thursday, June 3, 2021 10:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: remove sriov vf mmhub system aperture and fb location programming

host driver programmed mmhub system aperture and fb location for vf, no need to program in guest side.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 998e674f9369..f5f7181f9af5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -111,6 +111,9 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
 	WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* Program the system aperture low logical page number. */
 	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18); @@ -129,8 +132,6 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
 		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
 		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
 	}
-	if (amdgpu_sriov_vf(adev))
-		return;
 
 	/* Set default page address. */
 	value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr); @@ -331,18 +332,6 @@ static void mmhub_v1_7_program_invalidation(struct amdgpu_device *adev)
 
 static int mmhub_v1_7_gart_enable(struct amdgpu_device *adev)  {
-	if (amdgpu_sriov_vf(adev)) {
-		/*
-		 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
-		 * VF copy registers so vbios post doesn't program them, for
-		 * SRIOV driver need to program them
-		 */
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE,
-			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP,
-			     adev->gmc.vram_end >> 24);
-	}
-
 	/* GART Enable. */
 	mmhub_v1_7_init_gart_aperture_regs(adev);
 	mmhub_v1_7_init_system_aperture_regs(adev);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CShaoyun.Liu%40amd.com%7Ce69db3117bd84691819308d92699c93c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637583264214796331%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=vmZU4JdKm5wuX12YboT602UZTCGW%2BqtHEph1Dyw%2F8gY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
