Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6E3E9E31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 14:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13ECF10E089;
	Wed, 11 Feb 2026 14:47:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R5Amfdlr";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012010.outbound.protection.outlook.com
 [40.93.195.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B9710E089
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 14:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpuDIX2F8zTOBc8PtsJdQKWvuvtQhhWo/Pt65SnjM/M3VLVacDthXfUzhtJM+O63u8V9zqUAOqSzO1srE+pnHX66kz9WYFuvemx4Ka29EGnaKWJ+k5fIxyLPmTsUC1hB1EczagWQ3yJv/ncnt6WPxxlB+nf2BL9DUz9LVS8gvVoqsq+sVEe5GGFYwo86TuVNO+d6Z6U6CTumbtDptcOCCubRueDFSiePISlZ5lI2XrxYi8hGvTTlbpgdD8NTXY8U1MF33HwI1xTV4FEkgC02z3C0R3WBMkd8QIO6sic1m+JQ1hiqRe12iy5lm8sV+1CfGTSWg9O2+msoXD4N2oBpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIqYGE5L+WVlkF2KT0FWzIdKTYb9MsZnbFqRtXSR1eI=;
 b=SvXXCohd4X4tDzbKwV/9/6RW+wz6MMGvi3g4wlHChadGH/8tE5N0Gr46GYw3T23hDZB936fJnH90ZMs0ElB01GfL+dEnbOczq0MbXx7lOjDOqbzNZJVasAqpse9hKhdGIOs0fr0SqAz0li8JY+m4aa6eU2f3FZFoOnSvA+Q1eMuKxpUUtBtOoGl1UWkEkwqZZ2wi20vs9teb+T73FDMboKhzScr7nGFpEerqXstwuSWkbIQ/fMNpcnvhZGmU03mTmI4uS8MTFZHao1GZDhDcvSDjDiP+TUEgt3uWi3ceoNe8UPEDgHuCwLV+38r0+3ypoL//3wn+i9sL7GqJ8WH2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIqYGE5L+WVlkF2KT0FWzIdKTYb9MsZnbFqRtXSR1eI=;
 b=R5AmfdlrPe+D5lDJqzevqw/tbyd/rgwtlsZ57dv9uf5XdqH7atANaHhLzmEEmAsxAiylGM//IDoM4/wMi3jHwi+6vStbKBlTB5jcNtD0Sr2UYWfmll0wz8k4H5ogBRtI3639WCZZS+jnK+9jPr1FCGn+JAw39yeesCwMZgiYH8c=
Received: from DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) by
 IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 14:47:19 +0000
