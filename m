Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5373C369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 008C110E4CD;
	Mon, 28 Apr 2025 13:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V0G/LzLR";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CFEC10E4CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9Loy7+T/Cjg94fZGu9R/d27aiHsKwHbnQI1BAn04ECxn4KQGnOgrCv9Dl6X9or4HmiOWulmWkQFylGtqTdNT3x6F+lGnwQlJJKyslBkIGThk09RQUVnX11eWy7HQOcztRlHvzRzkKP83Kchj3ZnLHDq55+pNlDnuM7ysGGCi5zl/8KtQxZVRneF2ZSo4voFy6gpzUJhF2/A/yCwsZPsBBmQdqflqGr5Xv4a+6il1urt3BB1Jnsh5zmEJAzlKBDCkwAYCMS+Wmw3ELAf5jIuUAwqqbyUXxvD6eaKxUCZZ8aOycG3niiLZLIkaAolXY3BNaT2LcDeg5S5K7N4qPjQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Geu0ZcX9/UTBgIPn9gSbdNzi8wvw3YCfUO7fYixc/94=;
 b=APhbvjWFj6eJwYLl/ypKfle+6g/Dq4qTEpPwvLdf5h/ko/srSGE7BiIqjJ3TMdXu/7sxNYuLekOf135P+fmseF73hJwSW3n5og/Pq0eqBeL+DsNMbyhUJcvG7Qg5xF1ZNUqyXqvXkoFhE0ANgaPMoY0kDATpiIruUUkaB2c+0mg7EtKy9LdnYxIsWFsWGZHxp9AFATnc49Tio+BwSt8ZIUGOUTkB7lXMjPeX/vFO3RlRt1BnWaAfEwrJkmiNcL8f8nDuqUvDQ1JPtXEDaZicHUx4vPKTJbD6wdXOGRIx/mzF0jIa/W56oratduGKP5+VBusGXjlqkODXBV78NLpQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Geu0ZcX9/UTBgIPn9gSbdNzi8wvw3YCfUO7fYixc/94=;
 b=V0G/LzLRQ/HPP011uCJx4Pd10FF9SjTJzhbBlbYvafy6cKy/cRJSCd4xZtlz37vPsxYqeCigsCo3Q3LMmkVE33dSSfPFQiP28iiu983V46i7rlR/Q6IIklaoCLAW6x1NMp9CAwohzNae4/Mvtpfp7GCX4tKioO+Ie671uM9nzE4=
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 28 Apr
 2025 13:02:38 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::daf7:af35:c454:4c1a]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::daf7:af35:c454:4c1a%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 13:02:38 +0000
