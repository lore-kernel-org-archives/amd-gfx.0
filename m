Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61145C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 03:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F16112030;
	Thu, 25 Apr 2024 03:19:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wZsZsR1N";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3EEF112310
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 03:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9zXtMtpXnbC8LEhUiUw6gDpdfuoeDhP/RNTvVZjyEEBa+eib/bpFAFxrgSm72qZWdvDDvyTfI3d4HI5oynYrPvCJCK4Lvk66Y4avCa9Xqj3VLkfeGkClAIMMtCYwtIuJ9AKtzXbVv00ZcvwCd82Fg8EM8EGXuN7Ps+Ke+bcz6PnIG0GL2ahIb9/x8O7VJ+PZ9upch68oA2PMaIXmqaJWOF6YnMtvNe06uerq0sFCevvM5SvRUoHJSU2rwkwagZrltfgq71btqvwp6VYQJC4oPi9vKvEDBtWlYnZEa3F4y5pDYatj36/N0Trk0Me9SbmRUyVcVDgsmBr4/mJfAilkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB9Ov9AMVHDS8QiOjFMiITbIYxuxyU1VsIFdRjYddP4=;
 b=ocI0M6EdCj636VLgZfhQRUZmn8FmTHi9ZyR1Eh3Xj4JA7xwoAQbMJoG4nInt1ra4y7+ilEP4sqHFNhmPcg/hXa+ANyfZidOjYbN837hTaD3z/SzXCfCX7vxer0vDWBx+vMbyHfetU2khgYZDGIN+JBRUNpIhNSbEXjty6yi2NWjgX1dLO4XBgZh32Y0uMsewhmaB1RgRfURzaxFCsrb0Sk9c5Zy3gK/iY8RobHjUakFUjFSrvpq9NsjkpvognkMbCVT4CzRZvsI7rYOplEtV6qwdRQt9HpdHVTxIuh3wQJ4Ds94KvZscqcJ3aQqKVsyXYiCjAyW64AlXyt0bz/zKnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB9Ov9AMVHDS8QiOjFMiITbIYxuxyU1VsIFdRjYddP4=;
 b=wZsZsR1Nt/IRyhv4os6qwqKv3ZyM/oyiiWMdq913OIJYD5pvK6u4eDBxRIvPSytLMKv5pWn/VBpOnXDZJ5GcztBjLL8GbZBwODTd54daWIOqofC7HbDBcXt+KiRGSsH7Z6swNE6rggDaqUVugokSZgKjKunriPJsO6/Gc+uMgJ8=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 03:19:44 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 03:19:44 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: Fix ras mode2 reset failure in ras aca mode
Thread-Topic: [PATCH V2] drm/amdgpu: Fix ras mode2 reset failure in ras aca
 mode
Thread-Index: AQHalgulEmih4xyL5kGiJ1DLJvQrorF4SUMAgAAEdUA=
Date: Thu, 25 Apr 2024 03:19:44 +0000
Message-ID: <PH7PR12MB59978D29C2B9EFC42B3E018382172@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240424055228.904041-1-YiPeng.Chai@amd.com>
 <BN9PR12MB525739408DE080422FEF4DD4FC172@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525739408DE080422FEF4DD4FC172@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=320f36b6-4617-43d3-b1b7-9f48d7279a89;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-25T02:40:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH8PR12MB6842:EE_
