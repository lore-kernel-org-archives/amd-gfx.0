Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83166C001DF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 09:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E571310E0DF;
	Tue,  8 Aug 2023 09:50:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2669110E3A2
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 09:50:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsAwsCOKWXSx5fBoMVBkjMdhhUQbSgG+6+xHpFxV6XOj2iFogMgQi/fJKpG1u7E2Eezg1ktF2DOedUhdfNrZkTa0u/ZR6r3IO3mypnDDt8tgaZqvstinzVNl/1qzFGfl6q/+Bhjku+on2m65hg66NvEy9N64m8GT6lzHsQ9ctZIkWXBiGEmLpI1Lf1PB3HYDXymUegq9hUyBho7/MD4nJkqNcqGkHzEM+GQ4tPVt7/tMIlvF8cPOhOhjlCiFGKoGSKWbWoyX+1/uDz+PP4X5FSsO0Qs/7IrSMuWn9LJyHWAg/IsscquPEhiGllyw/+I7oUBfXvYSFeJDsKVbyXTTrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF+OgZ+hsxmjA3wXmACBAN93597DEIWDg+OuhleFJfM=;
 b=YoEMXJW0LTavMbIWilpVGVaNJlKl+vBGPw8ldyL4lNy07pYBKvhoF6nyoA8Rxx43X+DDKuW4D4VcicCA3MEkkwW/Is1q8HTSGB9M/XzyFaYYNm0VkRl3opl3TwDmV6LuezXZ1UXA8hn7uUHyK/kw/Yj4JqYa+GJ1dye/ghEWSh6+4k6t6ox3vV4tuGcrVwmMwxm8qXcaLQ1s0+rSpync1MXlDF94iqnxR+/D8Chci4SzZ/fslk8T6wWOi8BBwF3njZS+sz94khyEzqUXowP/aZxgvAqNILH6xxI8i1Y6iyeKL5ntMm0azXvHgnpBtKQaC9X1BgtScrg2DUxasq5Zgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pF+OgZ+hsxmjA3wXmACBAN93597DEIWDg+OuhleFJfM=;
 b=hXF5BlkCs5e74zXr31VHwg7U8McHBPsGw5jeOKnAoxYqO7y6FSEFVy5d16M9NqdAM0+lZg8kolarv/3ISsyU9hGRO0CLKA/OCQt7W8/zOwN4yZ8PKbyIoMt9BtP9IWV6UlOoukYeVgeY1E80ctGa942dJq88rhkNuOMZiPdVT9M=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 09:50:24 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 09:50:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: mode1 reset needs to recover mp1 for mp0
 v13_0_10
Thread-Topic: [PATCH] drm/amdgpu: mode1 reset needs to recover mp1 for mp0
 v13_0_10
