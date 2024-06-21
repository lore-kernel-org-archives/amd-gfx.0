Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40E4C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 06:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8F310E9E9;
	Fri, 21 Jun 2024 06:37:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PMskQvOv";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E00B410E9E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 06:37:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y84/atHnC9ycW70Ge0UvD5IIXpm18OmnvB8u6s3wvUTnKMEJL5YVhn8cq/MLFMO1iJzy8KOsiuOImB6oFGgslfSHdg+s18s+u3HRjZFa3jOhYSjzfEDdLBBo9z/tHYVdW7nv8/M1KHyKeBsiunazqllyKvlPhD63rBPTws4ilpethsWwTLj+vsw2wkgnOmH57zjgQTG/5IO/h0k++vnpsiS9f8JO+crOYFKRqF7blf6mpRfNoFUrTuA/VFNam0/sqQd3GEgIMEZAFSX2eke4XKurF7kcjehRekagjEIgZixRx6ukCU3rhLi168C5SBc3qjyJkx+6n6HHe4YJAzwqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4GI4BvQD3e/cdB/DM/mP+5pbGaot0R4S5wuiCQoEGA=;
 b=jjoSLGHoZ33LNf5Ur7CNtGcm6fEyxLLt0C6bBMbdCl2jXRjysBew+ISzR1dCUDhTcBQnTf9TS6XpeJrShVtN4xc4HO8jV8AYQi7tOE1PtQ+0h0qp7v7PQfIcMWDlQF+5T5V+w+s+XSx9bnzAEqgwwOPzOMFkE9vPFzbdxUKdZUVxm2ixdAFSecwGBDy49xDVA8bhKhFE19t6eBR40kxLQFS0UCuuGoGrtWUfDTi9LTt7qreaQqH9drPSY2TGnVmQlU8xylsexczihIWHxoxElM66e94I8//aiECwtBOhBiW7p6C+E1bWyHXxzQoOPJDJbVjSfrtvtDvI5Batr/YqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4GI4BvQD3e/cdB/DM/mP+5pbGaot0R4S5wuiCQoEGA=;
 b=PMskQvOvDkSEUPE7SzCDPBiiLpS44C7RUttz7MDSpxQ7aJalrdPXnrWBiFwReaIXFmsdSZlIH0O0zgRBFC7kqjBimlYJtW4iBJlpkeipa5K6nZOPTzfiWA6RSHWpTYfOavVjQImOhpORZ3vrVRVyjDfkdjsWmwhIodwWaWMYlrU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 06:37:29 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 06:37:28 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH V2 1/4] drm/amdgpu: add variable to record the deferred
 error number read by driver
Thread-Topic: [PATCH V2 1/4] drm/amdgpu: add variable to record the deferred
 error number read by driver