x-ms-office365-filtering-correlation-id: a2c9091a-a2e5-4508-dfca-08dc64d68d9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?16zGFyeA7lRjm/IcZnaOwjHN7PP8eY7Iouso2wrhjEvBOhJoxEYWM37fcSFN?=
 =?us-ascii?Q?NY/lcyuyp3RPu4PSZfBLKHJ2cCsBTLxrU6FN4k1AzG3dPNvv2wp0+A5ZBG7o?=
 =?us-ascii?Q?/PmixikujY2WyUcXM+R1rzuM/ZGv1iAidSdpR2DizYnxLQZhXfQ15mvKuYN2?=
 =?us-ascii?Q?lcrNbe50KNKM0RUg3AyeB/wxE1HFx0qD7j5N4mq4XA8MEDIRbYZD2vgrfS2m?=
 =?us-ascii?Q?lbUGucNCC9bNIjKnwomPFJl9gJMPARyzmYHP/R8KCZgyYQHkWo65PhQyRddA?=
 =?us-ascii?Q?drX/myzhck7fQzP4Fcny9JxSV1J1WITGeI11CixVr6vIAj76aF0AH1vY5BU/?=
 =?us-ascii?Q?uKkv3kws67hRvzo6haynFMILRj6LSxmZkEG05bwvYiVwuymSnAZm+OHxA+kG?=
 =?us-ascii?Q?3Bk43XDzsO9KOxjQxAr0EPbSMBem6B3hvKRZw6BfpwEcdIgPHtzbVlOtQlGk?=
 =?us-ascii?Q?6xYmGr9KCYUje8ziY4ucSDVE8Q1JBH3RsXhxSN4LPX78ECfRwdrofaqnxpLz?=
 =?us-ascii?Q?pHRW4unUddJA4MIcj2HGBy2bc/Q16NU32JqPF0yh3cM+3ocovz79nI+vY0Y/?=
 =?us-ascii?Q?Ugv3sDMxioLI1FYYORZKpqF7PZB6N8Eq5l4sUCG98wV4aeeHqcJqPa3dTu9o?=
 =?us-ascii?Q?EImaXhVTOgVTisfG5Lors9fVvBTohjV11OEaHrcvfS8MD9cV4B/r79DkYlY7?=
 =?us-ascii?Q?/qBw3GlhXT7AdXhW9S9WYw43mFHFAuN8H7Qm13Rdty7VfWTPCfPKWzO405qs?=
 =?us-ascii?Q?/PN57xa7YFIsX71QUzZ4u6CQQOlMKAPTpUc5zv9fcXqLt2fUdpxqG6k324fB?=
 =?us-ascii?Q?hruoX1tmkvgLyaRdNCRqeTegcBBsxdUYMTkgq8+5Tu9rAee0DzGZMKDv9wqb?=
 =?us-ascii?Q?S01zRYIpPoYNhBn0pHcGGtHmLR9auBNBhxDVHGMH698ijjzy+S8SKBlcHO9I?=
 =?us-ascii?Q?oFoCDwIk/49KkFasE6nHGmBVqGDgVKA1CPMD+vHhqnvjSQo7DJ9mKUz7UgUl?=
 =?us-ascii?Q?5MM3ONYYxs+8+5LdWoYLNhgewkTpofV1sO8kDmVvqdA6P39f1P2m/wlExZw5?=
 =?us-ascii?Q?6syHDtf+l8q4Vd1JXISBvVGpM+OsvrO0UfhKrikzktQfyKPL/h3EOFQeuMUJ?=
 =?us-ascii?Q?W90shi14QgSqXLa6PDLngPZFZTQEtYKfJIjc9+2ozj4KdVpv6sGmAK6kVkNe?=
 =?us-ascii?Q?ZzXLeDEBzYRJUhOFWXwqsdBxDXY/ElQ7tIGkyHIX89SrTh8xa+N4F0U8/gNh?=
 =?us-ascii?Q?9kX1WJH3yIOG6m726PIsZsHNRHO/+KLiPd8aHk3Ev6wMXGLqy7vj8Pfz9LJ8?=
 =?us-ascii?Q?CxM9+zDVw0gbyx3XvlXTgE/334Xwcky9eAn2ygl398z+wA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UELJeJXJJ1zq0fBygSkZ1afNox6Wje2clmr/N4Ke0v1VaKWEUGDC85fUHscv?=
 =?us-ascii?Q?u9B/WjmTGROI20fd61dYWghCXjhjRhbntbMTntI0y7Zrs3HCxn6TLn2G3bvT?=
 =?us-ascii?Q?J9oXsLSjoUnut8r7xB4FbjaIot/XavtRG46Zi4PPgLG9xvB7yzZiNUlc4qFi?=
 =?us-ascii?Q?5odXpv+zP+aEZhr6rlPMV1R6wGjGIuUhI+G4XMdRM/XwI/abpj1gPcgch2kp?=
 =?us-ascii?Q?0MEEccU7q7afzNpzWiqrM9pyryQyh+YrBnz+4gbMitOSd7biXV0ibP6EPq4G?=
 =?us-ascii?Q?SnL+1BiqM04J00sh+b2WBupfncJbvMDtGP/qzFCjdZQWDOCkr0i1IE9tkxxM?=
 =?us-ascii?Q?n2YR2CXFkywznmXCuIjR5btglQ0TTexihFctLdcwVBppTGjoYWWr36OjOeeb?=
 =?us-ascii?Q?TFVz9koQuhH9jhXlNxkUnBiIgj17CXANWoZ5l1IqRFSEwqq68tqdxwJDeRPr?=
 =?us-ascii?Q?5z3csZqGLmY//Vl+w0iumaaWY5ckd2AVJQqHws2LOBF/piU/s2bUBYuOrcvq?=
 =?us-ascii?Q?cGOM991vluKcNRhSYZo4zccqbF3dDPueJEo/1mTFGq0AAGTIId4dTkvHj2f8?=
 =?us-ascii?Q?f1r8GHW5hZgIDU1Q/Anzu0/8VNz64FC+97lI5iHIuNc+4WuJAPqlMG4suI1w?=
 =?us-ascii?Q?yiPslVAVM7G7Rg9mQbB1KNJf2j8a8Z11kvVPC39ZhF08Q6TR7DZ4Tfhun1JI?=
 =?us-ascii?Q?PJN7US2PYG7Njba+edZBnaFP5p4ja5YSB3L+RB/x8Z77f5gxxDLk5DrmDkvf?=
 =?us-ascii?Q?adAkuPFfZumShxm4NRM0PuHeW61eAWuMjp6C6Ll6g7a06T/B47w3dd6upk7z?=
 =?us-ascii?Q?D9UlD0NREUEHvlksOp3Xfpr/3yNZXNW7/NY+aiUntlbm6JQMaOmfiYHjD9wN?=
 =?us-ascii?Q?nVIRTjJatp1FZWO2HK4qwTQEQLJRP0JTWLsZ3T0HPa+mjWDeHPoZnTRXdzzf?=
 =?us-ascii?Q?7kPkH+JzxP8GhYYjAyx6oVud1GhvOJ+r8T5TTL7FLV4JpA6YzoOqOJVW3l1d?=
 =?us-ascii?Q?DS4tVHDYJA6rimU8o7rllPyGp1kAVJZuSAjqaq+//+NMpultMmEtikkUFnMD?=
 =?us-ascii?Q?tE8r+kIb+X9lEQwcYEzhKSvLRoAZlgYUZmZcd6cAicWIdk8YRAp74zMzS8ek?=
 =?us-ascii?Q?HkAPfvtdpQJlgabR9432kQ3M7ruwPDeI6WeQCzsiUPM1/80szVfb7l1zGNIT?=
 =?us-ascii?Q?HqKQfIX1OJ51P2b7nWBtQ7uCtN4fHQlxLKXxuoTSX1c/3noUsaqSWukyJ8CQ?=
 =?us-ascii?Q?Nw1CAPmqWIPqKnA+LL+wC/XtIHYiCRdG1u9B2mNycKdgdrUjF69Hd9ZZTYN0?=
 =?us-ascii?Q?+4hNH2oGCs3VbQ+6yTK99kmuOjaR3cK+kIbFwriL1HnzcvqGwN9Xtkc0lv1O?=
 =?us-ascii?Q?D6x353W5PBPtSIz1t0KfPLQ/Ry54sGMyPWYqENDx+vznbuscqy2b1QC5qapk?=
 =?us-ascii?Q?Lv6MPEjRDiEs6Vw4MuYJYUdAtJ31DPAVFaLvvx4jhMx4gL5+9DqaxD0gkI4a?=
 =?us-ascii?Q?778X/q5ej0IJ+iv7cEGy+RwbD698RV9qJgGwmw+HUepYTo/y9Cm7eJebUysf?=
 =?us-ascii?Q?F1VN9lAwS5U5YkVUzVM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c9091a-a2e5-4508-dfca-08dc64d68d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 03:19:44.1351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JBU0xzDKh9urAGziS0gNj9bXznrr22f9xMc5NT1KN5mC5wIWDbd4JczmGR1S2EQy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842
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

