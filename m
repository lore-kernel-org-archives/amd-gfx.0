Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B952D44151
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 01:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C929710E103;
	Wed, 20 Nov 2024 01:39:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cCTtCD2b";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5490D10E021
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 01:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haG9p8UYSOgB0XPiBYqpR9cuPvkoimjm9k95iak6TPGLk3PdmxtCGk8UG9Y79wvT3Q/L1mnslBBVd/weJHLJtVLirKG/c+NMeDfRsWIIh5Ubzp3NuIBFKQaSSxBEhcSmp/u+/UGyPH2Rnznbj3g5x2JljWAPu4REkeKKresZW+oWonE1u6cmc4xz+iMnUo2cMhiRHxOpY56Ge26ZufQtlI8mOeyaBTMSV4X0luV+7x/rIKP1IRMBx0wVyWJ1sceNObXAeYWPfwsmNapTPNhdcP58T508YGA6mNZSh74efnx7VF2DRIKEBFoVA+3s+lYFYvGPsMgafFvzzX6zqBB7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bprUq7LoHnB9QI2nCPqb9R+dnbVipqoMW3XA8Ob4s1M=;
 b=xRdqoFseh4v0Gafh5o4ASCfZ1VM+kMmFRhsl9BBV6Wi9eaEuSkbEWgsYZ11pH3aZvFzVpcZrjXEg/2A3ND9GQOmNEyEKhqGNDVJVeqK3QmmH1QP+CEBa2SCjXG/ZiDsbibJFPBd3Wsjgo3YOasZhHJaqjmaVBGCQm8v0lS2awLm2q2eEHmhLV4HX/pGXMCYcI52r0+Q5bojdl1OmaPWyPsC/bFYnkdz45c6+lxm8KSh9xLoMs9+pyL0ckJ3RnFiEu0t9300AL5JjmuWmzclBU2S5myDl9DMyglZz+O0a04SGnOPOJFU+rt5vqxAyVtwqSeM721wG55M0EE8iyjpYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bprUq7LoHnB9QI2nCPqb9R+dnbVipqoMW3XA8Ob4s1M=;
 b=cCTtCD2bmJY5qpxPFrTCGKGFaNUMzvSXzKvNEjeAJZPNHKTHxphbcVN9g3fZpCYJt5h0xh5Ac7YVphm8nCH577j3KQ46+iBMyrpVrFyH7qrax9XIUBklNhkVOOLy0u+P9O6euGZrBSDYH8EhAU3rCXD2CcOh5TWf/mWmIwB6Fbc=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 01:39:45 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 01:39:45 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: reduce the mmio writes in kiq setting
Thread-Topic: [PATCH] drm/amdgpu: reduce the mmio writes in kiq setting
Thread-Index: AQHbNzn1MGdx6yTkk0WLJqss2udkJ7K+814AgAB2c+A=
Date: Wed, 20 Nov 2024 01:39:45 +0000
Message-ID: <DS7PR12MB6005395CBD1E49A2AA1059E5FB212@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20241115083943.284924-1-Prike.Liang@amd.com>
 <BL1PR12MB51448295DDBC844F44F4ADB4F7202@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51448295DDBC844F44F4ADB4F7202@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-19T18:29:04.409Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ2PR12MB8783:EE_