Received: from DS0PR12MB8200.namprd12.prod.outlook.com
 ([fe80::7a0d:c013:6aee:c8d6]) by DS0PR12MB8200.namprd12.prod.outlook.com
 ([fe80::7a0d:c013:6aee:c8d6%7]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 14:47:19 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, Mario Limonciello <superm1@kernel.org>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>
Subject: RE: [PATCH v3] drm/amd/display: Fix out-of-bounds stream encoder
 index v2
Thread-Topic: [PATCH v3] drm/amd/display: Fix out-of-bounds stream encoder
 index v2
Thread-Index: AQHcmwJqc7aTVXj3TUCG/x0ty1LAe7V9lCxg
Date: Wed, 11 Feb 2026 14:47:18 +0000
Message-ID: <DS0PR12MB8200E071E9D73D5CA04C853C8963A@DS0PR12MB8200.namprd12.prod.outlook.com>
References: <20260211025833.1544179-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260211025833.1544179-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-11T14:45:52.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8200:EE_|IA1PR12MB8494:EE_
x-ms-office365-filtering-correlation-id: 81381391-0155-49f2-1ab3-08de697c74c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3+2ZgyYI5CQBqBIq0C3VeSR9X7N/LtTvJGGQse5CfUDftitWPZOq9z66ej3s?=
 =?us-ascii?Q?SY82BxVopNev6ZE3R3ttGdYuIkKX7q6k5HiBIjdCXsQPBwypOsq8sJ9il/rw?=
 =?us-ascii?Q?w7UNY7bBdNaA3ye67B7g/7ssmFCSVr1m8GTlekB1SXPZnZCBl8Vsdy6P+gGr?=
 =?us-ascii?Q?DyC0Zy6b9nZxO0JLplK+sHYkea45qeqDETRl2WRoRcdCincDs3PSeFjEBpvu?=
 =?us-ascii?Q?WxF0I2w0OLrML6Wt1rEVFbGOGozNpXpeCkoW/PdTQkwl0dcsooUWopVqkNgr?=
 =?us-ascii?Q?lFpS7ybW2evRKbXvu/QmJ+kQ2HhI5hldB207omjP4TQOb6yypLol3iFaQG2Y?=
 =?us-ascii?Q?09FFrl3LWyH/Ut9OcNssE79meWd6o0y8yi85BEUjb46rga7nNbZwc6eFbrh3?=
 =?us-ascii?Q?YzogXtbcH2DB1FvMpxT+uRdiNgu68SviVPgDhHUybnSEXpujnalfWvpkTN/e?=
 =?us-ascii?Q?MdzyKR6c3B/fw0g0WrykV15Gvs9uEEBmcUyB6BUy1jOu8iDu0RwWS9m5uBAA?=
 =?us-ascii?Q?xjd39BT8Euwx/y75+TcgcwcZMMv58Wc3v+QMCF2QrEekRV1tEG02qp5Qop54?=
 =?us-ascii?Q?8+LyvT/UBqAkZ0ELPFUr4dLuQN/G4jRYo/aOTJZv81XcDZvG+p7eWcGQ5wGc?=
 =?us-ascii?Q?026ZIKV4jZhVjT/84dh8d6at1DLQBw/9XY5l/AczPU20hJ5yOUxXQXnoK5ym?=
 =?us-ascii?Q?MC4gAuRu/+L/wS6bKfFP3Na2AFzirQX3bj/Z8HA5H0e48QQCyERmVzzVdSr1?=
 =?us-ascii?Q?/VlY93U/IwvgLTD/LHLgu/kwImlmBskqeFVyWen05bgZBOB08kBfA+EzAi6i?=
 =?us-ascii?Q?vdMNfX5vr4hkevOoxWjl2j7bZS/b2ysiVI0/0RfnSspbKaHwZC14v/f2ANx3?=
 =?us-ascii?Q?oefFSwDAr4cX9+WbVLBkBPALvE3a7AP/hw0rRUppAqqFoL2dqpZ++HL/ASue?=
 =?us-ascii?Q?DHTCdeOYhF/RWxlsLh5mk6CYBl/l+VIuP75RepXTV0wEfMlbwFs8YHijC+9x?=
 =?us-ascii?Q?8uhHOy3Mz/WZWWlFsHsez+HK6hvVHlxpqiTcUEQSOEArXYhEDtL/qDffLlcX?=
 =?us-ascii?Q?Tt3oX2jORBhj+Vp8Mno1SMMhfT1wGUpZBHuBrDo+9S4fLvFnFlsbUW5EcQRH?=
 =?us-ascii?Q?Dgx0uEZMjYDa89fSTmai4zQqZP736HtzYvsafaJR5t8VZJMw0pON2L4tsqAR?=
 =?us-ascii?Q?jKj3RTf+JACtlCVJWnVq1io17pVG9vPop4v4XYaVgoQmnq7NEEpIqRFkhZb8?=
 =?us-ascii?Q?a/U4c5p2jx5DWgJICdCvek47z+ElBShrJwHygG8hvAhZMJkkU3MzO4pio20A?=
 =?us-ascii?Q?RmONscepwjpOfBMpvpy3wlZmmqI9N5W+MaURMjDjXlnbdfBA9Y8g6mE9jCkl?=
 =?us-ascii?Q?/WduFhOg2bAWFIaLckMBDBtynUGxcogewTzU3H/QsY/1oTB5i79MZ4ZIeZkD?=
 =?us-ascii?Q?y6griMwtuf8jD4DAepjSl0PoT9R5vUjoTlkPQs76jGz31ju8WrtYsc/VX3+f?=
 =?us-ascii?Q?G6S9R5gup6F7n5C7h4QdXTGHpSbMmJDnSYrn2a2oZdigoJksIMlzpcd2Ajkl?=
 =?us-ascii?Q?OOBGjfwmUqFa0FA9M2V3t4ZN4m2S+23ayGBBKZIOjMZDzDJPF+/+AHb3I7P+?=
 =?us-ascii?Q?wxwcUfIt7Pr6GSDQ5cAi/fE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8200.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jzRwZR+nmCoqetB6muwIIwdmgLeE+M3bk6JjfqMtf1wz5+a6WWXT+yFVTCcD?=
 =?us-ascii?Q?yYmjAEjTiKxiVhIbYxSOlixYE3D5ghRoGPK4mxtuYCi0nLdGX2oqxLmQfd4e?=
 =?us-ascii?Q?sSXyup1GTTXlZzX6+/EuBfVlfpwBI/zT7WUEwHyFXrsvZvgJzHJna3HZse8a?=
 =?us-ascii?Q?NtWIxZWtIv5DALqZQ3QB3ft5AjozeSb4DsUu0z6vqZMxlY0ICWn1XG/WlEsG?=
 =?us-ascii?Q?esl3fMkoTcEotE0Xvxm5+IrAu+0GAHxThsgXD4WzfYUM2VDKNVZv86kxcmCh?=
 =?us-ascii?Q?ZmYrCerEZ+g5REiUGZG58t+G66Ww9wyLl8pOtq4BWg4Ml2DRKR1zgvDz5VOC?=
 =?us-ascii?Q?coI5ZU/M0P3ftxrqQB35CeSUYztIqZlvq1mal1lld42JNF1e2w91WuEvjlDP?=
 =?us-ascii?Q?FedZgib1Pdn6vRF0fCbuPpXRiPUBCPAQ7DCciVu5ogoackA/VHdDP21Idj1R?=
 =?us-ascii?Q?oQkwOoXrGh81vM+ARaw3YPKBO/xVJVbAv4fRc1ZHx/NV4fACwuGUKGa3c8sv?=
 =?us-ascii?Q?2sxRYu2iVSslIIcl/NfmD2l+xm9LiFehQZBPujxayLlxR28wviHcFHJtb1kf?=
 =?us-ascii?Q?SDbvKTs8s7fDQ9f4advdYZqVE/3Jr0UoCx92R1Ysj2Bm339AzLuGMUE5rkOj?=
 =?us-ascii?Q?AJWkHtlTsWa9MxAOfY+z6BHnB6LmU/dhSz0arfzy9gFzhJqNGZEhQ1wr4prt?=
 =?us-ascii?Q?NNOnym8Kaf+hIQsNFzlLDUdnTU6tyELfTpxYsJQ+zolwr50/U7Tky1LNqPcj?=
 =?us-ascii?Q?45FwKTem1hIzGtlhQeEYUiIJi7wLxz34XpaQQo7e5RWrOolqUIl8ltHJEo/e?=
 =?us-ascii?Q?nTeYSp2PhURrmtoHh+oXtUiZuimiOgKryWDfSJLP55tA9BRKcxopR+AKfs8H?=
 =?us-ascii?Q?oeBNjVBg0P15Epj5RJNj80CH3/ANltHDWzmbdVDizuHATCm0BQyMMfh999ST?=
 =?us-ascii?Q?mwYpmuo6R9Z9AIpdfmPnu5fd9ZubJHKLINwXlJuTIlkRq8DjKhG0pQdfpIto?=
 =?us-ascii?Q?iAMglHPNs5+cLQpcUwowgvxuR2xVx7/d6pe9++SFmC2osj9lSXKibw+XJZKg?=
 =?us-ascii?Q?7febPSccpqUhbk4P6sCpNC5Sek5rff1xmimSo/PHz/oNh1CwKKBLmu+azY8M?=
 =?us-ascii?Q?emEgvB+MIbDYgHrsfGaLaGlSxW9oUIwi6Dcu3Pbb/cFRb7VafT3QcWiOX4aU?=
 =?us-ascii?Q?OXg7LmAbPN6HxVOnnB4vPJL0gsJ7hevfiDx4NMayu7gHc1+HPlwExsq5fLGT?=
 =?us-ascii?Q?pv88gL3MJaCvdgvENITuHTgvQqZ90/TIho457SS2YN4kV5S7KWxxsHjXJeoR?=
 =?us-ascii?Q?+cSwUtRcwTeAekF+xduHu1ph9M5Qi11PCAUJh9cDXKc3Zkmc6VN2lUF3WqnC?=
 =?us-ascii?Q?J+CryXZm0cBFWh6hmD8sy2knod8e8mPTeIu8gd/LWpWevg3+E/vxRSFPZa6D?=
 =?us-ascii?Q?v8+BfwaHLjY2RWhcANyJ2uIHVrnIJGyodoCwL0yT4ffWiIT9mltRulTRYdER?=
 =?us-ascii?Q?XX1BY6B12dKbxPvYqEm/bOidED7mtEdhQThVFuV3qJ9ziK2jhYeUQH/8Gifk?=
 =?us-ascii?Q?uD/Dxuiwgs3ZJ/QjfoYKCX4ZveIJq3xI8HSzc548N4ECVpiipgqe+QTmd0+q?=
 =?us-ascii?Q?PIwyKBqsyeTtrB56pyUcSWa43n2NhihB20IzcV4AnfOBuComA3DG5FrDf+Z1?=
 =?us-ascii?Q?nft4NoQHbDObmw6RaUkLImqvcQjLW11D2kWVt+o5Hg4Fpe+y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8200.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81381391-0155-49f2-1ab3-08de697c74c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 14:47:18.8874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RTQPtBgzLDw63tputhk6+HUDBUK2D0KWfUCe6EalPj1IGY0/H9YVIBDonpE5pYOw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494
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

[Public]

Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Tuesday, February 10, 2026 9:59 PM
> To: Hung, Alex <Alex.Hung@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Dan Carpenter
> <dan.carpenter@linaro.org>; Wentland, Harry <Harry.Wentland@amd.com>; Mar=
io
> Limonciello <superm1@kernel.org>; Chung, ChiaHsuan (Tom)
> <ChiaHsuan.Chung@amd.com>; Li, Roman <Roman.Li@amd.com>
> Subject: [PATCH v3] drm/amd/display: Fix out-of-bounds stream encoder ind=
ex v2
>
> eng_id can be negative and that stream_enc_regs[] can be indexed out of b=
ounds.
>
> eng_id is used directly as an index into stream_enc_regs[], which has onl=
y 5
> entries. When eng_id is 5 (ENGINE_ID_DIGF) or negative, this can access
> memory past the end of the array.
>
> Add a bounds check using ARRAY_SIZE() before using eng_id as an index.
> The unsigned cast also rejects negative values.
>
> This avoids out-of-bounds access.
>
> Fixes the below smatch error:
> dcn*_resource.c: stream_encoder_create() may index stream_enc_regs[eng_id=
]
> out of bounds (size 5).
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn351/dcn351_resource.=
c
>     1246 static struct stream_encoder *dcn35_stream_encoder_create(
>     1247         enum engine_id eng_id,
>     1248         struct dc_context *ctx)
>     1249 {
>
>     ...
>
>     1255
>     1256         /* Mapping of VPG, AFMT, DME register blocks to DIO bloc=
k instance
> */
>     1257         if (eng_id <=3D ENGINE_ID_DIGF) {
>
> ENGINE_ID_DIGF is 5.  should <=3D be <?
>
> Unrelated but, ugh, why is Smatch saying that "eng_id" can be negative?
> end_id is type signed long, but there are checks in the caller which prev=
ent it from
> being negative.
>
>     1258                 vpg_inst =3D eng_id;
>     1259                 afmt_inst =3D eng_id;
>     1260         } else
>     1261                 return NULL;
>     1262
>
>     ...
>
>     1281
>     1282         dcn35_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bi=
os,
>     1283                                         eng_id, vpg, afmt,
> --> 1284                                         &stream_enc_regs[eng_id]=
,
>                                                   ^^^^^^^^^^^^^^^^^^^^^^^=
 This stream_enc_regs[]
> array has 5 elements so we are one element beyond the end of the array.
>
>     ...
>
>     1287         return &enc1->base;
>     1288 }
>
> v2: use explicit bounds check as suggested by Roman/Dan; avoid unsigned i=
nt
> cast
>
> v3: The compiler already knows how to compare the two values, so the
>     cast (int) is not needed. (Roman)
>
> Fixes: 2728e9c7c842 ("drm/amd/display: add DC changes for DCN351")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Mario Limonciello <superm1@kernel.org>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../drm/amd/display/dc/resource/dcn315/dcn315_resource.c  | 8 ++++----
> .../drm/amd/display/dc/resource/dcn316/dcn316_resource.c  | 8 ++++----
>  .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 ++++----
>  .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 8 ++++----
>  .../drm/amd/display/dc/resource/dcn35/dcn35_resource.c    | 8 ++++----
>  .../drm/amd/display/dc/resource/dcn351/dcn351_resource.c  | 8 ++++----
>  6 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resour=
ce.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> index a8283f21008e..3ae787a377b1 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> @@ -1230,12 +1230,12 @@ static struct stream_encoder
> *dcn315_stream_encoder_create(
>       /*PHYB is wired off in HW, allow front end to remapping, otherwise =
needs
> more changes*/
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if (eng_id < 0 || eng_id >=3D ARRAY_SIZE(stream_enc_regs))
>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn31_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn31_afmt_create(ctx, afmt_inst); diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> index 4da0e9320159..4b8668458f03 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> @@ -1223,12 +1223,12 @@ static struct stream_encoder
> *dcn316_stream_encoder_create(
>       int afmt_inst;
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if (eng_id < 0 || eng_id >=3D ARRAY_SIZE(stream_enc_regs))
>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn31_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn31_afmt_create(ctx, afmt_inst); diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index d3b92c61b7ad..a55078458ba5 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -1211,12 +1211,12 @@ static struct stream_encoder
> *dcn32_stream_encoder_create(
>       int afmt_inst;
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if (eng_id < 0 || eng_id >=3D ARRAY_SIZE(stream_enc_regs))
>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn32_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn32_afmt_create(ctx, afmt_inst); diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> index d08691ea27ea..188c3f24f110 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> @@ -1192,12 +1192,12 @@ static struct stream_encoder
> *dcn321_stream_encoder_create(
>       int afmt_inst;
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if (eng_id < 0 || eng_id >=3D ARRAY_SIZE(stream_enc_regs))
>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn321_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn321_afmt_create(ctx, afmt_inst); diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> index 945da8cffada..5ea805fcff48 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> @@ -1274,12 +1274,12 @@ static struct stream_encoder
> *dcn35_stream_encoder_create(
>       int afmt_inst;
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if (eng_id < 0 || eng_id >=3D ARRAY_SIZE(stream_enc_regs))
>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn31_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn31_afmt_create(ctx, afmt_inst); diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> index e660889904a9..424b52e2dd7b 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> @@ -1254,12 +1254,12 @@ static struct stream_encoder
> *dcn35_stream_encoder_create(
>       int afmt_inst;
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if (eng_id < 0 || eng_id >=3D ARRAY_SIZE(stream_enc_regs))
>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn31_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn31_afmt_create(ctx, afmt_inst);
> --
> 2.34.1