From: "Jiang, Sonny" <Sonny.Jiang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu: Add DPG pause for VCN v5.0.1
Thread-Topic: [PATCH v2] drm/amdgpu: Add DPG pause for VCN v5.0.1
Thread-Index: AQHbtgD2pRYQxlckoUKR91DijfWIoLO5D5js
Date: Mon, 28 Apr 2025 13:02:38 +0000
Message-ID: <BL1PR12MB5126F46BC5FD130A0095A890FD812@BL1PR12MB5126.namprd12.prod.outlook.com>
References: <20250425164137.1090949-1-sonny.jiang@amd.com>
In-Reply-To: <20250425164137.1090949-1-sonny.jiang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-28T13:02:37.467Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5126:EE_|IA1PR12MB8586:EE_
x-ms-office365-filtering-correlation-id: 76e80776-f865-4900-f19f-08dd8654f3c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?O9DWqf07MMMbcSMNZzUwyODONXgtw7fZK/Z9Cm59D46wvIEi+nE6craZEqP+?=
 =?us-ascii?Q?HEzteyw9w1MSXa60BkOvMxeuPmT5zUAv39/RZsnpErjxGmkD5IJwdusu5IYV?=
 =?us-ascii?Q?B2tfxVGxySWZp1aaRi8PBb0t9VY+tWrViB4XkE5jgDP1GNAp+GoMHPELRh0R?=
 =?us-ascii?Q?v14tzqCxE/7PKxBTH5Q3FFo5OZgS/XgVM7fXYZ+zIRvvTvf5iZmvV6kIZiMC?=
 =?us-ascii?Q?hlhm5Gg2fBF7YdWq71YUpLDdjoA9W9XP489H6iD3LTGrmdePuC4jI1ZMrKFU?=
 =?us-ascii?Q?rUIhKQ+dAkNn0Xdx+uylR9mjhzUWl0AzSgTStcV4jGuFLXz1dfAlP0i4JJxm?=
 =?us-ascii?Q?hjGp3wZ5PSQpd4sDbZn0laMadQt4BbaCRuLP6ik9Ez0ZznlqrrVgE6aD67ef?=
 =?us-ascii?Q?zQzt1Lr1EaUzB69jqjIEci84EK8RbSz0ZPcRmtjqqBG546iSPqqxu9x0XOow?=
 =?us-ascii?Q?rXq5HSHhGLoNmiw3Ikxd0AoqHEtrr1tmfBoblSXvEHYKbuWhvAci92zFMcAD?=
 =?us-ascii?Q?5nqK8USxsiC6ZLKFeLwXPj1uLcVUPwNpE4brRXOnssF74mPUHWt5KLE9PnVR?=
 =?us-ascii?Q?WkOUCEMvDSPMwL05NRNbJ1mMQwUA4l8vYMhgrsCZxw0lHKjwIeww8N/OCOJ0?=
 =?us-ascii?Q?r1JNIsiXH+cTUEN07mWVpBR3Mu3HidzVm9NzbWx/BIQCpOXd6Kos8JUMyG7H?=
 =?us-ascii?Q?Upq1B1oRnLwd6A6Pkg0bOg0lIQm7a6SXU2W3bH7DjLmKJsBJmdJJ5epcYMKk?=
 =?us-ascii?Q?47BZrxkkM5PgQVZVFBqxypF7NXLyAnUJijtHd1UP7mRH0A0qrrfe/osjNS94?=
 =?us-ascii?Q?4F3w7dxDoCqOeVoGv4sMKnvh2Caj/ohtQTsLgCH2Yk32F5AdK2466KpHMLAR?=
 =?us-ascii?Q?+aTsdywF/H6HxCTp1hWJFcwKA+i17toD+Ep4kRhpozzOzxNtBqWksKsM2GqU?=
 =?us-ascii?Q?WSBWFIL1SXg8/dJ2jL94NYk0/cGcz4FhNgRVgNgtq+w4lKnFLF62wrDKRaYC?=
 =?us-ascii?Q?ewOwWpvCyy2dTREo+Syjpt4EGy0qzyECLvf6+Gyyjswgv6yjQ5PUVfOPlFFq?=
 =?us-ascii?Q?xjtSG/Hw1zFNCO0KlIo8omcoCehN4uXGl6T3rAutemOg030oZsdfcMIgLzeg?=
 =?us-ascii?Q?B2nLpxAe2SIULeaz5C6rwE/bYdmsoIkZizSJ485wR91exvuoo4M19umKRdpy?=
 =?us-ascii?Q?qMhP7FB5Hl9dMoHpm1HLsiTvhYiSfQRIxtcdX6r3VWcyGKCD59tAmBYzo5N8?=
 =?us-ascii?Q?bDbYLw7IYVh8OUWkJVNbtCq9ZfCVJ10JaHEx/tGrbnvuIfuELQP9DNy9jsBS?=
 =?us-ascii?Q?dxaCyOvUlR5Gd7WBC8vEEai6sEb9Hmr/LT1ayVasAXZWAqyV9ZDzhaTWA8Dg?=
 =?us-ascii?Q?P4DYzu5qq3/wz+QvHBM+lT/yOws4zSA/yOOtok5nHgN6VBC9IicyIM3dfpzH?=
 =?us-ascii?Q?RH7757FjWxoUlQ/9Hku8XPeRGnsQWSThgOZvnF5jBaq04ZtvA7V+HQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YS5MPCI436krhuD3WOa7fY2B5zBKY5mC1HhvPfcNVDEtUK5rudd/AUprpMlz?=
 =?us-ascii?Q?fVDerOjSRH1kVuHq7UJJIBa0KehIonrxRBp8r7l1I+Hn1GN3KJKzxG61rD7r?=
 =?us-ascii?Q?7fbgVlbk4aoKwBwkU7h2/HS6+h+2utdPr8X1LmFUQgrSnh54M6RsTegG/C3W?=
 =?us-ascii?Q?4MA5L2ioMw+oVFhnyPD3gguPpRsG8kvKpLp5tFjNhk/q4S70ccszzjKS5S1A?=
 =?us-ascii?Q?VHdAWFCfmr2aYMG3wZ3WcJZxVDEo/AahujH0ywYQSMdgC+XBiwMcgIVK8n1e?=
 =?us-ascii?Q?v0Ma1Rp6ruIX6WpuA0Xk2K4MurBjBHU/YCGDe3fu4XDd+aJRDHHVCuffVG/b?=
 =?us-ascii?Q?UYrcfid1QBPtz8tctSGaL6OkuqZMm2ZXcPXhsjzOIfHL6T3x+Hq48739A/Up?=
 =?us-ascii?Q?y5evKhVZVelbbHj835UCOFZ2lgVrcLlJYvr5R248fV0n4HTDtjj6EScvnLKA?=
 =?us-ascii?Q?UxdNQ3nengy/olaQuxqWS+zsDTDOCabAu63PRQlowHY1VroPtoY2toB9Q2LD?=
 =?us-ascii?Q?PhNMOb7CIkdiGgotXzfPp4fu+Gwv975KWCWhhWhOSVrnjvX3dQOFwZEAauUT?=
 =?us-ascii?Q?7DTfvqD0E5zeA2uPfLqPnJvJBTgUKXHYpzbrnIFAU1CLytcDySmMTJ8OfEsP?=
 =?us-ascii?Q?LpsUzGV1D3Jef6vmRc/5cl5QQvnvUQ1KYd8AKYeMlVfhe9nmusIFVDeeuCNj?=
 =?us-ascii?Q?tcpjOf/rzYSr+IZgzGn4AaqpNeqGv8Tdtx3dyy6gRad96YRlHMX494flIviL?=
 =?us-ascii?Q?M7khSKfpheYg7OT0Y35jCrxctmJi7IZLjxqHVGcIdR3XR8Z16nfKlGA72IFf?=
 =?us-ascii?Q?TlcuDaakZogpyUQnjRR4VHzZzHZJPPwEnyWZFU3VXYHAM18dErgWiyg1H57L?=
 =?us-ascii?Q?DLN6NsAqNY7k/LcI7pr6CAE7jQl5aDcX19FKCedlyHRafZX6HrGeWSirKpxj?=
 =?us-ascii?Q?hYesraxt6pcTexEVOGrAL1XJwRAR7NAcBaD9sau0w475l6EjQi0MoE0Ym3Wn?=
 =?us-ascii?Q?IlD2aMbe90F10K0b5+9vrv/XBmyRBeFFw1v9XGm6Ok57vGoUaNJP6X9SHqf3?=
 =?us-ascii?Q?Yb4KplBKhxiCiCxXfov3i3AQEYiURjQFkGPLGICSvtv8Wds1+ABT4HbCKoP6?=
 =?us-ascii?Q?HoU5rylwHEwWcYl6OlVQXiNXWEAjYqBn4ap/r2nnh9dFgNF4GAGofZhYmoQj?=
 =?us-ascii?Q?AQZc3zRL4kKBixbfVd1EylVHpWXi+of9S/4Ja035j0xS3DeWXK5ImtR2Lt9E?=
 =?us-ascii?Q?D1ZWOd1/1sjVOvax8NagnGLEEiLIGGb+ihvGjyeoaF6ulkKg5NbO2mEcWurF?=
 =?us-ascii?Q?XgpZQiSdonijpHFiqXdQ6+46irmU/KdzlHMgmepwAxGuqEA9za3fpfiwJwdz?=
 =?us-ascii?Q?VzsLoiXkPrzwCpp0yHRgohZHo8qK6r6O+jpvz7Yfqx5rLcd0LVQnK1Pk441W?=
 =?us-ascii?Q?K5k/N9vbLgcnb0y0qHC5gGl1OgEwlPa8sDQiaywzuheVzgvlZhxDzc1C7H67?=
 =?us-ascii?Q?QJZzWHb4QpJ4eObshqarP7MHuFFUsuW224mRLkEys9A3GX3uL0hfPLsB7i6H?=
 =?us-ascii?Q?fr0XTWBMJOIJDHSd+bo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5126F46BC5FD130A0095A890FD812BL1PR12MB5126namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e80776-f865-4900-f19f-08dd8654f3c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 13:02:38.1275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bo/DVmsqzgHdXN2MsrAfDikCj9m9y+6VUbbwDgk+8H5Pd2O4n4sMyUppekr4Vd1fDKV1fifFky7OKCJsSnxadw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586
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