x-ms-office365-filtering-correlation-id: dd4534c2-4aa5-487a-50d7-08dd09043673
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?F4/bPeQQ4VUmeHgplVT7gEQbHeyFnMjJK74WxLsK/g1TPUD/cAjkT+AVUTBP?=
 =?us-ascii?Q?YPi5wUf3ztL/cGmWzqf3BZoeUOVNAtnudAhpsu1Tr1QbjFg6kenRlWSxp735?=
 =?us-ascii?Q?xhWMM+OKnXrBABta5dY6bgdbyoGjHIr1gWM9WMqGKol2tdCHvq41+8unSAwt?=
 =?us-ascii?Q?kt9bhaiULDh8wAn0/gJGoYLU2ujk/xPxjlCDxvbH+vOwXu7zmV6+JTUJ1DlP?=
 =?us-ascii?Q?Ye2YsvlhQ5WE/7iKQLSi3IswFvMEgA0RmU3JRBcISuJq8k0YLNVhXwTZywyM?=
 =?us-ascii?Q?cEK2lqLJHnsSivdtjBj+kiRGl1OB6brNI337bP/JfqXh5z1AD2rEWV2wYwgI?=
 =?us-ascii?Q?Fz8Ke5OJ6dvfKI476bQupikGDO+S9IGKHT4QEpt2L1p10wkgI/VfQNlVVagl?=
 =?us-ascii?Q?vZwAPVKH5TQxaxmDtwwDm4Xgi5ZhruFMuAaPJCyU6anmRJSgdx/oCdrRqku8?=
 =?us-ascii?Q?R0JYoflFT0INrObMVNcE9tSLqHqz2Sb3LxrJgF/Oiq3fW7lBZ72EiplNyzD4?=
 =?us-ascii?Q?+0pvt3oNPp4QOG7C8d9pach4ewpYRhej1GxHh0kR2bsTVvJALUSvPGMUR6bs?=
 =?us-ascii?Q?HXtaFNxBmiEXB1WZ5Jii5/QKvoCLDpJBryz59ICfDcN0fe5Zak2IyjM3+iB8?=
 =?us-ascii?Q?5DeVaP4qrKv6NF5qb8PrdF8oDdDo7iBRSmX8Smmm9hOzZkcIS0pteAEYIBeh?=
 =?us-ascii?Q?fXcYWaUPBrcaCGfIwlBx71VebTuxXRnwY7re9ygRCfw6P2+YycKixmvgeaxT?=
 =?us-ascii?Q?lC7xJLjzADFfijRfTHCqOQRa/mxewiPIw055zfUn6FMSk6fdGo0IpCD5uSpR?=
 =?us-ascii?Q?0cOd7sA32/iPWrVrgnUayV15SCfCsv8T1YrtM8g2AQmD0zYUJ0MgUODPmlHi?=
 =?us-ascii?Q?M2O5v3VFPkIE8fTg3wGPDugWZsj5lO3PEt788PTCP+5EOTKY6q/IQsMtjHKt?=
 =?us-ascii?Q?eEhkfVtrATlNlX/mpXmeM+Qy3jWUN2LPISYDKU6kjyHIVgiC3iWpfzEP023k?=
 =?us-ascii?Q?Smv2MwA/sO8jDpCs++swpWWeIANqx9PuBNl8TOhZkeQpaZU6Bb+8TeFriHsY?=
 =?us-ascii?Q?zvWdU43fo+86Jh6JrN+ovcTGwrQI+geOUwmEhakn038JdilbN6wQ4gg2dUiM?=
 =?us-ascii?Q?a0qKPqev6QoaGDRbQnEWetamToWHJ+kHQou4Z5Cz5npN1lUy81RFOkVoSS5g?=
 =?us-ascii?Q?AFM03tqlG7OIQfP3ACvwcMn7rM6VHa9WoLNsHQngItRaXNj3tLugPNKs/0vc?=
 =?us-ascii?Q?omN3a7XqjR8npcy9Fd3xAeuhsiWmXMl8UoeFoBlFQzCh+UAIRvd/ULcy5PPa?=
 =?us-ascii?Q?lWdUStdvgtkHfJeZoV1lbNF7W01TMmGSGQlTECq+DFAsXIoaVqjDLqUkBSSg?=
 =?us-ascii?Q?2ByEZy0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V9/Lek0vpeK88d03aAXdH+3KjKWYDJ6cQ2aTmyMqivzlQflteox0ddyOTwT9?=
 =?us-ascii?Q?CY7wZgTc08zDjeqoGdf9B/lA0s4CEa3/CSQtXkgfaOOu5UnXIs1/x6iCyAda?=
 =?us-ascii?Q?Scc+G4eWcy2ajKLIHreGOszjdHdecJB48E77bJBQp+FlgkQAPNajF1cCx2fn?=
 =?us-ascii?Q?uPXjiUg2k5tnVagL0H/1LoFn/A3kKURo+aQr4gBqSesaYd/KG1qW5pP4h8cc?=
 =?us-ascii?Q?rtzLZ6HvFQDGDwYi+Rn0Pxit+33F1shrjSAEMt/UVyyMM6ikeyaeZxttd6Y8?=
 =?us-ascii?Q?hwvPYxjpQSCOryw7ASHB529H40cRcW1C5mEAB3/ls9y36n1TZUo/ZZ5YgqHS?=
 =?us-ascii?Q?hh9w+MBVJnfGHstExOZnP8klPI5+6L1vb38opRNqwPWBlRrMOegul6ATgvEC?=
 =?us-ascii?Q?rQf/ZSuBza91IY0hJLLFTgZd6RXnv+ctvu3oWQoT/5QJhUj2ubV89R9W0fWu?=
 =?us-ascii?Q?T15ElTCtbWT9fuCsQgOTXBBKXdN+HFDeMmncVxYCTgexBlSFRo7hIpRcbY0w?=
 =?us-ascii?Q?iKPD/+8HCjDzmTqw+svv3+JgVmJbbmYZQY2sTsPM0dIR5n5rU0NLrmEd9s/q?=
 =?us-ascii?Q?xDg/zDkZeNqkgm9WIt1a6p2Bg5PuJWYi5wIeVFuCGPHFhcwtPbILT3o7mQvy?=
 =?us-ascii?Q?3CpccB6jqrhC7zLFfUvnVsD/+hP7SYBwzko92BBf6Wv0tfSoD8tv5wDt8xzb?=
 =?us-ascii?Q?FbP3uOC1yQOFhvi7Bo0kPR8YNOeUC2hkPMWUATBF6V8XYvT2rRGXh2AB+OvZ?=
 =?us-ascii?Q?YQQhVwEcS1Mtl9DFl/b3P2szitJhjVzUvu7xWdUNT1Sz+STlYaRX9xE4+ebe?=
 =?us-ascii?Q?/N1iJOv8wxFNAdHGD+/kgFkb3joFpYTEdlmVunsiNOPOGSrPQefv70bUry5i?=
 =?us-ascii?Q?GizoJYrJkVN0ENFVd3G7qGuBpnL0uo/Ix5w+ao2otvraaSNhd+OHb7iAQwFN?=
 =?us-ascii?Q?nFp6leJuFhejsQD6uT53VPp2tDh7htEQYzCOp8o/pxCUlwD7YH4aQqepis1T?=
 =?us-ascii?Q?im0krtcUuTa/eQBl0hbGkIoBYtHAjXwSfMhwpDhWCTG6cjvNQ2Ta+sRVzG9I?=
 =?us-ascii?Q?RQbwgYMlkLypOxNitKYBBPWb3G3SVod6kYeMw8aTW7n7q9tbcdxL77zy5g/z?=
 =?us-ascii?Q?tccvPw3YxNi6dhdKTGKY/NJdN5+CRtGkw061SVPELPjEqGEqgRXtCwF4TbNS?=
 =?us-ascii?Q?XeXeMwk1/zjnZxWZlryZ6Hv1Hg6lHmRpUPkAEg9dBYDBIVXsi4ZAJMSlzESt?=
 =?us-ascii?Q?L0uWdS1YBimX+oJQ+qn3n6VDnrM1CW0L8x1e7+4X3h70nJ1d+e225aK2ZJ9Q?=
 =?us-ascii?Q?d8NCX530Y/p0LhGuabSk+e4gvr9fxlog92ex30dvoYKDVDFqJXCner1L1C3s?=
 =?us-ascii?Q?h5Gyy7lfMIkRqEiWcd/cLUbT1YciBcXELtZ265WvWknSUTE9OIyoxFE9YoT7?=
 =?us-ascii?Q?XWT+Gznil9zh2dwSg6axJ/1kR3gpzalCKHdtw9QnJlZ4FylBSvayAmf7TmQm?=
 =?us-ascii?Q?2zYeJstHYfYn99c4qc6bUH/NM3Oj8tk9sIuhfOr4CWlnDDis2AFN8F448Vp9?=
 =?us-ascii?Q?LgV7ESUH0G5Xf+iZirU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB6005395CBD1E49A2AA1059E5FB212DS7PR12MB6005namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4534c2-4aa5-487a-50d7-08dd09043673
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 01:39:45.4457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bqlNSAjjcqAWDjlEclOUH+SKDGX8H81p6iAlIq9ISBQAMP4LqYKyua97yRRoKT7d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
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