Thread-Index: AQHawtR8caHy+o/JoUK/da9TQiHZK7HRxRsA
Date: Fri, 21 Jun 2024 06:37:28 +0000
Message-ID: <BN9PR12MB52576C871E3B6131A3B580ABFCC92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240620054020.434523-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240620054020.434523-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c6c4203b-9593-408c-8a2f-287a2051c6a5;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-21T06:36:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB8366:EE_
x-ms-office365-filtering-correlation-id: b7e61ac7-bdde-4ff0-a1a6-08dc91bc9f10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?wg8XDLDve41X9d0SAyoXfeMUZjxo2QgujJQlQSyoGALM6sXexq9qAaD8DNmB?=
 =?us-ascii?Q?UbJFdneR6T0L15zO2R7W3x2+syxxD+8okW1iWh8obA2ICMSavqFbsc+auMWI?=
 =?us-ascii?Q?prvzdvBMB2uK+4pcvZte5NaOnmHts5MbTQMcJoR7MxKTaGl65f1guk7qEx+K?=
 =?us-ascii?Q?96GbBpYoCw1S9cR/VGJAHo3TjJzeqwl/HpBDoyD6/PDkhwCeLIIekApj+0bx?=
 =?us-ascii?Q?3bvhbyTSUZgXFacfuVbgsw4D1FW/zInbOQSw1MU8z+tH8fhsOLZ9ItAG8Jgg?=
 =?us-ascii?Q?6XSpNv8i8N8Wb7lSG+EVfPFC0GZ/Ro+TINs5N8DE7vjauQOXHyeSGJ2iQ+WC?=
 =?us-ascii?Q?W3wtHv1bkNLnIyzwbEv0L2UqyGsCFjdOrWhVeG+eChgnAUZFk2yAsjz9XAxj?=
 =?us-ascii?Q?UDviVi/QuwwLMfbbdauIv73U80y3x3levRpICC7r5Wik+jXjrwdGTzSD3LfZ?=
 =?us-ascii?Q?ld7mDueVw8H3xXNIzFywaJ99r0BwjqRhf5b9+UQI+d3l6r5oSJXvY0ae5AY2?=
 =?us-ascii?Q?QHMJEsTAFiDuh3VnYgC/YQVNO7alhz/+3WQR1YlGSZuQ13vNQ1vhKFrwpWKl?=
 =?us-ascii?Q?GiqUkT4sCd2zzI0dc3afZfvC0zE5eosseNDqwHhnjK8qTpNgpOSqVkuTuF71?=
 =?us-ascii?Q?dARPSOZuVGxH3VJ7XRDuP6lvtGC3GDy/qJqmcTmvYthUR2FNE/LIx/UclZuy?=
 =?us-ascii?Q?1pN96MNEAdWum2JS6E8F2z8rQEYuyKuWkcE66z/7QxcXh8M7bQUcU5JtI7Az?=
 =?us-ascii?Q?Kp7ZQLNPFqm/SIQbiZGVfltWWJCWvB8B2cKjtzz402H0Rx+8ONeEjIjiS7MG?=
 =?us-ascii?Q?Nmr0pVsZiGa5Se8HW3dDQSHe02BPzhhG4ArXWSzAEZ11JThOgAR0iOR8w9Us?=
 =?us-ascii?Q?YLKny20n7Irh6DUvKiKb8Vvq2qxozE2cE9VuN4HptRdNtwQHi0MnbWved0vr?=
 =?us-ascii?Q?8pID9cJe6GlmJ1l3jpMaEaB+ovnJlklUt9p/683/XBHGYJvLmu00MFaq551v?=
 =?us-ascii?Q?E15j/XpzgeGihC05XhzVK456gFYaIIATp5tmKPS4/unosg+6xQyFsbfnEBe9?=
 =?us-ascii?Q?pc7fp/cRPBOYw+QaiNJU9speA9lZgr0EeYmHpTanq/ZNzD83l6/lfGJ02HAy?=
 =?us-ascii?Q?YTG3bVvELCgemvk9IfKinrF148PUIJioBRk+nfEqzWhpiXhHIClZrLsY/qWY?=
 =?us-ascii?Q?UmDFKOcbrvGUDC3eWbkC0B+a2LyulcCiBzW/XqJkF5Ym1vZKFYfh33SbKmYE?=
 =?us-ascii?Q?jR+UpoSnDK5PPDVYrm7xxcqTieHgksLJge3i4gSUFV3c+hiX3kD1YLkzlL4h?=
 =?us-ascii?Q?dUT7JZxaRxHHEDCpkzBL9aayLqL81EYh0G9PEfZZNXzA4oXRexzz/kSTT7hl?=
 =?us-ascii?Q?JKoRXM4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kcXLmd8CCLztXG71bHqb/iDBYH0MTbnNv8z3SdAC8zHjwko7QaPCFtFT5Pxm?=
 =?us-ascii?Q?3+qVHkPOHRpNQH6b5Ygv92J3lHMCSGjU3FQK7Fsm7pzzZDqs21NuJxCVdXFa?=
 =?us-ascii?Q?p3C86z9ZSBK7Z7upwv/UBqOgtnClMBXH9HexpUaLNqtCDTiHdrOrqQd/1guH?=
 =?us-ascii?Q?AsmfASLXwceyk8xGdL6nDedH/3ffFfrf58vdjTV+AjMEGhh+1DJrrNxPA5sl?=
 =?us-ascii?Q?rXQ4FutTUr/xxEBGC5lCvRsFPLQDqBnIGBQiGTcepG3oR7OWOSTv9+OpKNgz?=
 =?us-ascii?Q?pmrssEHuDY5TFQ1VLpK2fgTDaVJxkbqR0SxnNgtxazOgzqs0gBE9GjBhaeQR?=
 =?us-ascii?Q?uBXkiec0jmpAm9z+LKMJs/YX0DubIGsgQpaKjLCY+Atsji0dUATjgCjVZwHx?=
 =?us-ascii?Q?+PU9Vnr8TgyN4WOSfV5KP43Hf5R/yZaH5WoAMK2geXWd3/PEu7b5wXCWEsOI?=
 =?us-ascii?Q?qn1h3V/RjAJFszLwQDN8JrRUV9Fi2/rUSXED28ToJll9OmZ8exFijMTVXWUW?=
 =?us-ascii?Q?7ai2zoOVyL4L/GfuNfZ4+g4bdL1idwICnlM8EiR6MBlwt8SkMOqI9I2FzRix?=
 =?us-ascii?Q?Xid7sBFVnTDdQ3sbyG+at6DRIAzQgcVJxyxpdd7RnVxqz6T/huuvvKpI0FvN?=
 =?us-ascii?Q?25sJEwo0t3JsFM55y/HuHiO+QnEhlOQu2ZckS4OMHIl7ZBRcOqQxloFxbx81?=
 =?us-ascii?Q?jR+7YkNgNmEQJB4n4AcvhUnDOHlA/au0w99dXTVb3rCiGloUP0WVnf9MuhO2?=
 =?us-ascii?Q?vixsU7cseHI4kLk8zzDxubIOd5+lokATv/Zu3X8PFGxRQ8CYa3RrArxUmNbZ?=
 =?us-ascii?Q?Okddndn7Y5dLWbPZhYw/TU9yKOkPqoAoN9BC7grrhp7YY5oNB8okAjMnDn6D?=
 =?us-ascii?Q?BtUDQ9FI+K3hXK7Pve9mOT76ysElspkK85hVyGljJuLTqhGa9fnt7bqzoQI0?=
 =?us-ascii?Q?5ARsKh5ZHMKJlMSyBScrvsdXzl40JaeahWxRmAhX6L0rE+mnGBjx7cr7T6Gy?=
 =?us-ascii?Q?Fhjiav35ab9tQ/HQvCtER2JwnR6ORtBcxMqKFA280UrmkoV27HqmUh8e6Cdv?=
 =?us-ascii?Q?frPqd/UyMVM5xK/hJxhl0vC+l2psrZ1JNT50OEOcCw145YeVCamD9wUVY7J5?=
 =?us-ascii?Q?OKaZstgkoH+8ad1BxhWtOqSzpQR48rCH7Vh01scIo32CnLxVqsw/kLAmtg3m?=
 =?us-ascii?Q?ky4AJ72v9tmfedHREKrc6Nq6gsTG3fePdJ25/GrXJGZgY6pDcm8gf/GoyWe4?=
 =?us-ascii?Q?Sucr+LTQDU7c/uA2B+GXNWvusjVFALrtyjU3Ehj96UEMC3FSeY2xl5W7CKHr?=
 =?us-ascii?Q?mYm1U4QsynirmOlb9ckzwvodVxY+FNKOEbutsE0gSvOYwtymjSizyxSv5qp9?=
 =?us-ascii?Q?rOEv05p9BXw9PWOICRLzz4Py+kbbIvHiMbgjuNUn/U7dqbGphUA1QP5nkZ9I?=
 =?us-ascii?Q?6sb3/guqscSJ1RpJHlv/jBz8RJ5ZXvMuFSDogXu1Y97eUYxeZcJR6P7/44Hf?=
 =?us-ascii?Q?dM9dREdaINfx27kDxOTtnK/Zo8M0SaUNE+DIEOCR4Eriq6IPr2ZLTBc7SyS0?=
 =?us-ascii?Q?q5k+wohc4Epy12gcYH05HVbEqaNpTwPRqk5E6kjj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e61ac7-bdde-4ff0-a1a6-08dc91bc9f10
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 06:37:28.8268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rNkb42VAICHqXoUcrkOiyVKcoqHAQV4M/bhF3JKEf+x7ciC80VMdKJXvOHWRCgNEh0pDfbwoTctu64U2tyJiTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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

