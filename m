Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0D2C369A5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 13:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2772010E694;
	Tue,  8 Apr 2025 13:38:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U8iDnKI5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4654310E690
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 13:38:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faGz9C3wbfq0xd8CPzQ358XZFbZJKUx0T8tLee4fNPupcTrpf41qf7xSd/+i4P2FOtB6xNV3Lpjtyt9/QeLStmXPjuCTE+E+bLB+VrW65VO0Er0ldqd4+FFacEihAgRPb2nSjeyZO8ZIrxRsVoMmtCZ4XnD75eE/Enuh3xq1wl9gq5wrsOIV72rQhzXuxK6C6mfiMS2f3EsOd38W10vcDYE5oL19oZs/CMGTIrjNt/CSmq4t+eCX/bCCXPZGRxeD+SCjUj9BWST9mNOO1BCou2Io0by9yS4TVvtT8pExPWR+AVfRtefDDrbWvdwZJy1YBN9Z4G6BoOWsnu/N6/IQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWlEOupJzG+jUyrqCP6YrRLoPefvcb+doT0/4LICeEM=;
 b=jndnBB3SWZdT2XIStkpNTD4/XKW+QPrw4xKVEcssV65aZzL5Zb2ZbW4o7BuMSI2I8voMO1V96/VEooS+o6t8SzMXsf7pHFNDcXbMRZPTHr3Mj7yKsTWeqjgGB8yDiof/68uVudQor1lde+XMlP7b92fOqjuXZsfxIM3xCj77yDNyEs48MdVnm8YpIwrbAsUb7wh0Dow0CS6v0BLVKl4Rv/iduMn1cG/DNXry7aB2diCZYqvP2Zr+tL3DGSHnXonlAfo9IK5tJ9IYbqoPDLoHrygalQ+w5awIWAdtXR6Vkqp9ItGZGQoQWufxyFsdmvtD5euN8CBN0+NX4z+eD+BVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWlEOupJzG+jUyrqCP6YrRLoPefvcb+doT0/4LICeEM=;
 b=U8iDnKI5E0NSHhsGMeYuKILL7rDbU0U92lJB+Q2p9rBZSuN1fqVjdnbtlvdgOUIRth2xW+ILbDp8Z4fwRJBDmN14BGNdVQAd5LK164gE13Mx5hsLK+ImwrPpTY7zfI0Q9MzOMXkoZUGxhf5VCDjHjKkCDMf9IPZ9LVcfe7V7GZU=
Received: from DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) by
 MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 13:38:04 +0000
