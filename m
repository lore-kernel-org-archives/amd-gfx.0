Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98800C6FD1F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 07:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0190A112264;
	Fri, 29 Mar 2024 07:16:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sMSxln4t";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2132.outbound.protection.outlook.com [40.107.244.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF245112264
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 07:16:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byt4EO4qpI5fajBbCfT0rGfVymTzSjmHwDWSDJEPF126hjhqlpUeY6cnKeH0xnLBNL/lPOrzuqmfncrYnVFxdiCqLCFBsPJ6R0sKkREAaHIHB0i6qAhLPoGai/xcPYdDzmOEKCXItD6TdN6bplXIyYA3ggVF3AlStlzyhp7eAb551D86/oMpOhdUhvRtHuAVX81PN25Q3WY7y1mn0VuriTm1KUw+TcRO08sV7ueVsjAuMHChiXN7jgxoFgEN4Aq7CncP9vNvZTV+AsjBLswSTLdGW0DB9vq2ze48xcPrxWWyM3lWRP5au/AU7DhKmWVYa0uCjibIcn1CaQjP9fiwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3kv+xlkkTDEZDTgBt9gB9pqT/gT3DOKj54klzawlvY=;
 b=he6AqvRXu1i3KROcneJHPoTFm08TnzxdaWAQcM93Q9Gql1xqBgWWEaQRKHzNMpXrxkZuWwTOZGumY+8dTob6OhVQb/4Oa7CLG49ayWkkVw+qUmLzaLzcHVL/wVeOCvHXf2STzjGIvsHSoCt+lrpxKpJnszvpHmGJZ9oC3P9MW9Ptgikw1xgzY6IOJI5qutH+oXswEKaXMMI9euHJpxIBt1sxJVgg2kW2Ti50lL1XdnH7l7s/WaaihOYnkqJq2RJtZp28fjLrtQtYy+kwaxrYnVYJat2Rfvn5heynEmjMjbEXPZdfbVVJTTW8DS84ymZRwEtoX4TkFvA1vrQ8O0K2mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3kv+xlkkTDEZDTgBt9gB9pqT/gT3DOKj54klzawlvY=;
 b=sMSxln4tXZzxNsK41LDehbV03IQxhN1Gw1H2W+85oVky+yu+JyUEgrp0uu10HoH9phCtV0ruG4FG9CPtbuCjiF14g2BzdkS3U5RS/6jPc2tH6Yyvxws+p4lEVkU3sl6v+ylopAcZbcfe7cY7L8fMcHZ+H2U2MyDURx0wdCb5zqQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 07:16:01 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 07:16:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: implement IRQ_STATE_ENABLE for SDMA v4.4.2
