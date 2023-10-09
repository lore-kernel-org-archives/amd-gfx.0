Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F60E95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 08:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31CA810E232;
	Mon,  9 Oct 2023 08:58:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECACD10E232
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 08:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1TXwTK3PsoXSTVj0Lix4RPXEsFDgawy7FB7XDzrM9bPKzQnNLebS4zgJVMIY6cfZHw+R17htUnAaNsFI8lQxe3XWVFzEEQnvwF08ZuJlzn1TtUGsOrFVRQ8oA8Wt2TeaXt4oM9bstYtikjBS13Nr2E8/SO823c5lOdRzuUvzOHFaqHZaeYf9ey+VV0bFUBe0QPKoXcZLaCgzMPQi5chE62A03BmQ2gBWtC8oTUGBJATfvw3w5AG/ySIZZJURhYsl8ZZVYqtiWN9oSrUTHfFJbwLy0qXP/hTgbOAKVWlOyHyEth6+LQxKwcKLp4/kSLnJmPILU4kU0VC2YyfUbUapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAEd/YIUSKpV3EgH0cjfjUAKw03hNyKTw5d+S5CGRGo=;
 b=GdiRQzBZI9HVWmvTzoum0E3gTMf6BU968xXMZsrx+vlvJeAwVfTY24rJTjmm+UZLej0FJqz0hGkxTsaPBveL+0WAXZ0P0xCyKDxmLSqQ/GkMm6JvimYKVNOka1u3X08Vy7uEfZ9k26BqwL1xPQyO2eIGlIR4m8XV657zUFU6oJFAShiXyM9CRwAAwwpej2uxeEE1rqJQJvuPTGr0A1FWenMKCQD0bVWX2/WNqk9VpZJFvlzvcppo4+zLAMu8us0QqQJ6yU3gTH+Zlkqdp2PA+YZrX0UAQl2g8XTHRCrKGKaMyYc+HcnENpDucEPdvEYjCcwlj+l2D+a6Yikq7vMAPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAEd/YIUSKpV3EgH0cjfjUAKw03hNyKTw5d+S5CGRGo=;
 b=pXVnmcLkL6bVwLrD4UAAaXV+zj4oCYGzkystUCLFJtIXu5ZiIR/24dvO3twPOtQ8+xR/4nI7VtIrKIdJXatOiLJokTkHUk5oJOfajXDp1y44soRX2Vgm/cPEdgwNa+EXYf6jCpaAtXgLLgHUS08ouu5t8Y8lLLTDzBHCz+ShFqA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 08:58:16 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 08:58:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Thread-Topic: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Thread-Index: AQHZ+c8q/uDpjlF9vUmY9VHFW+9cdLA/5QOAgADNXQCAAHVP0A==
Date: Mon, 9 Oct 2023 08:58:15 +0000
Message-ID: <BN9PR12MB5257442EEE0BB34C24F1A8F9FCCEA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231008100642.1915677-1-Feifei.Xu@amd.com>
 <PH7PR12MB59972CEAF0241F48E6B342CE82CFA@PH7PR12MB5997.namprd12.prod.outlook.com>
 <CH2PR12MB4152A458EC29B83672A600FCFECEA@CH2PR12MB4152.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4152A458EC29B83672A600FCFECEA@CH2PR12MB4152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c646e2ba-d647-4c22-85a9-510e3ea61461;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-09T01:40:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CYYPR12MB9016:EE_