--_000_BL1PR12MB5126F46BC5FD130A0095A890FD812BL1PR12MB5126namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Ping.
________________________________
From: Jiang, Sonny <Sonny.Jiang@amd.com>
Sent: Friday, April 25, 2025 12:41 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Jiang, Sonny <Sonny.Jiang@amd.com>
Subject: [PATCH v2] drm/amdgpu: Add DPG pause for VCN v5.0.1

For vcn5.0.1 only, enable DPG PAUSE to avoid DPG resets.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v5_0_1.c
index 4b2e6a033831..60ee6e02e6ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -502,6 +502,52 @@ static void vcn_v5_0_1_enable_clock_gating(struct amdg=
pu_vcn_inst *vinst)
 {
 }

+/**
+ * vcn_v5_0_1_pause_dpg_mode - VCN pause with dpg mode
+ *
+ * @vinst: VCN instance
+ * @new_state: pause state
+ *
+ * Pause dpg mode for VCN block
+ */
+static int vcn_v5_0_1_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+                                    struct dpg_pause_state *new_state)
+{
+       struct amdgpu_device *adev =3D vinst->adev;
+       uint32_t reg_data =3D 0;
+       int vcn_inst;
+
+       vcn_inst =3D GET_INST(VCN, vinst->inst);
+
+       /* pause/unpause if state is changed */
+       if (vinst->pause_state.fw_based !=3D new_state->fw_based) {
+               DRM_DEV_DEBUG(adev->dev, "dpg pause state changed %d -> %d =
%s\n",
+                       vinst->pause_state.fw_based, new_state->fw_based,
+                       new_state->fw_based ? "VCN_DPG_STATE__PAUSE" : "VCN=
_DPG_STATE__UNPAUSE");
+               reg_data =3D RREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE) =
&
+                       (~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+
+               if (new_state->fw_based =3D=3D VCN_DPG_STATE__PAUSE) {
+                       /* pause DPG */
+                       reg_data |=3D UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+                       WREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE, reg_d=
ata);
+
+                       /* wait for ACK */
+                       SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_DPG_PAUSE,
+                                       UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MAS=
K,
+                                       UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MAS=
K);
+               } else {
+                       /* unpause DPG, no need to wait */
+                       reg_data &=3D ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK=
;
+                       WREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE, reg_d=
ata);
+               }
+               vinst->pause_state.fw_based =3D new_state->fw_based;
+       }
+
+       return 0;
+}
+
+
 /**
  * vcn_v5_0_1_start_dpg_mode - VCN start with dpg mode
  *
@@ -518,6 +564,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_=
inst *vinst,
         volatile struct amdgpu_vcn5_fw_shared *fw_shared =3D
                 adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
         struct amdgpu_ring *ring;
+       struct dpg_pause_state state =3D {.fw_based =3D VCN_DPG_STATE__PAUS=
E};
         int vcn_inst;
         uint32_t tmp;

@@ -582,6 +629,9 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_=
inst *vinst,
         if (indirect)
                 amdgpu_vcn_psp_update_sram(adev, inst_idx, AMDGPU_UCODE_ID=
_VCN0_RAM);

+       /* Pause dpg */
+       vcn_v5_0_1_pause_dpg_mode(vinst, &state);
+
         ring =3D &adev->vcn.inst[inst_idx].ring_enc[0];

         WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO, lower_32_bits(ring-=
>gpu_addr));
@@ -775,9 +825,13 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn=
_inst *vinst)
         int inst_idx =3D vinst->inst;
         uint32_t tmp;
         int vcn_inst;