Thread-Index: AQHZyc7HCuquTACvBEuIxgd2CJDRlK/gJV8w
Date: Tue, 8 Aug 2023 09:50:23 +0000
Message-ID: <BN9PR12MB5257B1064B8861ECE080C8C4FC0DA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230808080211.3857950-1-YiPeng.Chai@amd.com>
In-Reply-To: <20230808080211.3857950-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6009bbea-898d-4003-8c51-3d2f3f65b11f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-08T09:41:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5040:EE_
x-ms-office365-filtering-correlation-id: 1e267234-c4aa-4d25-54e3-08db97f4e309
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QHGhgU7lL2mmjwAbvwxTxn4djQGRiJNaRH6IfQmRE2WRBk8p3opiZ9A3PF5/249YYM/Tm93UA5E2Uu4H9c790dHlHb/opeSRxo+agSLybAOfK69s0FWzs3P71al7uD1usfhr9DnIkNXVU9gajnYhUhRdX2DLYIr/cBoYupeSZB0oH/2fjzQj59c3Ny2Kj8pn6JXcM36qdDFcgFST9lzTYLii8FIGPCbjHRJrBJwb2LCqseuBSbamZulTonhe/i+pQ5QuWaCSqB7vk3khrhNR8NjiyjBsh+NJn/UTNQWnYBEmfLqnu8FIOrvqTjktnJtVavGgYA8wwJNU0UjJajgfRSsOYH7AuBJW5SKlubBVvoD5/fH0mDu5VGbgWSvx7drEg8SQEBx9laCrrIjsijZO12KWA3F1HLZY1z2Uo1+FXU3j36/D7YrTv5jCgRwri0c8GxTjZDDZZn6VexfvMwyitikPEiwROlCVmfrXbFJaHHmS/xhXBrLxXiHAtwFaIl5IBY2Ggy4sXN6L6x3d8C3vUiKYD1u6ssUCh2KHM4/JkUscJGkuiNRsJxiyVtZy+XFR4Kx58k9sJBKTPHdJUXnm4nt95tfOS+jNO1bqj1Z0oCbKiTQnwALip2Ux04lTjDqH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199021)(186006)(1800799003)(38070700005)(8676002)(8936002)(52536014)(5660300002)(4326008)(64756008)(66446008)(41300700001)(316002)(86362001)(83380400001)(55016003)(2906002)(9686003)(71200400001)(7696005)(53546011)(6506007)(76116006)(66556008)(66946007)(66476007)(478600001)(122000001)(110136005)(38100700002)(54906003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YHwQL/sfKYu1A9+HKsITkMQlCiGvLWTdlQSCHvJXAlhM89vzdOZVaQ0ToyKC?=
 =?us-ascii?Q?kv4uenUE2WheKifDicIm8gBRwAGJ4Fb8GaDcJ7hmUqOsSVNdwkSDgYultugX?=
 =?us-ascii?Q?sYOl41FrGEXGFJUhyPlm0XTzJbENu4Y7CJWnTuLfY/26rL32iU8D9xYSZIAe?=
 =?us-ascii?Q?fRiSjU2ROu8X9oKcfTz0d0ORyEr1DucV7fYExxS91By8x69U3Tmz6biB3J6s?=
 =?us-ascii?Q?Noj3qcSPpI3K4fpew3CKbViSba+tELIuEtBnk4X1YZKO4Q1vMYavFQVla1NR?=
 =?us-ascii?Q?PLsxWleWH6rDdV23FIgrmr6dxsW3gf5HBrepgslaCD0VMny+iAR47RK600uQ?=
 =?us-ascii?Q?/4ihFyqaCYbAO5w16ySwIUHtAfJnxl2rt1SkvgkawdYxXICcTjIhs4SM6mHL?=
 =?us-ascii?Q?f/+fAcL4U39t5SoMYH8wgaKJoHiuAP0VLqIIjd8m4FipljORKmmuxiVl/RFs?=
 =?us-ascii?Q?QEffw8wRfjjLOfsU9XRvcRapqvXMIYHcZBErg4s811FBgUy1aDi5rTpe2x62?=
 =?us-ascii?Q?VwY6Y/Luu4xPTY5U/K7TENxM74DT0cIxf1CGPy/NTniTSDreEmOdXrpC1gyY?=
 =?us-ascii?Q?VydU5ZKRTLvNK2MZtZV8Kyu7pNg8yna6Q7gJSkPxkIQXRoOUoegIVLDwjNUk?=
 =?us-ascii?Q?moWXKdATtM8+ub0F3GRRu69+iZ/8afX3Zht5QB5DilOl5xGW4rVKi41GII/u?=
 =?us-ascii?Q?jf4/gMKac9TLnaYKz7CCekkraTcazvMbnbSebH7BbX8SRGSqPmqpJBisD9PA?=
 =?us-ascii?Q?VAaCbn0Gt+WX7A+gDB9sUmpe5dyVB1F78aejn+Q3SIzVDvpsqfLi9VlAioXA?=
 =?us-ascii?Q?HQddV6pkoySJf2qpVZPpD55NRSmycqWlCjBSRsqT6NATutZBjFJMp/tWAWKK?=
 =?us-ascii?Q?/XlUq8qxkxDo/qisGvj+J/6RcSa8Pk+xJqi+BuVuU8Ddbm1HqeyyqmigtLxX?=
 =?us-ascii?Q?AIjdLR4kznVhTD75O1R6KIkLRpTdvRRFyT97TCEuYh1r4ZMDbFoAm799GN58?=
 =?us-ascii?Q?kJ0Y2yG4KxQ8bCe2gbw4zawdcHoemJosuhsXfZ0XVX3EHP4dB//x5V9AMlcT?=
 =?us-ascii?Q?fCqqa92wxqxN5j0Tsk+OrG6XxYvY0zGr3tJvuHYOIOzgFqTBPVKWV2aB63Qi?=
 =?us-ascii?Q?NBAyCjRsxEO/H2dfxME3CdhLG7O/HnQ7mf+LzwzUx+9SZgCls2Vjqk6y8IWC?=
 =?us-ascii?Q?oo8XQr3H4rT/Xz7+zG3hjSZLTTxht1/iEK295/fDSX5FRP5NpRP5yk/jjloO?=
 =?us-ascii?Q?yr7P5IKuVyof6whCK9vw1pz32t0ftsQycKDglI2dqoz4f4dL9QW2SaVLfsl/?=
 =?us-ascii?Q?uJXq9HmKJVPpuvFeTp+YRsSV35C0VQN4khVNS2vTktAYj9B/6ZHl8RajUysz?=
 =?us-ascii?Q?2BseHdz8skXs/KOFk3X1Vs/nSdHoDL2p/Q9/3NVvdy6+OfmR915A46MZbYep?=
 =?us-ascii?Q?+b/TaiJMe2yvl2GNYc10A0ucTLbS5yeLYkFsBzk7R5ZoDUoxyIplw5jyS/Lo?=
 =?us-ascii?Q?Gir9yT9Twp6Zxsaf5dWXFT9EJY4w9IKeaVsqh6enxZ+quwr/1SDREGoBgg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e267234-c4aa-4d25-54e3-08db97f4e309
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 09:50:23.9320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtYm7jmnTjV31pmVbMKigR8rquOpYFM8RpUSMoVZsCmfggfcU4sJh9EcVxo17fbpq0uVmcWLLOFKfrF5kU3oBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5040
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Like other psp callback helper defined in amdgpu_psp.h, let's define a macr=
o called psp_fatal_error_recovery_quirk to wrap the psp function (psp_v13_0=
_fatal_error_recovery_quirk)

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YiPeng C=
hai
Sent: Tuesday, August 8, 2023 16:02
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Yan=
g, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li, =
Candice <Candice.Li@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: mode1 reset needs to recover mp1 for mp0 v13_0=
_10

Mode1 reset needs to recover mp1 in fatal error case for mp0 v13_0_10.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 +  drivers/gpu/drm/amd/amdgpu=
/amdgpu_ras.c |  3 +++  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 24 ++++++=
+++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index e8cbfacb5ac1..763242d702c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -127,6 +127,7 @@ struct psp_funcs
        int (*ring_destroy)(struct psp_context *psp,
                            enum psp_ring_type ring_type);
        bool (*smu_reload_quirk)(struct psp_context *psp);
+       int (*pre_mode1_reset)(struct psp_context *psp);
        int (*mode1_reset)(struct psp_context *psp);
        int (*mem_training)(struct psp_context *psp, uint32_t ops);
        uint32_t (*ring_get_wptr)(struct psp_context *psp); diff --git a/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_r=
as.c
index 50c38f75769c..f59f0cc2ab5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2066,6 +2066,9 @@ static void amdgpu_ras_do_recovery(struct work_struct=
 *work)
                        if (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MOD=
E1_RESET) {
                                ras->gpu_reset_flags &=3D ~AMDGPU_RAS_GPU_R=
ESET_MODE1_RESET;
                                set_bit(AMDGPU_NEED_FULL_RESET, &reset_cont=
ext.flags);
+
+                               if (adev->psp.funcs && adev->psp.funcs->pre=
_mode1_reset)
+                                       adev->psp.funcs->pre_mode1_reset(&a=
dev->psp);
                        }
                }

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 58db1ee631b3..65c44c7d2b12 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -691,6 +691,27 @@ static int psp_v13_0_vbflash_status(struct psp_context=
 *psp)
        return RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_115);  }