--_000_DS7PR12MB6005395CBD1E49A2AA1059E5FB212DS7PR12MB6005namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

It seems that there is no reason to write the same register bitfield separa=
tely as no HW sequence required that. Moreover, there is a similar program =
sequence in the KFD which directly programs the RLC_CP_SCHEDULERS register =
once.

Thanks,
Prike

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Wednesday, November 20, 2024 2:29 AM
To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: reduce the mmio writes in kiq setting


[Public]

As long as there is no hw programming sequence requirement to do it as two =
separate writes this looks fine to me.
Acked-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@=
amd.com>>
________________________________
From: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>
Sent: Friday, November 15, 2024 3:39 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>
Subject: [PATCH] drm/amdgpu: reduce the mmio writes in kiq setting

There's no need to perform the two MMIO writes in the KIQ
Setting registers programmed period, and reducing the MMIO
writes will save the driver loading time.

Signed-off-by: Prike Liang <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>=
>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 8 ++------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 +---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 4 +---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 4 +---
 8 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 9da95b25e158..ffd3c45b4ccd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6593,17 +6593,13 @@ static void gfx_v10_0_kiq_setting(struct amdgpu_rin=
g *ring)
                 tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cic=
hlid);
                 tmp &=3D 0xffffff00;
                 tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queu=