x-ms-office365-filtering-correlation-id: f250a61e-b00e-425b-2d19-08dbc8a5dfad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U1uiv1nkt5nNXz61PAX92k0zxxmSULFwm0TpgGLWEvjQqAe5Q0/QMHNqGrF9rlM/ZCRn7I12NAPGAxdOUAGppRSAV3a7g/1EDmj+O1qmcvEsRbzeIPQwjJN5QxY24MkmujJc++xRT4GMVVOMVwguV54hS5BE9f4PmiK62K99i4aowgrOKR54Gwqf3QeXVSjFtmIZKReBcJjSyFsSDb0kM7zRF57MSgDq3zGoLoj75gUfhyb7606jDc9ajfv+2z3oyc3HKoYkRKKUCi7VcSexJwMmXwlJ7oZZmTc0UcCHfAI5KrbAdGBCKQNMWxPvli1sPU27xcl8gAxWErLHsp35PMhkDDCkOazFfLMe+Cd4vOA04C7eWn5//nUtuLdeoXjixtP4eNvd23hWK/cb4Le64ZLSxxOnzAh8iVf4JgJs10HlVOvYiW2P4TSnUNdGVidgNeMBObmkVxLzeLh1Th/qh2jCO6g8FJh3e9Lh8/+d5tYknhLsqgT3VOVyrTR9P/k8JsUBCumEL2e47indQLOR7cvPuN3CnBxv9RPIKAFGTW8w7wgLzGgMs9IafaHVFei+t4u36N0fN+44f+MVM6VzJAKUT0nHci5F0Q4AsMuXYyqp7N4MnCkYophpVFpSl49l
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(122000001)(38100700002)(38070700005)(86362001)(33656002)(55016003)(2906002)(9686003)(478600001)(41300700001)(52536014)(8936002)(5660300002)(4326008)(8676002)(7696005)(71200400001)(53546011)(6506007)(83380400001)(66556008)(66476007)(316002)(64756008)(76116006)(66446008)(110136005)(66946007)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RwlS8bmOPhJWg3uCAlXFQF8FioSY+poQkRL9XC5UXaORGwq354cGplJXvFvD?=
 =?us-ascii?Q?6/AGqtLj+C59LTziJoHTLV9+ARkBpA1pdWF6NGbrvmvcEURpgOMpHj6Nga+9?=
 =?us-ascii?Q?8VdyLLjZnFjIIaMY9NMIo8RG1N0zJSfOpz5+t4PT+8upCCQ4fY2gEITIVcZJ?=
 =?us-ascii?Q?wwdKEyAkoDOUx7BDGEgKuY1/+ze70EZJ/ntnrap5J09x8+rWyV4ctMHNVKiO?=
 =?us-ascii?Q?w5I4AbNO1B2SbBrZplNPbEYkZEjmDifm+Y/nb7gaky1KVnrWYxco3Y3hH2+x?=
 =?us-ascii?Q?stzS96DtjVvssZwff+x0SEhD69tEWnU9sZYrYCNs/j3HJoq12ysmxoE8q1U/?=
 =?us-ascii?Q?o6hJSl24zorLXJx+F8M4LihWvwy9i0laySInd81ldhWeckFj+j24GdcDbyVz?=
 =?us-ascii?Q?MrOl4gCUJi8qz3H5oVtuQIfRPQ0+/1Hn+rynA7Rb0ZYQPsYKgO/Ofxe7zwW2?=
 =?us-ascii?Q?g5gabGlKdmsBSpHcK5HX3DUdo+z84REKq5fyNm0kMKRSRJejosimj1JuTL+F?=
 =?us-ascii?Q?yVz8tcejQe5kr1AsRdIuEO/N4P6RU+1eUpuG3rHK4nzR9QQmYxAb5ePhCmka?=
 =?us-ascii?Q?RRGNZefSRZjIIYswoOj5AY0+KTDYKtJEds8LR5vGXUoIm5lckSKxE7J7futW?=
 =?us-ascii?Q?OgpNpl7PrNqsJn4sJkxRIDe2WjSCIOUfhBfb83Uz0HEZ0uiZl7aD4uPPPQ7B?=
 =?us-ascii?Q?bmEoWVX97nU8wdstnrH+IeiIh7XlkhcrLw+2UxTvJ+rksVnPPofdhQDYpAmQ?=
 =?us-ascii?Q?/yY6QIgX/1FNv5B26far0c/5l0js0ZnRJ6JMa3LXP/RSrbW4z/LElnk4Goj7?=
 =?us-ascii?Q?oZ/bPtwRY+Xwy/OStSBOvqcCWcVGJChCfpdRrTUjBUfyU81kLoQtMrxeGGLY?=
 =?us-ascii?Q?AKn1PoJXutNtGtV6SIEdncsFY5OuRw0D/UujIDQnctMzqeDgRK6qPuGCPnjk?=
 =?us-ascii?Q?0C7ImS6r1sO8poCvRJVjbSxnt3sa3lsj4n1CzNU1H80uDYmdzFvmt+Ap8oS3?=
 =?us-ascii?Q?dp9YyrkWpJh2m66G+FQ3O/hQ/oe/AnBwu5xt/C/8IiOX/9Vd0qoDSLFpqpm+?=
 =?us-ascii?Q?txvqyCw7/zRi6+bkVh2beGFB4Mo2yQH/T82qMfeVKPEiaIBDEDHDDQqCTTBp?=
 =?us-ascii?Q?cI8dZgHrGzrbb0bAfAysCgRKtMXshfWgdjFMgfcMpoOEGWYwTn3Fbor04OdF?=
 =?us-ascii?Q?PPVaX1oVM9QCRA4oPCiU6z/nTkAXbM0hKcPgO84vd31rycX5Qhh9Hg9h+iC8?=
 =?us-ascii?Q?DNP+cwdFtpMpQF82Y7p2HuiPMFCHrrWLLEoks6Np4U1JPPoSNUTGkJlOHDy9?=
 =?us-ascii?Q?RNB5FaxAUTMHH7w82u4Q9adGYgubycYL2CsORahlVEmARLw6koQzGobz29nM?=
 =?us-ascii?Q?2qgrjpvxHC2PCTWqJDfe3vD7fpu1opt3bZbVQw1XN3ZO5mVOhSUURUEcfQlv?=
 =?us-ascii?Q?l9pqfyfpXk8sKD2lHRqYZJeLu8byQno1ZE1fX8BS1RyRtTa6zh1+rk3Gc9bD?=
 =?us-ascii?Q?SU1rV2v1I15lQCkVwZHu5E005KKjbAyijuTBk8lgdkuQvUqm73ejCYXzjUVD?=
 =?us-ascii?Q?2fQTPI4wiXd9k3fo3Ww=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f250a61e-b00e-425b-2d19-08dbc8a5dfad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 08:58:15.0488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnRjRWTKovUcDT2/OxAO5Y/lFErQXFYafs3/4ypClE1VE0zadQ0RuXmbKIdRnY4XY2aDRiv5VTgzo3rX7FlxNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

