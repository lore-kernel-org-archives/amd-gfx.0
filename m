Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F92BCD8C91
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 14:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0725610E38A;
	Tue, 10 Oct 2023 14:33:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D3A10E389
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 14:33:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd0aBe93PTE3JdXV7gTM7mzlcr6FSJx36u6SmyJ9UhZcJ7VTgLG3aPfeLH7JPxonmkkZ3/gE7lugC3voGm2QdeY8aN+YE2KEk8CoHfTChAmYFpUQCL/HnawEOyBC/bBm6WWQU+HN2XIXEo+E/q7P8TkeQe6ADo+EmbZLfpM2OFvT2CRFmEwPsv2XQuiTt10y6pRUTAxrC53m4ga60p+DVihM0LDzD9P0BJAtGB+fJAwZpCriAIm4l/raekuR8cVKJPvz9ZEGW14rmVHfYb0NF1fnzAsqDyj6D3mNj5PsqbM/b6zXkTHqwW66VgZHj5bwKA6XLAoalNbFS3RxSXSwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMvVttF+/mWkM1d4jI8agYzEbx75/2XeUxs2WZMVcuY=;
 b=ce2dLPzWTh1vkBtmzOi7sLGBn67/I4D6rDd3YjHnZa9gLRKH/10TH0qDkiXpxqOiw2py5D8B1Xyp4xUW/LECRgOgvxX+rkEnpbjCydGjRhEaaFzn4NHFkIt35jwbVGeBppdMPHSXx/UXIp56JRNiIfrgCoV7SA4HKHsp8NnS2D64dWf3uF9qEm1dW6XpacL7CLTFenbxoos2/zToyptmjbtN6eErj3Syd/jeWV42PmyKF7zJ/u5rIgIhhPyPHc//rjPM32CZWAPz3JUpfZgBMCY4t6ZO6mxRNSRVwWoi/DZUuyjx5+n00fgUC7HVUs4K+uMRKcEZ7V5eJJCzznGRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMvVttF+/mWkM1d4jI8agYzEbx75/2XeUxs2WZMVcuY=;
 b=XzsxwctrqRniwODZjbqmGAjzRwNA+l14MvK+sEfIRZItqJwyaqphuLpokQa8jLrSgEpBIGp4bJAyzJu5mWZPt6tc9oR+EEKik6C+cGZIDmt9oUx1HjK20U6YCtE4MhZBLSGioiER/fsUuGGGEL4sQNGEKZ6Hqwc7mB+FP6UQNcQ=
Received: from MN2PR12MB2909.namprd12.prod.outlook.com (2603:10b6:208:103::13)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Tue, 10 Oct
 2023 14:32:59 +0000
Received: from MN2PR12MB2909.namprd12.prod.outlook.com
 ([fe80::5759:e108:636a:f417]) by MN2PR12MB2909.namprd12.prod.outlook.com
 ([fe80::5759:e108:636a:f417%4]) with mapi id 15.20.6838.033; Tue, 10 Oct 2023
 14:32:59 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Make EXT_COHERENT parameter affect APU svm memory
Thread-Topic: [PATCH] drm/amdkfd: Make EXT_COHERENT parameter affect APU svm
 memory