>> Alternatively, we need to explore the opportunity to centralize legacy r=
as and aca ras implementation in the same API. Take sysfs create/remove int=
erface for example, legacy RAS and ACA RAS do share the same logic, just ha=
ve different filesystem node.
>> For now, ACA RAS is trending to back to IP specific ras late init. Let's=
 revisit the code to see if we can re-use the common ras_late_init or creat=
e aca_ras_late_init api.

Sure, thanks.
We will make improvements in this direction.

Best Regards,
Kevin

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Thursday, April 25, 2024 10:46 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,=
 Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: Fix ras mode2 reset failure in ras aca =
mode

[AMD Official Use Only - General]

The patch is Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Kevin, Thomas,

Alternatively, we need to explore the opportunity to centralize legacy ras =
and aca ras implementation in the same API. Take sysfs create/remove interf=
ace for example, legacy RAS and ACA RAS do share the same logic, just have =
different filesystem node.

For now, ACA RAS is trending to back to IP specific ras late init. Let's re=
visit the code to see if we can re-use the common ras_late_init or create a=
ca_ras_late_init api.

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Wednesday, April 24, 2024 13:52
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH V2] drm/amdgpu: Fix ras mode2 reset failure in ras aca mode

Fix ras mode2 reset failure in ras aca mode.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index edb3cd0cef96..11a70991152c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1254,6 +1254,10 @@ int amdgpu_ras_bind_aca(struct amdgpu_device *adev, =
enum amdgpu_ras_block blk,  {
        struct ras_manager *obj;

+       /* in resume phase, no need to create aca fs node */
+       if (adev->in_suspend || amdgpu_in_reset(adev))
+               return 0;
+
        obj =3D get_ras_manager(adev, blk);
        if (!obj)
                return -EINVAL;
--
2.34.1