Received: from DS7PR12MB5765.namprd12.prod.outlook.com
 ([fe80::3f49:9f92:3fcd:e374]) by DS7PR12MB5765.namprd12.prod.outlook.com
 ([fe80::3f49:9f92:3fcd:e374%7]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 13:38:04 +0000
From: "Yi, Tony" <Tony.Yi@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: Fix CPER error handling on VFs
Thread-Topic: [PATCH v2] drm/amdgpu: Fix CPER error handling on VFs
Thread-Index: AQHbo0kHsTbKDx7wS0iWH5FfcHS8mrOPx6aAgAoIlrY=
Date: Tue, 8 Apr 2025 13:38:04 +0000
Message-ID: <DS7PR12MB57651D3B27CE03BEA1D2C3F6EFB52@DS7PR12MB5765.namprd12.prod.outlook.com>
References: <20250401205901.421291-1-victor.skvortsov@amd.com>
 <BN9PR12MB525735BCB7D07D42F61E6E79FCAF2@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525735BCB7D07D42F61E6E79FCAF2@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-08T13:38:03.650Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5765:EE_|MW4PR12MB7465:EE_
x-ms-office365-filtering-correlation-id: ec827817-9e59-4fbf-c61e-08dd76a296d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?HxkwiV7vTZMNbLUPrZ7PitDbrDW4B5ZgzJM7xH+IuRQrHe6tZYHvlZO2UK?=
 =?iso-8859-1?Q?q81u1aNytkHW7mplzIxgwKbsp7WFo77y5Qp9pecY/EzbQSzRfogCR0RSSU?=
 =?iso-8859-1?Q?hN9Uof/flYw70QvcWrpvyLab3UdA0wFbvaF8RDfuAF88Jwedm7ncbg4k/K?=
 =?iso-8859-1?Q?HJwD9+iRuMzmF63j1lm8JFpkgNqBknXiUOR8+CXFn3ecWC2ktAKlXlSXwv?=
 =?iso-8859-1?Q?c7uaxRhIgqS1JEQNrVa+UNUJB+f27gFphF7c0FY8iut7NPbkA0JlZvYI7v?=
 =?iso-8859-1?Q?BVIY3Bp3TjF1C8EebkZkFFOPUg598VV5zc1qj87uplQVLmylIdHTSBTWv7?=
 =?iso-8859-1?Q?1KE4PLjALFNWQ8bLiwFaBP74NaLJ7uT8Sny484pWFwrq6gbd52ccBEmthK?=
 =?iso-8859-1?Q?ChnG6AX0ti2tM5qSdEwHZTAs6koL4n5jspWLVxNog0xZF96+qk0sSvOceQ?=
 =?iso-8859-1?Q?0qhxNEHqRoJ9JTrDnuaaVcYj5a4/geRFlu9EVE21hgrKHZnthwu7UiQHzC?=
 =?iso-8859-1?Q?YBtH5uXO/g5HU6meuI4/AhrSFaEtOq910aZBkWA0h1dQlB8s72pKXLW6CP?=
 =?iso-8859-1?Q?zh0sKk4xm/NFp7Gzwk0yGNikwvQJSKJvCUoUmgOlBZjo3dvOWihj5YaPJ1?=
 =?iso-8859-1?Q?OmAGR8nJ4+ceQR1c0YsgGG7iiW2zZZZy1Cht1COtEQ76LFEEyEcpXRTfzV?=
 =?iso-8859-1?Q?M+nllLh9FGjcfWoDqizjXJgj1+ATzmiyftwf7vpIMCNUFR6hHt/s4abmvr?=
 =?iso-8859-1?Q?4IrBngJnut7OnJMPwkkwBYqUSgdZLQdqgTVdc00MHN49H5CcEgMLq39XfC?=
 =?iso-8859-1?Q?SoZrd6iFMaL4N4mhuU9LRBxvO/pZ6lazVys+2UN3mFMQusYdtZfRvIaXHz?=
 =?iso-8859-1?Q?faovGz+42t7Mt7yRj2DhNpqelxn8Q+58lKM+JG5rfIGAsXcKo1ErLs0jjB?=
 =?iso-8859-1?Q?n+RwxWAXEccnpiQaI9M1WVAZDGkxDK5JeFm9d4cJXehxl7MpQWqgN5OFne?=
 =?iso-8859-1?Q?al8ezfomSGkhHi1eJK1EOcGcVWI/8kuvjAh/qu8PXXHG36CTabiMaseEyZ?=
 =?iso-8859-1?Q?J/ya0hIkv5zBXF4B1MMMnuO/q3A5iQnzY3nyrMsqlH85N4KybiS2FIl+SS?=
 =?iso-8859-1?Q?Pf3ys0x8FMuJf9tiG/TdiVPP933SGDT421IoeOPL+TCcv+DWWPuAsvRYou?=
 =?iso-8859-1?Q?rYMbyZ6HlAiSvQnuItEJAWAmdLeP/uh7kBCUkPQ5LlKC2DspeRAr4Tk36W?=
 =?iso-8859-1?Q?PNqAUYxhQzJp/EuAxQGFBn08RaGaItrcUHqXwjNYI5vEg/UXyJxF/G3O5I?=
 =?iso-8859-1?Q?TIk03sWqVpowi8AB/yRQqZsBhvaWvvlU7pO3uNz0YW1SlVq8XExQIfJYAB?=
 =?iso-8859-1?Q?nQ/GsWgfhJR/4sXgEBK5xig1uYW1hh7XWw0YAmWhyNLNxe4xelFByIGLvc?=
 =?iso-8859-1?Q?WXVTdQFdUdhTWygb0xgeHF5hmoAsJ5vHL+SnHTrjgdfqIrLzYNkhu/33aq?=
 =?iso-8859-1?Q?nhjVTr5+8Sc8YbrZ3V6/fa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5765.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?msDB6dQ9AsorZeMEpvtvxhhrIpH1dC/yZGDadmk3+hZly+DAMLL3JQPNk6?=
 =?iso-8859-1?Q?YuwRtd+S3tniOiuGrmSRheslIg+9Clz9x8wD8DjqLtNQp5ZZeos8MOjMwE?=
 =?iso-8859-1?Q?Ro7LFhiNy0MsjIS227FahehBMip+Bd8y/c7vY97UPieF7zsFic8uUPgeoL?=
 =?iso-8859-1?Q?I5m95bt4V5gwrOhwi1hieIcv0Ub1O7AbjIPtBa9Gf8OHi//wnNSdkSQN1y?=
 =?iso-8859-1?Q?FFNeX+ki/xuSGtTDZFdZj33MMfnkjAAXnuEP/aVHOIc9Di2GsOLOwX+EiM?=
 =?iso-8859-1?Q?kwygFN29O155FubLXYlYHiDAB/V3tJCZEZbm5T01EymYcWVUBYT6No6b4v?=
 =?iso-8859-1?Q?xr5TOe+551uzfwxU01tdaN32xXUGOuylDusQoudD/6/C6TntWgk7s6tBiI?=
 =?iso-8859-1?Q?d6Fc1fylJ/jQkbTathSfaHDn34L/UXdSr+t/lOsiudZeKu/MBxDD7SoF2D?=
 =?iso-8859-1?Q?egqxA9Tp7y4U42HrucAmkme2NUYP2VALLUcQ1kfOlWrINWl9Dz6KsSa13Q?=
 =?iso-8859-1?Q?7WwcNB+TCW1omCA/OhukMPiY+OBx4po4ml4hjBmSlozVLbxqOVf29HRHyT?=
 =?iso-8859-1?Q?5bzgEMo/694MH+AmJFCSTNOfEs85tGtKATc1ZV6/Hi15qH4ki458VqqZXL?=
 =?iso-8859-1?Q?tSEwFTKzf4rjrTHLtVXVWQNsFGYrUPCvGlHavlUDPQOXtRdy6gfPmV4KqH?=
 =?iso-8859-1?Q?KI5x0XTISCNS4xaqu+Pm7dnSKILdVYA8UwgnOtt/tQqTxeBTX2Z86BLY2i?=
 =?iso-8859-1?Q?67BUn3H4D5kb214/oljmsSYTE247/OJSPiStjOWZ2+Wl5oswqLjkNS/Mhc?=
 =?iso-8859-1?Q?wCFx/M766kitRRx4Dlb7Li0N0XzLKSu03X5U2QieVJsfWhHy/ztAQ2XaPC?=
 =?iso-8859-1?Q?7FRJcdQ+iZBBdoqfHGmzWVPkxI/sjggN85z6QmIzPAG6CIOA41QCM+mHVQ?=
 =?iso-8859-1?Q?kLtbyjVZpR0Fp8/2fQ1ar4mrwdBwBhkhbqQc4afnAneHydXBTYoynsDmsW?=
 =?iso-8859-1?Q?zltspMV22pMY3Ud9ul62A1a3SGtbcE58RYVI+IPqRCFgX/cpQVHMRqHIqe?=
 =?iso-8859-1?Q?wQMr/F7KS/jt4uYvcunMNggjA6x8PMjzmiPFCgjUBMRKhxV+7svsBpjcDw?=
 =?iso-8859-1?Q?Vs2NKGPRSwVyegDkw297P35Wto+nRq7IPwVVk+7j+JRQ4CTPHFdaMACZQm?=
 =?iso-8859-1?Q?cg2w+8zjSAIrQ+uDoOhL80t03TLNQbQ0Z2Mg7h37f41V4YapvAO4G6tm+d?=
 =?iso-8859-1?Q?LGC4IiFDAN/RSI8ymzMc/dDcuKRUUW2dSZ9HisVvEVgG3dW0vjXeh6GH0r?=
 =?iso-8859-1?Q?SwenQwvZbzpc8a4rqfvTBRnQko0qPVsMghaQJCaiSwvwFXb59W17uPrH1w?=
 =?iso-8859-1?Q?WBcTtmDcAYxhyvfR0S8pAivv6M6DEF51r0Cg3XnHtvEG5sxi9CDJ281MVl?=
 =?iso-8859-1?Q?qs8d5fisyIKrPG+/TJ8iZz5chRyyv+RXkDWviDU9xzmg/VR/f+OHyIyD3W?=
 =?iso-8859-1?Q?klbatM7afjJ34Bc6XHx7xQulo0ndulL/UDg6mVxbBOfbdgc6SLWeXesl72?=
 =?iso-8859-1?Q?jveEEHvi8hZpADfh0gfGyCO5hSU8y+WwPmh/2xnKXmGp5ArW1H85dLMz31?=
 =?iso-8859-1?Q?l7hmXM0CcJ3sQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB57651D3B27CE03BEA1D2C3F6EFB52DS7PR12MB5765namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec827817-9e59-4fbf-c61e-08dd76a296d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 13:38:04.3470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74H6k4xZRjNUxuxFhMbg1xOrx1C0cFwW8Oz5+1/0syBO0nwqbitdgOwn2giUWOjvoyR0qn2PcjUxiiA5uT9nVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465
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

--_000_DS7PR12MB57651D3B27CE03BEA1D2C3F6EFB52DS7PR12MB5765namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Signed-off-by: Tony Yi <Tony.Yi@amd.com>


________________________________
From: Zhang, Hawking
Sent: Wednesday, April 2, 2025 12:24 AM
To: Skvortsov, Victor; amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang; Zhou1, Tao; Zhao, Victor; Yi, Tony
Subject: RE: [PATCH v2] drm/amdgpu: Fix CPER error handling on VFs

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Wednesday, April 2, 2025 04:59
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>; Yi=
, Tony <Tony.Yi@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix CPER error handling on VFs

From: Tony Yi <Tony.Yi@amd.com>

CPER read will loop infinitely if an error is encountered and the more bit =
is set. Add error checks to break upon failure.

v2: added function pointer checks

Suggested-by: Tony Yi <Tony.Yi@amd.com>
Signed-off-by: Victor Skvortsov <Victor.Skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 0bb8cbe0dcc0..83f3334b3931 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1323,6 +1323,9 @@ static int amdgpu_virt_req_ras_err_count_internal(str=
uct amdgpu_device *adev, bo  {
        struct amdgpu_virt *virt =3D &adev->virt;

+       if (!virt->ops || !virt->ops->req_ras_err_count)
+               return -EOPNOTSUPP;
+
        /* Host allows 15 ras telemetry requests per 60 seconds. Afterwhich=
, the Host
         * will ignore incoming guest messages. Ratelimit the guest message=
s to
         * prevent guest self DOS.
@@ -1378,14 +1381,16 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_devic=
e *adev,
        used_size =3D host_telemetry->header.used_size;

        if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
-               return 0;
+               return -EINVAL;

        cper_dump =3D kmemdup(&host_telemetry->body.cper_dump, used_size, G=
FP_KERNEL);
        if (!cper_dump)
                return -ENOMEM;

-       if (checksum !=3D amd_sriov_msg_checksum(cper_dump, used_size, 0, 0=
))
+       if (checksum !=3D amd_sriov_msg_checksum(cper_dump, used_size, 0, 0=
)) {
+               ret =3D -EINVAL;
                goto out;
+       }

        *more =3D cper_dump->more;

@@ -1425,7 +1430,7 @@ static int amdgpu_virt_req_ras_cper_dump_internal(str=
uct amdgpu_device *adev)
        int ret =3D 0;
        uint32_t more =3D 0;

-       if (!amdgpu_sriov_ras_cper_en(adev))
+       if (!virt->ops || !virt->ops->req_ras_cper_dump)
                return -EOPNOTSUPP;

        do {
@@ -1434,7 +1439,7 @@ static int amdgpu_virt_req_ras_cper_dump_internal(str=
uct amdgpu_device *adev)
                                adev, virt->fw_reserve.ras_telemetry, &more=
);
                else
                        ret =3D 0;
-       } while (more);
+       } while (more && !ret);

        return ret;
 }
@@ -1444,6 +1449,9 @@ int amdgpu_virt_req_ras_cper_dump(struct amdgpu_devic=
e *adev, bool force_update)
        struct amdgpu_virt *virt =3D &adev->virt;
        int ret =3D 0;

+       if (!amdgpu_sriov_ras_cper_en(adev))
+               return -EOPNOTSUPP;
+
        if ((__ratelimit(&virt->ras.ras_cper_dump_rs) || force_update) &&
            down_read_trylock(&adev->reset_domain->sem)) {
                mutex_lock(&virt->ras.ras_telemetry_mutex);
--
2.34.1


--_000_DS7PR12MB57651D3B27CE03BEA1D2C3F6EFB52DS7PR12MB5765namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Signed-off-by:&nbsp;Tony Yi &lt;Tony.Yi@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<div class=3D"elementToProof"><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Zhang, Hawking<br>
<b>Sent:</b>&nbsp;Wednesday, April 2, 2025 12:24 AM<br>
<b>To:</b>&nbsp;Skvortsov, Victor; amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b>&nbsp;Luo, Zhigang; Zhou1, Tao; Zhao, Victor; Yi, Tony<br>
<b>Subject:</b>&nbsp;RE: [PATCH v2] drm/amdgpu: Fix CPER error handling on =
VFs </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Times New Roman&q=
uot;; font-size: 11pt;">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
<br>
Regards,<br>
Hawking<br>
-----Original Message-----<br>
From: Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;<br>
Sent: Wednesday, April 2, 2025 04:59<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Luo, Zhigang &lt;Zhigang.Luo@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zh=
ang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Zhao, Victor &lt;Vic=
tor.Zhao@amd.com&gt;; Yi, Tony &lt;Tony.Yi@amd.com&gt;; Skvortsov, Victor &=
lt;Victor.Skvortsov@amd.com&gt;<br>
Subject: [PATCH v2] drm/amdgpu: Fix CPER error handling on VFs<br>
<br>
From: Tony Yi &lt;Tony.Yi@amd.com&gt;<br>
<br>
CPER read will loop infinitely if an error is encountered and the more bit =
is set. Add error checks to break upon failure.<br>
<br>
v2: added function pointer checks<br>
<br>
Suggested-by: Tony Yi &lt;Tony.Yi@amd.com&gt;<br>
Signed-off-by: Victor Skvortsov &lt;Victor.Skvortsov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 16 ++++++++++++----<br>
&nbsp;1 file changed, 12 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index 0bb8cbe0dcc0..83f3334b3931 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -1323,6 +1323,9 @@ static int amdgpu_virt_req_ras_err_count_internal(str=
uct amdgpu_device *adev, bo&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_virt *virt =3D &am=
p;adev-&gt;virt;<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!virt-&gt;ops || !virt-&gt;ops-&g=
t;req_ras_err_count)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Host allows 15 ras telemetry =
requests per 60 seconds. Afterwhich, the Host<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * will ignore incoming gue=
st messages. Ratelimit the guest messages to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * prevent guest self DOS.<=
br>
@@ -1378,14 +1381,16 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used_size =3D host_telemetry-&gt=
;header.used_size;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (used_size &gt; (AMD_SRIOV_RA=
S_TELEMETRY_SIZE_KB &lt;&lt; 10))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cper_dump =3D kmemdup(&amp;host_=
telemetry-&gt;body.cper_dump, used_size, GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cper_dump)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -ENOMEM;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (checksum !=3D amd_sriov_msg_check=
sum(cper_dump, used_size, 0, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (checksum !=3D amd_sriov_msg_check=
sum(cper_dump, used_size, 0, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *more =3D cper_dump-&gt;more;<br=
>
<br>
@@ -1425,7 +1430,7 @@ static int amdgpu_virt_req_ras_cper_dump_internal(str=
uct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t more =3D 0;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_ras_cper_en(adev))<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!virt-&gt;ops || !virt-&gt;ops-&g=
t;req_ras_cper_dump)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
@@ -1434,7 +1439,7 @@ static int amdgpu_virt_req_ras_cper_dump_internal(str=
uct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev, virt-&gt;fw_reserve.ras_telemetr=
y, &amp;more);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D 0;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (more);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (more &amp;&amp; !ret);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
@@ -1444,6 +1449,9 @@ int amdgpu_virt_req_ras_cper_dump(struct amdgpu_devic=
e *adev, bool force_update)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_virt *virt =3D &am=
p;adev-&gt;virt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_ras_cper_en(adev))<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((__ratelimit(&amp;virt-&gt;r=
as.ras_cper_dump_rs) || force_update) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; down_rea=
d_trylock(&amp;adev-&gt;reset_domain-&gt;sem)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mutex_lock(&amp;virt-&gt;ras.ras_telemetry_mutex);<br>
--<br>
2.34.1<br>
<br>
</div>
</div>
</body>
</html>

--_000_DS7PR12MB57651D3B27CE03BEA1D2C3F6EFB52DS7PR12MB5765namp_--