+static int psp_v13_0_pre_mode1_reset(struct psp_context *psp) {
+       struct amdgpu_device *adev =3D psp->adev;
+
+       if (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 10)) {
+               uint32_t  reg_data;
+               /* MP1 fatal error: trigger PSP dram read to unhalt PSP
+                * during MP1 triggered sync flood.
+                */
+               reg_data =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_67);
+               WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_67, reg_data + 0x10)=
;
+
+               /* delay 1000ms for the mode1 reset for fatal error
+                * to be recovered back.
+                */
+               msleep(1000);
+       }
+
+       return 0;
+}
+
 static const struct psp_funcs psp_v13_0_funcs =3D {
        .init_microcode =3D psp_v13_0_init_microcode,
        .bootloader_load_kdb =3D psp_v13_0_bootloader_load_kdb, @@ -710,7 +=
731,8 @@ static const struct psp_funcs psp_v13_0_funcs =3D {
        .load_usbc_pd_fw =3D psp_v13_0_load_usbc_pd_fw,
        .read_usbc_pd_fw =3D psp_v13_0_read_usbc_pd_fw,
        .update_spirom =3D psp_v13_0_update_spirom,
-       .vbflash_stat =3D psp_v13_0_vbflash_status
+       .vbflash_stat =3D psp_v13_0_vbflash_status,
+       .pre_mode1_reset =3D psp_v13_0_pre_mode1_reset,
 };

 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
--
2.34.1

