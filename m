Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A06CD4F52
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 12:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A576710E7DC;
	Mon, 18 May 2026 12:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zdz8AvHP";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011065.outbound.protection.outlook.com [52.101.57.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3632210E7DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 12:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmC7MCPk4TbarbxbMBQgcqVo7ldImPmgetRyYzXOWe65zzDxVGm2gzKdj5OLWXW3TU1rnL8bxkvGkpSXTCwk7ABWCsR3L4PEiZyhoyn5R9sark8UecURNVJgf1kV5f2UpR09uCDD8kF+ePzGBys51exzdLKw8bx6Ipy+yNzRdpvJqSvj4GKiQZ3WIkdv/91vYGX3Ov4Y7IO67wjSVM0naxiA858hZ6hBGpu9/QEoMnZpcgAqhflcKFFyHsbJrt5M5NLzEU+HPQTXPPuDhk67Ak09OCug8pf+E8TwnZMl2trPtkv9P1e8aJUdnS/e/qwu1q87XcZUKhuun36WsqTF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu0o8sz5RkZSYJ7wG2ATYRn+Ym8J9pCEQAbJkPKmfJI=;
 b=Bh0hL+QDQjaCDNViYGH39qOAawYRt/QkhP6i34T+ib8O+TjUHPTh0jdpPbkQwoBq4O2UF2AideST0+rkDlkv8Co3NdDkcNwJCBtYops18ulOrCbVucuMTa057d2Pk7aJhLUlQ9bBqu+nxwmS/BxCD0L+5bjSjMqjxJk3UIKFFNOINgc9sOJzMxWHiqodx/qK60jQsjUmtt+Ddr2DrJjystNfAUGJLRHFQuqUIvepInYliLmGnH1l2PJfxl2jljSKyvQn8qbPKqaetxTIEulfxto1vGouycmKAvr3WavJ7tKvssaP8mUi9kuzEEeyWf1YgDuGZthjS5ZlKaaCunvLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu0o8sz5RkZSYJ7wG2ATYRn+Ym8J9pCEQAbJkPKmfJI=;
 b=Zdz8AvHPaL8isIylkvQP+RoHk3i3WB9c7ktn7e+tWKoN/f1IVtyMlEd2kFKXB5RpmBr1p4Yzbmo1+Cb262G/JuR1UwEzpE1lOjI/UXOuq8oKuE1u2FcMmet/SFRMKGyqbA6MsO7+eZxUICaLSBLpeJOjZXjKkHkratrvbAvuwdg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 12:14:27 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 12:14:27 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amd/ras: Add more IP versions for uniras
Thread-Topic: [PATCH] drm/amd/ras: Add more IP versions for uniras
Thread-Index: AQHc5pVKhPX36P+6hUaLlZZwlCcQ1bYTsogg
Date: Mon, 18 May 2026 12:14:24 +0000
Message-ID: <PH7PR12MB8796300027B229EB390A6661B0032@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <cover.1779087990.git.cesun102@amd.com>
 <9bee8531980fe38fe2a831398b3b3a335bd69fb2.1779087990.git.cesun102@amd.com>