Thread-Index: AQHZ+4aqBGCk8zoX8Ui5skA+5WjtjQ==
Date: Tue, 10 Oct 2023 14:32:59 +0000
Message-ID: <MN2PR12MB2909BAAE46A5FAD2E4549FD7EFCDA@MN2PR12MB2909.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-10T14:33:41.929Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB2909:EE_|MW4PR12MB7144:EE_
x-ms-office365-filtering-correlation-id: 1be8882e-0cb8-4fed-d148-08dbc99dcd7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9qemF4hzD/2J9d9wts8y4OQxMUMiadHICmFx6cduthMWzwn+eMO82RNUXZ7A/dChPf00xskd8ywyfX8se/LcvH5KLchzSTOjduFjgf6Vnhvqi1gVm8aWxDiEvvmA+Bb5EwEE1NTnelgRYUkBshXtJlK5SxGZCa7Tv5tsXhnbeaBt6z7pGccnlDwNWlvVon0BSGvmHWzvKU37rAVQHh5Ipq3pkbMQfUqJuLdLXTgvvdX97ANT0eH+L+lm1mBzum8HDmDW1IYDY+mLrX3dPXkn6BtXyPKhs0QkIbL22SjOPtdwrWNI+wG5IpL79H+q9Mu/Xq3WqT8B+T56iUEHi2XU0ZIbYH4duFlym/iDOAkKcMPWz0+TmT/JjFKGFHLqxlVQFnIktt3K9kJnpuqMOe5XCNb5agWZG5CkDs2Bx+s0dZGjeVKL2rfaNRut5Fb3InG78tWXxmjqD7WkZi+wFnh+0pg4pdYD7jRVB4PUmJIv15OQZXM9bYmdnT5ZbS5i1ggSTyjAy1OSpQspp/GtQbl7rGawNN3Bvm4hGbcaGp8r3bq4F0CHJwxo0A5WAKIUVB3HTd1WVgTT/94PLe/neKvVupUrwOnF1yCpUu46W0lrLwlKqBWiyhMGsDRDhoVBdEG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2909.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(19627405001)(4744005)(2906002)(8676002)(52536014)(8936002)(5660300002)(41300700001)(66476007)(66556008)(6916009)(316002)(64756008)(66446008)(66946007)(33656002)(55016003)(76116006)(91956017)(26005)(71200400001)(7696005)(6506007)(9686003)(83380400001)(122000001)(478600001)(86362001)(38100700002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3N4rihcQmUxRHLOFMprybVaJIdJ5oWRptqZaVLh54X6MWCqkdcLZmIxM/l?=
 =?iso-8859-1?Q?/T7LvlJb3bLIHrPIfrfYpqw7EsGAp0aKvsxzCPW9vZhz/neh6SFZgTr18B?=
 =?iso-8859-1?Q?qClI5CCKXXHvNI3eKIM3G7xLTnNJzmFI0FVC0VLj6pCrvLnL+6gUnVjmPX?=
 =?iso-8859-1?Q?Vs2TZ7mN4Bsp8E2bVsoCb2JubcxJFO5WPI1WSPPk6sgn3RTyJLKBm53iBX?=
 =?iso-8859-1?Q?kbjW3XENv0OaJyoiaiF2T3n7mrapZMh7br1cV9mi6oW0jjOnu8gUpiOHaQ?=
 =?iso-8859-1?Q?VIonV2nvF+BxOQV+jY1k2x4JQ1ezswrkV+nFV/32sJowZeuH7sugz9FXvT?=
 =?iso-8859-1?Q?dUW1V+5uXFum2LK0FMLzUmFxsRTk+kdJBxKN4N471jlNxoAKExiOtQpAaA?=
 =?iso-8859-1?Q?Oe8qI+a4AM6gVIrXJaO7hmmWtCEcwGfdklkhVCgYqqVJ6lJmBFfaoQbUSF?=
 =?iso-8859-1?Q?BkYX/luO+2F79w0XBUwemWfpY90npBI3U5wphYr0y0NBV+NHqwJFY1yYMJ?=
 =?iso-8859-1?Q?guqY8CK33Uomx5KSGc2BR8WEJFlg646YOdMJq3aglXghNg58k70S9o8RXt?=
 =?iso-8859-1?Q?9cHzMPlihtullstFvrArqg1hg6fQqTUU/aNNUXW9eCLzME9k24y33ddsn5?=
 =?iso-8859-1?Q?bcjg+PnsImvY+cl10fLxe8+6rikY3N9kj5Q6Z5ge37pCnX3/kDhpr13/Ik?=
 =?iso-8859-1?Q?bmoFR1eIatSlbNdKqsJ3ZNP9SskDmm9FvM/7z/8V3cQSrRNL4PqO8c8SCe?=
 =?iso-8859-1?Q?+nYziUWnScYGWlyQBkN3i4h5u02s56RAgaBVukgFwPzXUwHgB/Lj0s4NLN?=
 =?iso-8859-1?Q?OdNqgKFerrmlBxsjkcrdlWPldDckLN1WyPLrtqZxDU1IxH31SLii8wsKIz?=
 =?iso-8859-1?Q?VHCIja+3DMdMVfD7nKZDnucjzCkjsFxZX3djv0nI/r3AVh9M8psyTYwnpz?=
 =?iso-8859-1?Q?6kbSm1EWh640srvY3NCw5Nv/Nf4O1d2PAJM1gPXwej7gj6tQP9QDMcH2eh?=
 =?iso-8859-1?Q?sMpYIyEHAvw06LGfPUNLcekYC85rZ2wpQYkA94bHnvXx66UU9yT8ubxNNw?=
 =?iso-8859-1?Q?HrqnvpPdp3M9yH4S2X+0V9fz15bs3d99M5DEvQHysvfn1uQXPZhUZBzu4z?=
 =?iso-8859-1?Q?Q2pKLV1L+W7zKjO6D54vTThSUl4sAjwAEouZvBiE9oNfQuaufzghNNrPJF?=
 =?iso-8859-1?Q?HJCx+FVmSDmU9ev702StLMeFYU0TDqsO1kLt6/m99Z6oMtUD9OgsOK4m+d?=
 =?iso-8859-1?Q?JkPwbAimwWG/ZFo3rGtjSFqVezi2xHNK3QsXCEfTZGNwWGwjLIgsvgdOcn?=
 =?iso-8859-1?Q?1cn2IDOlHs4hiGL3UnAlTRI32fraBIHGQF9uyWu0s2ffJe/UzUhWx7e0qB?=
 =?iso-8859-1?Q?Qx1wajqEFPsLWammcEy0BuECciKRMIaWWqnMXGuUzl8mWyWxzfqIPO0/Kw?=
 =?iso-8859-1?Q?ddaiOoM0hm+BON5Nzc6MtD1D9ScMGWEO7OmL5gJCGOgVRvYc9uh2xbcZTO?=
 =?iso-8859-1?Q?n66ANx9g8E26NCXhEFDV7ADgCDPj8XX5fS3xxwLT1VGsywY2GBaucaVIl6?=
 =?iso-8859-1?Q?qrkWyj4sDXIlVY2CjzwJM4GW9dcHLyGSA/vDV5th8Uqg9jOtl3iyYXdbGF?=
 =?iso-8859-1?Q?rOv9fdZjoU4Lw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MN2PR12MB2909BAAE46A5FAD2E4549FD7EFCDAMN2PR12MB2909namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be8882e-0cb8-4fed-d148-08dbc99dcd7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 14:32:59.7277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jO1q3GOGVjeqppIjTpERk5LvkPPn85i8GhEWmPboi6bFmA28chOrwhp2vMh6/oHe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144
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

--_000_MN2PR12MB2909BAAE46A5FAD2E4549FD7EFCDAMN2PR12MB2909namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

By the intended semantics of the EXT_COHERENT parameter,
it should cause the driver to use MTYPE_UC instead of
MTYPE_NC on non-local gfx9.4.3 APU memory.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 7b81233bc9ae..d9ef937308ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1286,7 +1286,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
                         if (num_possible_nodes() <=3D 1)
                                 mapping_flags |=3D mtype_local;
                         else
-                               mapping_flags |=3D AMDGPU_VM_MTYPE_NC;
+                               mapping_flags |=3D ext_coherent ? AMDGPU_VM=
_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
                 /* system memory accessed by the dGPU */
                 } else {
                         mapping_flags |=3D AMDGPU_VM_MTYPE_UC;
--
2.34.1

--_000_MN2PR12MB2909BAAE46A5FAD2E4549FD7EFCDAMN2PR12MB2909namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">By
 the intended semantics of the EXT_COHERENT parameter,</span><br style=3D"f=
ont-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;,=
 &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Hel=
vetica Neue&quot;, sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); b=
ackground-color: rgb(255, 255, 255);" class=3D"ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">it
 should cause the driver to use MTYPE_UC instead of</span><br style=3D"font=