+       struct dpg_pause_state state =3D {.fw_based =3D VCN_DPG_STATE__UNPA=
USE};

         vcn_inst =3D GET_INST(VCN, inst_idx);

+       /* Unpause dpg */
+       vcn_v5_0_1_pause_dpg_mode(vinst, &state);
+
         /* Wait for power status to be 1 */
         SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_POWER_STATUS, 1,
                 UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
--
2.49.0


--_000_BL1PR12MB5126F46BC5FD130A0095A890FD812BL1PR12MB5126namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Ping.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jiang, Sonny &lt;Sonn=
y.Jiang@amd.com&gt;<br>
<b>Sent:</b> Friday, April 25, 2025 12:41 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Jiang, Sonny &lt;Sonny.Jiang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu: Add DPG pause for VCN v5.0.1</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For vcn5.0.1 only, enable DPG PAUSE to avoid DPG r=
esets.<br>
<br>
Signed-off-by: Sonny Jiang &lt;sonny.jiang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 54 ++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 54 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v5_0_1.c<br>
index 4b2e6a033831..60ee6e02e6ac 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c<br>
@@ -502,6 +502,52 @@ static void vcn_v5_0_1_enable_clock_gating(struct amdg=
pu_vcn_inst *vinst)<br>
&nbsp;{<br>
&nbsp;}<br>
&nbsp;<br>
+/**<br>
+ * vcn_v5_0_1_pause_dpg_mode - VCN pause with dpg mode<br>
+ *<br>
+ * @vinst: VCN instance<br>
+ * @new_state: pause state<br>
+ *<br>
+ * Pause dpg mode for VCN block<br>
+ */<br>
+static int vcn_v5_0_1_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dpg_pa=
use_state *new_state)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D vinst-=
&gt;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg_data =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int vcn_inst;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_inst =3D GET_INST(VCN, vinst-&gt;=
inst);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pause/unpause if state is changed =
*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vinst-&gt;pause_state.fw_based !=
=3D new_state-&gt;fw_based) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_DEV_DEBUG(adev-&gt;dev, &quot;dpg pause state changed %d -&g=
t; %d %s\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vinst-&gt;pause_=
state.fw_based, new_state-&gt;fw_based,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_state-&gt;fw=
_based ? &quot;VCN_DPG_STATE__PAUSE&quot; : &quot;VCN_DPG_STATE__UNPAUSE&qu=
ot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg_data =3D RREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE) &amp;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (~UVD_DPG_PAUSE_=
_NJ_PAUSE_DPG_ACK_MASK);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (new_state-&gt;fw_based =3D=3D VCN_DPG_STATE__PAUSE) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pause DPG */<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_data |=3D UV=
D_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN=
, vcn_inst, regUVD_DPG_PAUSE, reg_data);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* wait for ACK =
*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_WAIT_ON_RR=
EG(VCN, vcn_inst, regUVD_DPG_PAUSE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* unpause DPG, =
no need to wait */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_data &amp;=
=3D ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN=
, vcn_inst, regUVD_DPG_PAUSE, reg_data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vinst-&gt;pause_state.fw_based =3D new_state-&gt;fw_based;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+<br>
&nbsp;/**<br>
&nbsp; * vcn_v5_0_1_start_dpg_mode - VCN start with dpg mode<br>
&nbsp; *<br>
@@ -518,6 +564,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_=
inst *vinst,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile struct amdgpu_vcn=
5_fw_shared *fw_shared =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.inst[inst_idx].fw_shared.cpu_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dpg_pause_state state =3D {.fw=
_based =3D VCN_DPG_STATE__PAUSE};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int vcn_inst;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&nbsp;<br>
@@ -582,6 +629,9 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_=
inst *vinst,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (indirect)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_vcn_psp_update_sram(adev, inst_idx, AMDGPU_UCO=
DE_ID_VCN0_RAM);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Pause dpg */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v5_0_1_pause_dpg_mode(vinst, &amp=
;state);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;vcn=
.inst[inst_idx].ring_enc[0];<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, vcn_inst=
, regUVD_RB_BASE_LO, lower_32_bits(ring-&gt;gpu_addr));<br>
@@ -775,9 +825,13 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn=
_inst *vinst)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int inst_idx =3D vinst-&gt=
;inst;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int vcn_inst;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dpg_pause_state state =3D {.fw=
_based =3D VCN_DPG_STATE__UNPAUSE};<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_inst =3D GET_INST(VCN,=
 inst_idx);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Unpause dpg */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v5_0_1_pause_dpg_mode(vinst, &amp=
;state);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait for power status t=
o be 1 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_WAIT_ON_RREG(VCN, vc=
n_inst, regUVD_POWER_STATUS, 1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);<br>
-- <br>
2.49.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5126F46BC5FD130A0095A890FD812BL1PR12MB5126namp_--