In-Reply-To: <9bee8531980fe38fe2a831398b3b3a335bd69fb2.1779087990.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-18T12:14:17.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MN2PR12MB4221:EE_
x-ms-office365-filtering-correlation-id: 304074e7-18b7-4155-f2ed-08deb4d701fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|4143699003|11063799003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: ximmsYt89igpB70Jtca2NE1iEzeh3Q6ODeIarpfAUISz8P5UlUi+9/J3PmkZqGFnm/9j9WLK6jQlg+EKB9/QiK+DWHdxg58yvGNaR/X2+0jE3jHYDkE8chxeJIQR0HH4/OF2ZhZ7rUIxuP+WzIpnqfUzqmlFdR2WyRRclk7fGJjRhLGTSJlv4drxFDICIwEUDCDFy8CjUn1qVNv+vhC6G+Xymsia8EiS/oT2U+CkxSfE0lz1f2tfzqo0kqK8cd/+VFa0/CZtDJ+JHZOSMoDKuvyQBEeXbHr3/nZnmi53Zprrx7MltS9ROAYEtvQYG6LsT4Dud7eO7mZg/uS+rDcQGlGBqWq0Tt8yJE6jiZzDMekdKglfxhSPsyhl4YDZjizCToaaPU2E9l3y9OiS4AHHOrP2luVYsvrX+VE0cz7aju0W6eC0KfOv+7PBXnBzesFr7X3T8gu+LBWtj4X5ZMVr9x3mNXHkgZW6iegZj26MBKjafBtKYM04vGgyzjYbcfZq9K3YBG0UJJjmzq2c/MG9AD5XQSz44NO+5JC/pr/1DvopcDjY1wGF05Sm/zZhggnYwt08W8dwfpoFO/PHeMZU1inKtWC8ZRXStryBAQ8K27pd7cuySFPQC97GBnZeGOkBz8IhZ82zlWpG0Ug818Z9o1r7W5zcL1HoEaXJAIjX9FOvYH87u/sQ9h/Ul9jhKoV45NYDjID+wQOCQSB6blJi1V7NSOY3VASd1VM8ZGyEcpYzqOYwHY+ElCvPIEuNhEyd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(4143699003)(11063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NTq7ReDDP1H+EsN+EeSjuY569V5mj3X5lG9RYFdxnVJzlxq84YgCUftxXqWm?=
 =?us-ascii?Q?7aZlWcayOepaRE3cITOSf7MP5yJb++tWF/91NkmpIGsDEcDb7XyaRuQHtQUf?=
 =?us-ascii?Q?DxPfeQhbRxAFSpKiny0mXrOrPv2Apm/dx+3NKPUWSpunCd0n0YXOu5JHY/IE?=
 =?us-ascii?Q?+2VJphmCx+TAZApm5IiYE8n0sabLPc6FBKtDkigSaAAGPS27eEfP+alHhVU9?=
 =?us-ascii?Q?kHbylgRgDSIF70DCnCCDzXYIlwex9HTiMnKIiDqiTsFDHkNT3OGGj8H+zLHu?=
 =?us-ascii?Q?3r7gIFT3DsRn+axtKQR+Bpk2m5JYYl3U6cX1sSfskd7cgKUiL2vGoxx7+zkC?=
 =?us-ascii?Q?2nCx92c5I9rnEiz4SUHRH0Q9Bu1hVszhu3xAQrbiGwr0avAjOOfL3AMOa86C?=
 =?us-ascii?Q?YV7fZ8weKemDcwWH9TD/piUIghpzF4gen9MnGtB3ukY8hz6kcIBJWXi9wl3a?=
 =?us-ascii?Q?P3O44lo7zyG/18WmckuzVMvCN561nQwj17eY2pCMbKaArDo02OTH8NgAYB4J?=
 =?us-ascii?Q?7Xng30ku8q9RI9pjKwl+kUb5s3XksY2ZQn0wOqG7Bkf9XeQpLYCq2m03MbPY?=
 =?us-ascii?Q?KKRq35XvkW03V0HG/8A4Aiutk0XwDzUgaiRHVUq7559VkJoDZb36Pd/NKQE2?=
 =?us-ascii?Q?FQHVkMeaa9BqlDY8A3obyEYqOxDdkD0s54iSvVuWrAOz+eBJ3pzRFxjTw+dS?=
 =?us-ascii?Q?4ot0YhSTAK2C4/XtQ3nhp1AIVob+S5BJnhimLGjDipWpd6q9oJxHmj73UDOp?=
 =?us-ascii?Q?1+LZCChD2ai/2QAIlopaacTBOwrzW/bVoSH3pG1Muh+4sKy/iaq0y6wwYldH?=
 =?us-ascii?Q?ySxdOAO4MzfeB1ueajkq7OI0uziKG4Sk+gXMqV8VKEj9W5B1uWAILExB+aCK?=
 =?us-ascii?Q?j0CyW5KaRFaxkzyRfj4VntziuUgbqjBlOSi4KTFba/nJI92Mh3hFLdyJmtBE?=
 =?us-ascii?Q?GnL6poKEz7tdXxEjugRe47ErYNkvzAn9zQGsRXgnhOCpGFZSHpguiCfMz+LZ?=
 =?us-ascii?Q?BXhAwylePjHtYe6yhp3czVJNJj4TipfZw88zl2ilgKfsftTLRKJi+XNmehwL?=
 =?us-ascii?Q?z1JNW5YEsoLlCqYm8jboN9YKmACGmYD+T32avfCUOGj24LxUnfuHvCMUSWGs?=
 =?us-ascii?Q?3GuSaiqTTC43YH2+PIBuRRsDPy8j7H0ITmP+t1tu0Heb3DLTVotAKEktHfB5?=
 =?us-ascii?Q?TvwKHW+l7u71pq2DHC9xK+5y1eyapjlse9/0etNIGeJLRfgQdPOOYFqSs1ey?=
 =?us-ascii?Q?0EvzyRmDsOIbzSZWYPmAgHmCXs9PumG5jnOdtRVWCZI28rN15NiWSff6dmzP?=
 =?us-ascii?Q?rxpYnrtAeIkw77eZ3v8KftC0in+rDePaBPaMNWO7JE5HijVQ58y28+iq+KLQ?=
 =?us-ascii?Q?kwT41vsJlB4ubWY/eE+2DsplidpFTEk+qRRp9kh59hR4b1iKAI8qXJLQMVFx?=
 =?us-ascii?Q?YCgr2zV9fFFvUsCy/It+Vy4y7g1oJUt0vkedrx6WZIyWinX5uoM7LgttapPV?=
 =?us-ascii?Q?HdPDP6HeUzwYP9WMUm80IulG1Uj40vb/2dAPQVoEZdn4YGyZHGp0XYBC/06r?=
 =?us-ascii?Q?mIlnNqAo5Hfe2QLObKv3nTWXasmnY2CHFj1mn5DFIb3rQIMh/JwKBwVx69Dd?=
 =?us-ascii?Q?qxMw65+JBcafS3EmahrmwMQKRbkFBX+YOrvVXmdLb/8ZHweCTll6bOrDAI4j?=
 =?us-ascii?Q?jAkjAiUzchA5nGy/AwA+hDzGdeYSuE5RwmqPeec58kW73T93?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304074e7-18b7-4155-f2ed-08deb4d701fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 12:14:24.5651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ItUV2WI8GH95tjoN3Ibf3zJjEhmJ9OFHHCNaAfV5IdE8Y/nUeVwc1fQIaEUAZwc1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
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

AMD General

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Monday, May 18, 2026 3:09 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amd/ras: Add more IP versions for uniras
>
> Add more IP versions for uniras
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index aaf88e1cdd07..4181caea71c7 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -291,6 +291,8 @@ static int amdgpu_ras_mgr_sw_init(struct
> amdgpu_ip_block *ip_block)
>       con->uniras_enabled =3D false;
>
>       if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
4)
> ||
> +         amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
2)
> ||
> +         amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
) ||
>           adev->debug_enable_ras_aca)
>               con->uniras_enabled =3D true;
>       else
> --
> 2.34.1