Shall we make pre_de_queried_count to be local variable? Others look good t=
o me

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, June 20, 2024 13:40
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH V2 1/4] drm/amdgpu: add variable to record the deferred err=
or number read by driver

Add variable to record the deferred error number read by driver.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 62 ++++++++++++++++++-------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 +-  drivers/gpu/drm/amd/amdgpu/u=
mc_v12_0.c  |  4 +-
 3 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 86cb97d2155b..f674e34037b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -120,7 +120,7 @@ const char *get_ras_block_str(struct ras_common_if *ras=
_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)

-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  100  //ms
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  300  //ms

 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms

@@ -2804,7 +2804,8 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_lo=
g_info *ecc_log)
        memset(&ecc_log->ecc_key, 0xad, sizeof(ecc_log->ecc_key));

        INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-       ecc_log->de_updated =3D false;
+       ecc_log->de_queried_count =3D 0;
+       ecc_log->prev_de_queried_count =3D 0;
 }

 static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log) @@ -=
2823,7 +2824,8 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_in=
fo *ecc_log)
        mutex_unlock(&ecc_log->lock);

        mutex_destroy(&ecc_log->lock);
-       ecc_log->de_updated =3D false;
+       ecc_log->de_queried_count =3D 0;
+       ecc_log->prev_de_queried_count =3D 0;
 }
 #endif