Thread-Topic: [PATCH] drm/amdgpu: implement IRQ_STATE_ENABLE for SDMA v4.4.2
Thread-Index: AQHagYaY52KXvxupmkGJApuTdrWKcbFOTr3w
Date: Fri, 29 Mar 2024 07:16:01 +0000
Message-ID: <BN9PR12MB5257BE040F66168ADBF86830FC3A2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240329030937.366266-1-tao.zhou1@amd.com>
In-Reply-To: <20240329030937.366266-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2a2a0a84-8469-40e9-af3a-2df31d309f2d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-29T07:15:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB8147:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ylC523NctpxrsGCUtB/PQBWVwuRPk4vap9U5Wx1W3kdx1przYqg7wzg0gQxlgr3wXSTQ0YWfnUIrh236Z/z6ccEkopSvs+9q+06r6CqhLdFq0QR+87KNncG4iLOrfp0qhYZJ6u5U9Ui5yTfbCw68MuBHaJBsTRvw8ZjiwOAenZRXp9Ni2id4e6LcbvgSeFhlhuyVIwvyV6Kh53mh1PHwfNL+oBiT/fst6X67kWGK1jYOGfOu/47XnOcetXW2eZam0VXpJUCNfPwhkkAIH2Ke77NZOrIGD1rQhkEyp6gHGqj/e1jefdzmzdQTxbKLgA0ErxRnefgVZ6AO5+WXE+BPDzJorVxy+TAGgnyyvqgAJdeZ0Oe8cckqEdRS3Iyirm7loF/S57BV/SHie5IWf+fmIjr20xuPI3fEzHAPEbYvL2TgcXxcVB+0drSwgrdAjiXqaj378eQVwx5NnvhCm1beKbNlT67cUxoMmFlls2Zg+ezhVxRk5/XIa133ud5EWryySKcXX4TQHmc9JE0Uwlpwzd0Ltr3Zl4yqDHlXtFRYXFJKAk1mkpiFKLi+HCSNMKpPcmS7wnJnMckjdq5WiSNaazc3LT60camTlBZWNq4aKZbHtsrbRuM79dwmiH7nkHL/afjGHbplxCrlMQN+W7DO1qBBzUfqzWqMImDRlFBm+PI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P1hpqEIgbgLvaUrap3WFXrhg3GIcxVo8Y0wG2fufl66c1jQfetMYT84eZV2g?=
 =?us-ascii?Q?2y0PKidhZHkZRpzA3O9vBEbEKLSH8QcicX7F4qCu4rzwkVtraMTqfnDDNR2D?=
 =?us-ascii?Q?QDUqzBoc+/2qG3C18N2zPmQ9KBLdUSZKSCSXcW3k3RP4y8J+LDR0rjeQBADb?=
 =?us-ascii?Q?/5VM59jK7w04tdOIbf8siXouJT8FfiUk50EXRx1hOxHJzRsbMecGjGa2vpKx?=
 =?us-ascii?Q?rDhpnKXQ27/cN/4/cLMeK3GQ+UnwsYOn8KNoGpjNs8/dqtSJKZACE74k9u/C?=
 =?us-ascii?Q?WZwMe+Kf3CB23LeXucFxDfu2m/fzS7o3dCfGgTAGB9/PlrvBYkqHPLQLh3yn?=
 =?us-ascii?Q?Z+/C8oDKJNx+ku4FWsiXR0yE7OS3W1IoXPJQDmEbslReZs/39wtj2DyWLTjK?=
 =?us-ascii?Q?SzX3+IivJ/K2cGMAiwpyRhDWqHqqRLihlCaqAVioLdtxgu0GVe52GRsIBGkV?=
 =?us-ascii?Q?ELYemZYSLOAa4mWjHH+KtMsD0B7YYuc3aG2CMe4uUbaJTQZesAzkSK8bPR0t?=
 =?us-ascii?Q?G5aVXgkFO4bzncssgh1+OtEFsgImf36qzIQwIOGJ+bneGBUQeZj//rfK1odB?=
 =?us-ascii?Q?QeUa4FJj+/mECIm+zcnXeKFcZAPU0oUMi95QrV5nH9PMxjVz282l590wSb/B?=
 =?us-ascii?Q?mMcWXPuykaDQec/intyKS4HFqDMfuATjW94eh58IsRxPF8L+nK4wKHndUzfW?=
 =?us-ascii?Q?gq/w+QLudqw3V/SRYgCqE4qXFIM5SO4ITEDGMlIeU+cHrxlGLJVDJt5yiBjy?=
 =?us-ascii?Q?RC9rX2Fxbspf7S7g4/k0vaelBXxlw3nsHzfxVRNzmVebl1Lu8a7loOVGwyes?=
 =?us-ascii?Q?EkXvO6GlxtvmryURqHzN8mo5GqgvlmRGl6qPkim5w0VZaavotEd/mTrxmhoe?=
 =?us-ascii?Q?GgMTKHgUa8E4/53+vUIJNJyICr1LPrLgqFchpP8Kayv7ZTKNxS/Yk3IERwQG?=
 =?us-ascii?Q?7cWMXHN7z38GSq2FaN0z0wMNyeoD2khezxxi4qiEgLZFxD5G52KvgA3LIanX?=
 =?us-ascii?Q?fyV/n3DYxzC4W81ZwVcUQDm6mgepm/zorqIyP8jSF1mKaib7E3VEyM/bx1g+?=
 =?us-ascii?Q?kpTmiQd8TWM0DtgZjRYJ7J0a/9YUI4oOsg3OJ3wc4qZxYZmfivAUdU82uqIm?=
 =?us-ascii?Q?zEn2+9oIZ+/FAY+As+fXs5z8ekptul0Io+74WAXTMXosFC4LJXHc+Bx31Fn0?=
 =?us-ascii?Q?exMkTTzi44JpA9awzZGHmK9khiSEJYSEoE2MAjL74W3oNUTYGZYBd+GFYZw0?=
 =?us-ascii?Q?BhND/zhidSnlDo3SWLd07tcqJjLr0fMyOPkpntdGhjJvz7NY/uXKp2uuByws?=
 =?us-ascii?Q?RN2NuCsSv7tfEzZuScoWcgLR5oKNoVrEHUXz8/Joo+j+S76rVa6DivzJuhhJ?=
 =?us-ascii?Q?Qm/S3yMAxRxONzJ5xEo3/WM3n49AXYFrBHjZPdi6Qm/bUArDwWj/jOLFY85u?=
 =?us-ascii?Q?IHBr595qsJdIUSZLrNdFoZTqSDdXcMHcIDTFsuzi4T6mkKMTqik4XlnQcJYp?=
 =?us-ascii?Q?uUfblghVDv2Ps65Rbm4KSAblnj1CAUwBaFXSzfi4elwdjwYpkeHVgDafn7WB?=
 =?us-ascii?Q?bgaBJoZ01hJQPkk37sQ/3KfIH5Yw4LjHnoL2pb8E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c33403-2755-4ca6-fb0e-08dc4fc016eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 07:16:01.6239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJgLi1Ry5B8SJqEXVEnk4dqFMgxfR+j5pMmMzNtAmGCYJgVHzbI7q1aqzSjpWNlPdEJ3zoCo2zEGhSsjM1SbvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Friday, March 29, 2024 11:10
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: implement IRQ_STATE_ENABLE for SDMA v4.4.2

SDMA_CNTL is not set in some cases, driver configures it by itself.

v2: simplify code

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 71c2f50530cb..f8e2cd514493 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1602,19 +1602,9 @@ static int sdma_v4_4_2_set_ecc_irq_state(struct amdg=
pu_device *adev,
        u32 sdma_cntl;

        sdma_cntl =3D RREG32_SDMA(type, regSDMA_CNTL);
-       switch (state) {
-       case AMDGPU_IRQ_STATE_DISABLE:
-               sdma_cntl =3D REG_SET_FIELD(sdma_cntl, SDMA_CNTL,
-                                         DRAM_ECC_INT_ENABLE, 0);
-               WREG32_SDMA(type, regSDMA_CNTL, sdma_cntl);
-               break;
-       /* sdma ecc interrupt is enabled by default
-        * driver doesn't need to do anything to
-        * enable the interrupt */
-       case AMDGPU_IRQ_STATE_ENABLE:
-       default:
-               break;
-       }
+       sdma_cntl =3D REG_SET_FIELD(sdma_cntl, SDMA_CNTL, DRAM_ECC_INT_ENAB=
LE,
+                                       state =3D=3D AMDGPU_IRQ_STATE_ENABL=
E ? 1 : 0);
+       WREG32_SDMA(type, regSDMA_CNTL, sdma_cntl);

        return 0;
 }
--
2.34.1