-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &q=
uot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvet=
ica Neue&quot;, sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); back=
ground-color: rgb(255, 255, 255);" class=3D"ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">MTYPE_NC
 on non-local gfx9.4.3 APU memory.</span><br style=3D"font-family: &quot;Se=
goe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot=
;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, s=
ans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); background-color: rgb=
(255, 255, 255);" class=3D"ContentPasted0">
<br style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West Eu=
ropean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Rob=
oto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; color: r=
gb(0, 0, 0); background-color: rgb(255, 255, 255);" class=3D"ContentPasted0=
">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">Signed-off-by:
 David Francis &lt;David.Francis@amd.com&gt;</span><br style=3D"font-family=
: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Seg=
oe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neu=
e&quot;, sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); background-=
color: rgb(255, 255, 255);" class=3D"ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">---</span><br style=3D"font-family: &quot;S=
egoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); background-color: rg=
b(255, 255, 255);" class=3D"ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_svm.c
 | 2 +-</span><br style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe U=
I Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.66=
67px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=3D"=
ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">&nbsp;1
 file changed, 1 insertion(+), 1 deletion(-)</span><br style=3D"font-family=
: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Seg=
oe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neu=
e&quot;, sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); background-=
color: rgb(255, 255, 255);" class=3D"ContentPasted0">
<br style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West Eu=
ropean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Rob=
oto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; color: r=
gb(0, 0, 0); background-color: rgb(255, 255, 255);" class=3D"ContentPasted0=
">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">diff
 --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/=