e);
-               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp=
);
-               tmp |=3D 0x80;
-               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp=
);
+               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp=
 | 0x80);
                 break;
         default:
                 tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
                 tmp &=3D 0xffffff00;
                 tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queu=
e);
-               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
-               tmp |=3D 0x80;
-               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp | 0x80);
                 break;
         }
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 5aff8f72de9c..a2aedcabae65 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3890,9 +3890,7 @@ static void gfx_v11_0_kiq_setting(struct amdgpu_ring =
*ring)
         tmp =3D RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
         tmp &=3D 0xffffff00;
         tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
-       tmp |=3D 0x80;
-       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
+       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp | 0x80);
 }

 static void gfx_v11_0_cp_set_doorbell_range(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index 9fec28d8a5fc..c61d383c45c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2826,9 +2826,7 @@ static void gfx_v12_0_kiq_setting(struct amdgpu_ring =
*ring)
         tmp =3D RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
         tmp &=3D 0xffffff00;
         tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
-       tmp |=3D 0x80;
-       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
+       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp | 0x80);
 }

 static void gfx_v12_0_cp_set_doorbell_range(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 480c41ee947e..d465c3ea6e6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4304,9 +4304,7 @@ static void gfx_v8_0_kiq_setting(struct amdgpu_ring *=
ring)
         tmp =3D RREG32(mmRLC_CP_SCHEDULERS);
         tmp &=3D 0xffffff00;
         tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-       WREG32(mmRLC_CP_SCHEDULERS, tmp);
-       tmp |=3D 0x80;
-       WREG32(mmRLC_CP_SCHEDULERS, tmp);
+       WREG32(mmRLC_CP_SCHEDULERS, tmp | 0x80);
 }

 static int gfx_v8_0_kiq_kcq_enable(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index e9248a855ba7..a6cb30558f2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3482,9 +3482,7 @@ static void gfx_v9_0_kiq_setting(struct amdgpu_ring *=
ring)
         tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
         tmp &=3D 0xffffff00;
         tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-       WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
-       tmp |=3D 0x80;
-       WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+       WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp | 0x80);
 }

 static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_=
mqd *mqd)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 016290f00592..ae3c8645633b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1771,9 +1771,7 @@ static void gfx_v9_4_3_xcc_kiq_setting(struct amdgpu_=
ring *ring, int xcc_id)
         tmp =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULER=
S);
         tmp &=3D 0xffffff00;
         tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-       WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS, tm=
p);
-       tmp |=3D 0x80;
-       WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS, tm=
p);
+       WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS, tm=
p | 0x80);
 }

 static void gfx_v9_4_3_mqd_set_priority(struct amdgpu_ring *ring, struct v=
9_mqd *mqd)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 8ca137313961..3b818441c7ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1491,9 +1491,7 @@ static void mes_v11_0_kiq_setting(struct amdgpu_ring =
*ring)
         tmp =3D RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
         tmp &=3D 0xffffff00;
         tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
-       tmp |=3D 0x80;
-       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
+       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp | 0x80);
 }

 static void mes_v11_0_kiq_clear(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 9d0e342a2f81..44b0d0f76944 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1453,9 +1453,7 @@ static void mes_v12_0_kiq_setting(struct amdgpu_ring =
*ring)
         tmp =3D RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
         tmp &=3D 0xffffff00;
         tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
-       tmp |=3D 0x80;
-       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
+       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp | 0x80);
 }

 static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
--
2.34.1

--_000_DS7PR12MB6005395CBD1E49A2AA1059E5FB212DS7PR12MB6005namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle21
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">It seems that there is no reason to write the same re=
gister bitfield separately as no HW sequence required that. Moreover, there=
 is a similar program sequence in the KFD which
 directly programs the RLC_CP_SCHEDULERS register once.<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-ligatures:standa=
rdcontextual">Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-ligatures:standa=
rdcontextual">Prike<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander &lt;Alexand=
er.Deucher@amd.com&gt;
<br>
<b>Sent:</b> Wednesday, November 20, 2024 2:29 AM<br>
<b>To:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: reduce the mmio writes in kiq setti=
ng<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">As long as there is no h=
w programming sequence requirement to do it as two separate writes this loo=
ks fine to me.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Acked-by: Alex Deucher &=
lt;<a href=3D"mailto:alexander.deucher@amd.com">alexander.deucher@amd.com</=
a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Liang,=
 Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Liang@amd.com</a>&g=