@@ -2856,40 +2858,64 @@ static void amdgpu_ras_do_page_retirement(struct wo=
rk_struct *work)
        mutex_unlock(&con->umc_ecc_log.lock);
 }

-static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
-                               uint32_t timeout_ms)
+static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
+                               uint32_t poison_creation_count)
 {
        int ret =3D 0;
        struct ras_ecc_log_info *ecc_log;
        struct ras_query_if info;
-       uint32_t timeout =3D timeout_ms;
+       uint32_t timeout =3D 0;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
+       uint64_t de_queried_count;
+       uint32_t new_detect_count, total_detect_count;
+       uint32_t need_query_count =3D poison_creation_count;
+       bool query_data_timeout =3D false;

        memset(&info, 0, sizeof(info));
        info.head.block =3D AMDGPU_RAS_BLOCK__UMC;

        ecc_log =3D &ras->umc_ecc_log;
-       ecc_log->de_updated =3D false;
+       total_detect_count =3D 0;
        do {
                ret =3D amdgpu_ras_query_error_status(adev, &info);
-               if (ret) {
-                       dev_err(adev->dev, "Failed to query ras error! ret:=
%d\n", ret);
-                       return;
+               if (ret)
+                       return ret;
+
+               de_queried_count =3D ecc_log->de_queried_count;
+               if (de_queried_count > ecc_log->prev_de_queried_count) {
+                       new_detect_count =3D de_queried_count - ecc_log->pr=
ev_de_queried_count;
+                       ecc_log->prev_de_queried_count =3D de_queried_count=
;
+                       timeout =3D 0;
+               } else {
+                       new_detect_count =3D 0;
                }

-               if (timeout && !ecc_log->de_updated) {
-                       msleep(1);
-                       timeout--;
+               if (new_detect_count) {
+                       total_detect_count +=3D new_detect_count;
+               } else {
+                       if (!timeout && need_query_count)
+                               timeout =3D MAX_UMC_POISON_POLLING_TIME_ASY=
NC;
+
+                       if (timeout) {
+                               if (!--timeout) {
+                                       query_data_timeout =3D true;
+                                       break;
+                               }
+                               msleep(1);
+                       }
                }
-       } while (timeout && !ecc_log->de_updated);
+       } while (total_detect_count < need_query_count);

-       if (timeout_ms && !timeout) {
-               dev_warn(adev->dev, "Can't find deferred error\n");
-               return;
+       if (query_data_timeout) {
+               dev_warn(adev->dev, "Can't find deferred error! count: %u\n=
",
+                       (need_query_count - total_detect_count));
+               return -ENOENT;
        }

-       if (!ret)
+       if (total_detect_count)
                schedule_delayed_work(&ras->page_retirement_dwork, 0);
+
+       return 0;
 }

 static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *ade=
v, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ras.h
index 83437fef9df5..748bbac666e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -469,7 +469,8 @@ struct ras_ecc_log_info {
        struct mutex lock;
        siphash_key_t ecc_key;
        struct radix_tree_root de_page_tree;
-       bool    de_updated;
+       uint64_t        de_queried_count;
+       uint64_t        prev_de_queried_count;
 };

 struct amdgpu_ras {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 6d6350f220b0..0faa21d8a7b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -557,7 +557,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_de=
vice *adev,
        ret =3D amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tre=
e, ecc_err);
        if (ret) {
                if (ret =3D=3D -EEXIST)
-                       con->umc_ecc_log.de_updated =3D true;
+                       con->umc_ecc_log.de_queried_count++;
                else
                        dev_err(adev->dev, "Fail to log ecc error! ret:%d\n=
", ret);

@@ -566,7 +566,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_de=
vice *adev,
                return ret;
        }

-       con->umc_ecc_log.de_updated =3D true;
+       con->umc_ecc_log.de_queried_count++;

        return 0;
 }
--
2.34.1