kfd_svm.c</span><br style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe=
 UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMa=
cSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.=
6667px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">index
 7b81233bc9ae..d9ef937308ed 100644</span><br style=3D"font-family: &quot;Se=
goe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot=
;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, s=
ans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); background-color: rgb=
(255, 255, 255);" class=3D"ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">---
 a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c</span><br style=3D"font-family: &qu=
ot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI=
&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quo=
t;, sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); background-color=
: rgb(255, 255, 255);" class=3D"ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">+++
 b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c</span><br style=3D"font-family: &qu=
ot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI=
&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quo=
t;, sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); background-color=
: rgb(255, 255, 255);" class=3D"ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">@@
 -1286,7 +1286,7 @@ svm_range_get_pte_flags(struct kfd_node *node,</span><b=
r style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West Euro=
pean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Robot=
o, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; color: rgb=
(0, 0, 0); background-color: rgb(255, 255, 255);" class=3D"ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
 if (num_possible_nodes() &lt;=3D 1)</span><br style=3D"font-family: &quot;=
Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&qu=
ot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;,=
 sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); background-color: r=
gb(255, 255, 255);" class=3D"ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 mapping_flags |=3D mtype_local;</span><br style=3D"font-family: &quot;Sego=
e UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;,=
 -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, san=
s-serif; font-size: 14.6667px; color: rgb(0, 0, 0); background-color: rgb(2=
55, 255, 255);" class=3D"ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
 else</span><br style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI =
Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSys=
temFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667=
px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=3D"Co=
ntentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 mapping_flags |=3D AMDGPU_VM_MTYPE_NC;</span><br style=3D"font-family: &qu=
ot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI=
&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quo=
t;, sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); background-color=
: rgb(255, 255, 255);" class=3D"ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 mapping_flags |=3D ext_coherent ? AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;=
</span><br style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (=
West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFo=
nt, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; c=
olor: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=3D"Content=
Pasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 /* system memory accessed by the dGPU */</span><br style=3D"font-family: &=
quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe =
UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&q=
uot;, sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); background-col=
or: rgb(255, 255, 255);" class=3D"ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 } else {</span><br style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe=
 UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMa=
cSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.=
6667px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
 mapping_flags |=3D AMDGPU_VM_MTYPE_UC;</span><br style=3D"font-family: &qu=
ot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI=
&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quo=
t;, sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); background-color=
: rgb(255, 255, 255);" class=3D"ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">--</span><br style=3D"font-family: &quot;Se=
goe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot=
;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, s=
ans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); background-color: rgb=
(255, 255, 255);" class=3D"ContentPasted0">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"ContentPasted0">2.34.1</span><br>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB2909BAAE46A5FAD2E4549FD7EFCDAMN2PR12MB2909namp_--