t;<br>
<b>Sent:</b> Friday, November 15, 2024 3:39 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Liang, Prike &lt;<a href=3D"mailto:P=
rike.Liang@amd.com">Prike.Liang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: reduce the mmio writes in kiq setting</=
span> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">There's no need to perform the two MMIO writes in the KIQ<br>
Setting registers programmed period, and reducing the MMIO<br>
writes will save the driver loading time.<br>
<br>
Signed-off-by: Prike Liang &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike=
.Liang@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp; | 8 ++------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c&nbsp; | 4 +---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c&nbsp; | 4 +---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp; | 4 +---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp; | 4 +---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 +---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c&nbsp; | 4 +---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v12_0.c&nbsp; | 4 +---<br>
&nbsp;8 files changed, 9 insertions(+), 27 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 9da95b25e158..ffd3c45b4ccd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -6593,17 +6593,13 @@ static void gfx_v10_0_kiq_setting(struct amdgpu_rin=
g *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienn=
a_Cichlid);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;&lt; 5) | (ring-&gt;pipe &l=
t;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp | 0x=
80);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;&lt; 5) | (ring-&gt;pipe &l=
t;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp | 0x80);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index 5aff8f72de9c..a2aedcabae65 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -3890,9 +3890,7 @@ static void gfx_v11_0_kiq_setting(struct amdgpu_ring =
*ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0=
, regRLC_CP_SCHEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;=
&lt; 5) | (ring-&gt;pipe &lt;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp | 0x80);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v11_0_cp_set_doorbell_range(struct amdgpu_device *ade=
v)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c<br>
index 9fec28d8a5fc..c61d383c45c4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
@@ -2826,9 +2826,7 @@ static void gfx_v12_0_kiq_setting(struct amdgpu_ring =
*ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0=
, regRLC_CP_SCHEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;=
&lt; 5) | (ring-&gt;pipe &lt;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp | 0x80);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v12_0_cp_set_doorbell_range(struct amdgpu_device *ade=
v)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index 480c41ee947e..d465c3ea6e6c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -4304,9 +4304,7 @@ static void gfx_v8_0_kiq_setting(struct amdgpu_ring *=
ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(mmRLC_CP_SC=
HEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;=
&lt; 5) | (ring-&gt;pipe &lt;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmRLC_CP_SCHEDULERS, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmRLC_CP_SCHEDULERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmRLC_CP_SCHEDULERS, tmp | 0x8=
0);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int gfx_v8_0_kiq_kcq_enable(struct amdgpu_device *adev)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index e9248a855ba7..a6cb30558f2f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -3482,9 +3482,7 @@ static void gfx_v9_0_kiq_setting(struct amdgpu_ring *=
ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0=
, mmRLC_CP_SCHEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;=
&lt; 5) | (ring-&gt;pipe &lt;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHE=
DULERS, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHE=
DULERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHE=
DULERS, tmp | 0x80);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struc=
t v9_mqd *mqd)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c<br>
index 016290f00592..ae3c8645633b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
@@ -1771,9 +1771,7 @@ static void gfx_v9_4_3_xcc_kiq_setting(struct amdgpu_=
ring *ring, int xcc_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, G=
ET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;=
&lt; 5) | (ring-&gt;pipe &lt;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, GET_INST(GC, xcc=
_id), regRLC_CP_SCHEDULERS, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, GET_INST(GC, xcc=
_id), regRLC_CP_SCHEDULERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, GET_INST(GC, xcc=
_id), regRLC_CP_SCHEDULERS, tmp | 0x80);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v9_4_3_mqd_set_priority(struct amdgpu_ring *ring, str=
uct v9_mqd *mqd)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index 8ca137313961..3b818441c7ba 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -1491,9 +1491,7 @@ static void mes_v11_0_kiq_setting(struct amdgpu_ring =
*ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0=
, regRLC_CP_SCHEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;=
&lt; 5) | (ring-&gt;pipe &lt;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp | 0x80);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void mes_v11_0_kiq_clear(struct amdgpu_device *adev)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c<br>
index 9d0e342a2f81..44b0d0f76944 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
@@ -1453,9 +1453,7 @@ static void mes_v12_0_kiq_setting(struct amdgpu_ring =
*ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0=
, regRLC_CP_SCHEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;=
&lt; 5) | (ring-&gt;pipe &lt;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp | 0x80);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)<br>
-- <br>
2.34.1<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DS7PR12MB6005395CBD1E49A2AA1059E5FB212DS7PR12MB6005namp_--