adev->gfx.is_poweron check should already be applied in IP specific (gmc v1=
1) callback. If gfx is not power on, it does nothing but just returns. I di=
dn't see how it helps resolve the issue if we just move the check from one =
function to another.

Regards,
Hawking

-----Original Message-----
From: Xu, Feifei <Feifei.Xu@amd.com>
Sent: Monday, October 9, 2023 09:51
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb

[AMD Official Use Only - General]

Hi,

>> Based on your description, the above code should use "||" instead of
>> "&&",
&& is to add more restriction here.  To avoid skipping necessary TLB flush =
by return.
For Asics < GFX11, !adev->gfx.is_poweron is always true (this paremeter is =
intrudoced from GFX11), only depends on reset_domain->sem; For Asics =3D GF=
X11, !adev->gfx.is_poweron might be false (which gfx might already poweron =
in the reset), this will make the if () not ture, return will not be execut=
ed, thus flush TLB.

>> And after merging code into one line may result in the lock not being re=
leased if the lock can be acquired success.
If !adev->gfx.is_poweron is true, the reset_domin->sem will not be down_rea=
d_trylock, thus could avoid this deadlock.

Thanks,
Feifei

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Sunday, October 8, 2023 9:36 PM
To: Xu, Feifei <Feifei.Xu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Koenig,=
 Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.co=
m>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Feifei X=
u
Sent: Sunday, October 8, 2023 6:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Koenig,=
 Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.co=
m>
Subject: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb

To fix the gpu recovery failed on GFX11 with gfxhub pagefault, flush gpu tl=
b after reset on GFX11.
Gfxhub tlb flush need check if adev->gfx.is_poweron set.

Fixes: d0c860f33553 ("drm/amdgpu: rework lock handling for flush_tlb v2")

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 2f9bb86edd71..048d32edee88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -611,8 +611,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *ade=
v, uint32_t vmid,
                /*
                 * A GPU reset should flush all TLBs anyway, so no need to =
do
                 * this while one is ongoing.
+                * For GFX11, gfxhub flush check if adev->gfx.is_poweron is=
 set.
                 */
-               if (!down_read_trylock(&adev->reset_domain->sem))
+               if (!down_read_trylock(&adev->reset_domain->sem) &&
+!adev->gfx.is_poweron)
                        return;

[Kevin]:
Based on your description, the above code should use "||" instead of "&&", =
And after merging code into one line may result in the lock not being relea=
sed if the lock can be acquired success.

Best Regards,
Kevin

                if (adev->gmc.flush_tlb_needs_extra_type_2)
--
2.34.1


