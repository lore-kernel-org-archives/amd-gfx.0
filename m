Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BB5D5E152
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 10:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E61E310E081;
	Fri,  8 Nov 2024 10:21:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yu70nN8M";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D63CE10E081
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 10:21:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jz6uxtcWT4uFLe0g2M7ZcZzG1bX3Usb/Fq61lSjp56Zzj/Bu0s2yRwrQaBohgfLA3F0JNoocZftuP/c1TPfqacP3eaCCfqLubwvPtI/2W7zDcRw/0J5jAXquVjCoiK4eDI6G9aSMfGSVjVFVClxayYqZhGqdU93Jp8oioPdTFF8H3y28j7rzLechJF9Jhywuhnzzjcxh3LFEf0GmO/hi4dlJTAZl3LED6387aMXaQpGBPp7FmqJQlx/Xz3jZIf73o6LYBf6ahPYOQWegb6/mco2vMyJ8trUxj0rIkpV6H2npy6FM2yBKIIBOUHd444rn1voC914V+rF/3SRzuqzYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jz08yA0OusAQPK4DqWvjsmvDzs14oKAGlNsYDkOo9SY=;
 b=bhyH3ouCY1PwqTTnIy/F7uFs+nknVEXIMKSzbSC6piK8vJqInKesefpC2pHd97iD1S0kmH2ZNBDHQk/5UGwLHseCcNOpQ4/Pur6bfDdou/RAU6ROjeJfgQMSlFbRAHG5VJGlpwkLAITpDRdMybn4JH2oOy7Xa5vXvqShVowEw3s/fDqSYjTqWoWtLqhT7zxE6fY30m65QtLeDNMznzP3sfn3MZxbuRG/oImLnXe7y8F/siwHICP/QiCxMjx5UXPjM7xhxeFOm2lzjRGECyT6lQ2BgCIEsn3Q+g6YYvDe+aCZMEjey6C/9pHa0EpY0qCePh4X2cm+ehKG+J92+oZ6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jz08yA0OusAQPK4DqWvjsmvDzs14oKAGlNsYDkOo9SY=;
 b=yu70nN8MVnNSJJba3gu3Teg/SQTF6Fe1Uwnah9znyp85/qAwMEyF8P8F0JitYFisgPAqfZXa97ZpnDVrZKLX6Q3dpxluhki+zXG1+RPmYD0Ikxg2kl+XDp8y//3KLIH3sDfq9yg4SkRKjxJFdpviJKN9v+EXNrWBNHwjabui8ng=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 10:21:39 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::962e:1ce3:e83f:8482]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::962e:1ce3:e83f:8482%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 10:21:38 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>, "Zhao, Victor"
 <Victor.Zhao@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
Thread-Topic: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
Thread-Index: AQHbMBZHMXJO9/1Wb0SUcDj9uFrCqbKqXF8AgAD3oQCAAGQwgIABdj0g
Date: Fri, 8 Nov 2024 10:21:38 +0000
Message-ID: <BL1PR12MB5269C32C36AEBAE40FBC131A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20241106063322.2443403-1-Victor.Zhao@amd.com>
 <20241106063322.2443403-2-Victor.Zhao@amd.com>
 <CADnq5_NDDBsWrZvxQrCk8-qXfk-xBUBTM62SNawC__BANtpjOQ@mail.gmail.com>
 <6dc831bf-f7d8-4e9d-98c8-8204b330e466@amd.com>
 <7c8e9102-0d4f-405c-8749-1653118400f1@amd.com>
In-Reply-To: <7c8e9102-0d4f-405c-8749-1653118400f1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=daed1875-2cb9-49dd-a7d3-0cee6d48f927;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-08T10:16:40Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5269:EE_|CH3PR12MB8353:EE_
x-ms-office365-filtering-correlation-id: 9d5b41a9-6e5c-4662-290f-08dcffdf21cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TC9pK2JQU3FIbUgrL2NjUmVienBaMEZZZEFRTTk5RjFCUnI4TFMzZWF1cjhx?=
 =?utf-8?B?RzJZZ05QZWh0d3lvdUxzSHJaY2pENXIrZXhabklFcnNMWDFxUzVRWGhGOEM3?=
 =?utf-8?B?WnM3cTBYK3R2YnYyVU9jZmhjRmlCRGZYQ2xsbDZ3eENCTXpSL3VIdUJaclYv?=
 =?utf-8?B?MkVpRmFyRDhuNm83S0pvNFFZQnhaYW9URUxUY09EUnlHNnpaWUt3cENaTUFs?=
 =?utf-8?B?M2JuWk5DZW5VUEVnbHdFWWdVT3plSmZqbnZwZUVIVEFXbE91Rmk3QVV4WGVG?=
 =?utf-8?B?S1lORGltajBKczZ1T2Z4RXo2MlJuc2ZrWHdKVWduTFVKeEQ2RmJ4OFhqeUpD?=
 =?utf-8?B?dDB0UFdScmY2L2hvSCs5aktUSmdPQkkxZmhpYnAwM05LS3ZhZFpJb3h5WTBU?=
 =?utf-8?B?ZjU1NzhjeFNaUklrc1ZHSjc1VWpweXhaTHlpdlhpWUR4MGNEelZVZGlxaTd1?=
 =?utf-8?B?NVl6TWM4bENZM3FEdHU5WGxoWXFJdEg5dzhzZXJackh3RmxmOFBRVTNzQ2pX?=
 =?utf-8?B?Z3FGMng0OTYxQnA4dEpiNHVoaWhKeEN0anVIWjhDY2RLWFVLR2p0c2FlS015?=
 =?utf-8?B?U0JyV1N3SmV3M1E4TG56RFlrbElhSlN0SXBhd2hmZjFYdVE0YWw3MFIxUzlW?=
 =?utf-8?B?NG9XY3V3ZlNGd04xYUNhY1dzUEJweVVyakNCMTVydzNLNmk0Vkt1VU9EOTFn?=
 =?utf-8?B?Y2pzK3VYMFp4SUt3alQvSXRnVWphZEpqcnpLU1JUWEx0S1ZabENkTjRxdno0?=
 =?utf-8?B?Ynl6OVZSNko5SkRYYmZzYVEydjdYOEJFcWZOc2xaQmVaZ2xvb1BJNXRMVGR4?=
 =?utf-8?B?WS84VGFnZUV2VEFJaDhON0pJZk9OU0s4eDhqY2lwa25OZG0vSndOTG9Fbnhy?=
 =?utf-8?B?bWd0bHpFakc4WGdUSUFYK0N2SVN0b240SDEzb0hIZC9sTER1RTFqVzdNS1Nr?=
 =?utf-8?B?VmRDNHNuczduaWREeUh0NmR0Zmt3VVVMRHdGWFhmcnV6QWtZb3RMRkRWa1du?=
 =?utf-8?B?RWZMb3k5akRjOStNSEMvcjkrV1l4dkJPT0ROc3YzN0tVQlFTZ3Z2ZGVmcDVz?=
 =?utf-8?B?RDNBWjVzT2swLzBaWGZka2pONHdma0NnSWZ0ZkpjSkJ6eWxFNm1yaTlJSnBi?=
 =?utf-8?B?azFObTRYbEZHVzVSNUg1dlN1dnRBaVJUZ1FWWEdiOWpRVUoyVzJMTWF0Rk93?=
 =?utf-8?B?OUFsbW1WbGIrVU1GZnVDNnh3WkRjY1NlS1VwMWNUV3ZFS1F2eU5TK3B1b3pm?=
 =?utf-8?B?SDB0b0NDd3huV0g2Q3pmeUZiMVNvMXVRd0dVNkFOQjlFR2dWYmtabzh1UVkr?=
 =?utf-8?B?RmZJZ0hBazUxS3BwRzN6UEtzSEI5cm5CUjRsRG9BL0UzOEtqZGt1a3Juc25p?=
 =?utf-8?B?cTZPRi9VSWhzSWN1SDBKSStKeEpkY2RTNnhXdUwxVWVqNTcrY0dHeWlBUlhz?=
 =?utf-8?B?bjB4K3kvM3RuMVdHS0RyZzdaYmYyMU1RaVRBNmt4dE0rYnZvVUFzbHd5TVdh?=
 =?utf-8?B?MkZJTmFQdmVYSkhGcWxnbkRIWlBEbVE5RGtZZDVLbi8yU1IwdnJUSXUzSEMx?=
 =?utf-8?B?a1V6NVhNaUJSSy9rOCtaM0VLZXFIakpKZmZ4dm5wbmJQT21hck5XdEZaTEUv?=
 =?utf-8?B?dTdxejh6aHU0T1V3YTVwT3A0ZllTdVlVcEtOc2E4V2tXUlhJazUvUGdINWJX?=
 =?utf-8?B?cFhTb2N0REF1clNsWHlVS1pBY3ZWNDFjUWZQanRCajFzOVR2T0dqZjg0MkJx?=
 =?utf-8?B?QVhCTksxMStLem02MmMyYlF6TkI1cnBvUy9PeU9qdXFTZ25qWDFGbUhSYmJx?=
 =?utf-8?Q?suqJYje0t3ctt2QGA4z42ZUJCCxebx48Oqcts=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REpNNWtpYTNMSTI4SFJydmhnNHFsU2hJMWgwOERaaTdoTmdFQWorZFRqRGJO?=
 =?utf-8?B?U3hUVXRiWThBSVh0Vkd5NUt1REh2ZTBTamRFdFFSdW9KZFFyS1h3aERJTVZ4?=
 =?utf-8?B?ODdQbHQzQWtydS9USGhkMUJJZ2V6RzFMQ1RLWmZGeGpsWElsdXEyTklZT2dP?=
 =?utf-8?B?d1B3ams2NmVYclZyREpWcGc2NXJjS0xXNVFISGNNS2N1Zyt6bEpwSHZ2Ullr?=
 =?utf-8?B?WVluRWhhYXk1eU43T0ptdUREWlVRZTZLcXBkK3I5UjRUakU4ZnpGUm9KVzhO?=
 =?utf-8?B?VnFWTEF3TTl2b3RrcHdPY1pmdlJudkROSG1oYnl2VWU1WTlIS0R5ZWs1S3RH?=
 =?utf-8?B?eklxQlVhOFcrY2M1eER2Ukx1NWhvTVhTalB3SzNXa2twUUFnWUZIK2doUUp3?=
 =?utf-8?B?VnJJZXBUMHQwVG56V0Z1cW14elljN2FwRHY3ZFVLbmJibXkvMG5GdnZKL2xD?=
 =?utf-8?B?Ui9MVlRUWURYVDBSZFQyenhybExNYy94R05GVCtUWEVOajJTQzRLeGliTnQ5?=
 =?utf-8?B?Zk9PSFdtSUJ6WmlYd2dhRW8rSVhnbit6Y0hzdUZEV3BLQ1cvcC9iZFNLOWtY?=
 =?utf-8?B?b3EyUTVZMXJudWs2bFZJL0MyMXkvYlhCVnA5QkFBaURzOUhIVXU4MXJ1eXQy?=
 =?utf-8?B?WUdSSFZmMkJ2OVNHRmxpZUwyVzl4UHlDbytMTlkrdy9HLzl2MDIzbU5qbkRq?=
 =?utf-8?B?bFhhVEFQZXMyeVYyK1pVeGlmU21wYXNuc2Z2YXlkV3dPVkNhN1c2bXVGMmZn?=
 =?utf-8?B?K1dsV1VYNnZOY3Z3ZEpqWUF1dWNtVDRqRldmaFZtZ0NYdDBIbDBnalFxYVox?=
 =?utf-8?B?ZklQZmtzdVRzYXlmaEJacVN6WGt1eVRJWE4wQjJBZ1dpMmcyOFFPRnZFM2ZW?=
 =?utf-8?B?UzRzb2FjQmwrLzJUWk9DdkVOY0Qvb2VxeldtT3RvU2tJQndKLy9nRWxhY243?=
 =?utf-8?B?aGovMWZKQWtneDQ4YmMzSnVDSWpiK05wbGFhd0dKMDR3Ujc2L25qNUNxR3dt?=
 =?utf-8?B?RWlGK3V4R3g3bDR5REtzYzJnZnZneTFoc0tQRDhLZVN3TUVCQXR3dlJwaFN5?=
 =?utf-8?B?L2FzcmVkaU1xZmViRmtFT29sQUpzVEE5R2MyckFvNWNOVUFqSEIrcHJsUDRt?=
 =?utf-8?B?MWk0dDcrb00rYlptb3AwY2l3TG5FSHAyL0hBWXgvUjdaQWI2cm9DZ3h0bkJL?=
 =?utf-8?B?SDEyYjk4Z3Z0OHliSm1uVkp0dVUwSHlia0VVQy9EV3ladFovR1dhclQ3Y3RQ?=
 =?utf-8?B?cEdPWEtmODRQVWE0Q01vaFI1N1ZCeUduMXVlTk9hTXZteTNkdnFkR2QyTXVt?=
 =?utf-8?B?UUJiRjZNNEs4Zkc3SFpLakJhcStuOVZCTUwzbVlvUmhGT01TSGRCb1VFTlEr?=
 =?utf-8?B?QUo2WjU4SFdYYisyRlFNclAydzBsMlluSDJNVDB4S2hEWU5Vc2VISU54Nk9V?=
 =?utf-8?B?Q2wyUXRLdVI1MmhhWkU1b3hwVloxU0E5WXhYZ05CeVVKR214UEgxWlYzZTAy?=
 =?utf-8?B?QUR4NGxVbzF2cEVqQWMvWXR4ajUxa2xvR3lJS05XemxoMGQ5OWVveDlIQVEr?=
 =?utf-8?B?ZXYvTEpZU2dtU0tGSG1LSi9ZazI1eWZSRGVuTTBkRVgrNUo5RVVjL3dqbDd5?=
 =?utf-8?B?elRVUXVNSjdhV0wvbnN6T0RrTXlJWTdDbW5pMTJaV1g3OUJaeXJhTUoyemQ1?=
 =?utf-8?B?Y2w2SktjVkQrMzdINkIxdCs5SFRvZzNQYkFITFp5TzNJVEdSU0x6MG5YN2hu?=
 =?utf-8?B?YTVDeW5XZ0tIRVZpMjBqcitERXZMeXJiYlZCSHBhcGFqOEVGOEZCRmFBSUNV?=
 =?utf-8?B?bEtsbWdPbW1uVlI1US9WaitPMTBJMUNsZTE4cmhldG9qc1V5RlVMdkswaXhv?=
 =?utf-8?B?WnFQY2ZCVGpjeXhnUk1VblJZZkZRR3A2Zkh2ei9oZnl4ZGFqaXZJK1pkdE1a?=
 =?utf-8?B?MCsyenQvSGF5WFptQmFxRkFLOEFKL3VLL1gxaU5WV3RtRjV6TXhzT1p3WWsx?=
 =?utf-8?B?ZXMyTm40VDFkbVFFSjZiRm1xclJnRnRlemJMYUZSNVpxN2hTMEN5c1E2ODhH?=
 =?utf-8?B?U3dPTUtiTUFkZ0tWRXRYT2RIUDlpR0VHQk8vRmNEUE1tTUlVaG9jS2NaaEZM?=
 =?utf-8?Q?0phI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5b41a9-6e5c-4662-290f-08dcffdf21cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 10:21:38.9018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +pg5JOt2gnhEa7D2vEjjhh4QSPEdG4a70Ef1/aa8rvn72/DNKxvN7pP2YiMx+Iza
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KQ2hyaXN0aWFuL0xpam8NCg0KV2UgdmVyaWZpZWQgYWxsIGFwcHJvYWNoZXMsIGFuZCB3ZSBr
bm93IHdoYXQgd29ya3MgYW5kIG5vdCB3b3Jrcywgb2J2aW91c2x5IHRoZSBtYigpIGRvZXNuJ3Qg
d29yay4NCg0KVGhlIHdheSBvZiBtYigpIGJldHdlZW4gc2V0IHdwdHJfcG9sbGluZyBhbmQga2lj
a2luZyBvZmYgZG9vcmJlbGwgaXMgdGhlb3JldGljYWxseSBjb3JyZWN0LCBhbmQgSSdtIG5vdCBv
YmplY3QgdG8gZG8gc28uLi4gYnV0IHRoaXMgd29uJ3QgcmVzb2x2ZSB0aGUgaXNzdWUgd2UgaGl0
Lg0KRmlyc3Qgb2YgYWxsLCBVU1dDIHdpbGwgaGF2ZSBzb21lIGNoYW5jZSB0aGF0IHRoZSBkYXRh
IGlzIHN0aWxsIGluIENQVSdzIFdDIHN0b3JhZ2UgcGxhY2UgYW5kIG5vdCBmbHVzaGVkIHRvIHRo
ZSBtZW1vcnkgYW5kIGV2ZW4gd2l0aCBNQigpIGdldCByaWQgb2YgcmUtb3JkZXJpbmcNCkdQVSBt
aWdodCBzdGlsbCBoYXZlIGEgY2hhbmNlIHRvIHJlYWQgc3RhbGxlZCBkYXRhIGZyb20gcmluZyBi
dWZmZXIgYXMgbG9uZyBhcyBpdCBpcyBtYXBwZWQgVVNXQy4NCg0KVGhpcyBpcyB3aHkgb25seSBj
YWNoZSBwbHVzIHNub29wIG1lbW9yeSBjYW4gZ2V0IHJpZCBvZiBpbmNvbnNpc3RlbmNlIGlzc3Vl
cy4NCg0KQmVzaWRlcywgZG8geW91IGtub3cgd2hhdCdzIHRoZSByYXRpb25hbCB0byBrZWVwIGFs
bCBHRlggS0NRIGNhY2hlK3Nub29wIGJ1dCBvbmx5IEhJUS9LSVEgZnJvbSBLRkQgY29uZmlndXJl
ZCB0byBVU1dDID8NCg0KRm9yIHBlcmZvcm1hbmNlIGNvbmNlcm4gdGhhdCBsb29rcyB0byBtZSBh
bHdheXMgdGhlIHNlY29uZCBwcmlvcml0eSBjb21wYXJlZCB0byAiY29ycmVjdCIgZXNwZWNpYWxs
eSB1bmRlciB0aGUgY2FzZSBISVEgY29udHJpYnV0ZXMgdmVyeSBsaXR0bGUgdG8gUk9DTSBwZXJm
b3JtYW5jZSB3aGVuIHN3aXRjaGluZyB0byBjYWNoZSBtYXBwaW5nLg0KDQoNCk1vbmsgTGl1IHwg
Q2xvdWQgR1BVICYgVmlydHVhbGl6YXRpb24gfCBBTUQNCg0KDQoNCg0KDQoNCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+DQpTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgNywgMjAyNCA3OjU3IFBNDQpU
bzogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT47IEFsZXggRGV1Y2hlciA8YWxleGRl
dWNoZXJAZ21haWwuY29tPjsgWmhhbywgVmljdG9yIDxWaWN0b3IuWmhhb0BhbWQuY29tPg0KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5j
b20+OyBZYW5nLCBQaGlsaXAgPFBoaWxpcC5ZYW5nQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXgg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZHJtL2Ft
ZGtmZDogdXNlIGNhY2hlIEdUVCBidWZmZXIgZm9yIFBRIGFuZCB3YiBwb29sDQoNCkFtIDA3LjEx
LjI0IHVtIDA2OjU4IHNjaHJpZWIgTGF6YXIsIExpam86DQo+IE9uIDExLzYvMjAyNCA4OjQyIFBN
LCBBbGV4IERldWNoZXIgd3JvdGU6DQo+PiBPbiBXZWQsIE5vdiA2LCAyMDI0IGF0IDE6NDnigK9B
TSBWaWN0b3IgWmhhbyA8VmljdG9yLlpoYW9AYW1kLmNvbT4gd3JvdGU6DQo+Pj4gRnJvbTogTW9u
ayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+DQo+Pj4NCj4+PiBBcyBjYWNoZSBHVFQgYnVmZmVyIGlz
IHNub29wZWQsIHRoaXMgd2F5IHRoZSBjb2hlcmVuY2UgYmV0d2VlbiBDUFUNCj4+PiB3cml0ZSBh
bmQgR1BVIGZldGNoIGlzIGd1YXJhbnRlZWQsIGJ1dCBvcmlnaW5hbCBjb2RlIHVzZXMgV0MgKw0K
Pj4+IHVuc25vb3BlZCBmb3IgSElRIFBRKHJpbmcgYnVmZmVyKSB3aGljaCBpbnRyb2R1Y2VzIGNv
aGVyZW5jeSBpc3N1ZXM6DQo+Pj4gTUVDIGZldGNoZXMgYSBzdGFsbCBkYXRhIGZyb20gUFEgYW5k
IGxlYWRzIHRvIE1FQyBoYW5nLg0KPj4gQ2FuIHlvdSBlbGFib3JhdGUgb24gdGhpcz8gIEkgY2Fu
IHNlZSBDUFUgcmVhZHMgYmVpbmcgc2xvd2VyIGJlY2F1c2UNCj4+IHRoZSBtZW1vcnkgaXMgdW5j
YWNoZWQsIGJ1dCB0aGUgcmluZyBidWZmZXIgaXMgbW9zdGx5IHdyaXRlcyBhbnl3YXkuDQo+PiBJ
SVJDLCB0aGUgZHJpdmVyIHVzZXMgVVNXQyBmb3IgbW9zdCBpZiBub3QgYWxsIG9mIHRoZSBvdGhl
ciByaW5nDQo+PiBidWZmZXJzIG1hbmFnZWQgYnkgdGhlIGtlcm5lbC4gIFdoeSBhcmVuJ3QgdGhv
c2UgYSBwcm9ibGVtPw0KPiBXZSBoYXZlIHRoaXMgb24gb3RoZXIgcmluZ3MgLQ0KPiAgICAgICAg
ICBtYigpOw0KPiAgICAgICAgICBhbWRncHVfcmluZ19zZXRfd3B0cihyaW5nKTsNCj4NCj4gSSB0
aGluayB0aGUgc29sdXRpb24gc2hvdWxkIGJlIHRvIHVzZSBiYXJyaWVyIGJlZm9yZSB3cml0ZSBw
b2ludGVyDQo+IHVwZGF0ZXMgcmF0aGVyIHRoYW4gcmVseWluZyBvbiBQQ0llIHNub29waW5nLg0K
DQpZZWFoLCBjb21wbGV0ZWx5IGFncmVlIGFzIHdlbGwuIFRoZSBiYXJyaWVyIGFsc28gdGFrZXMg
Y2FyZSBvZiBwcmV2ZW50aW5nIHRoZSBjb21waWxlciBmcm9tIHJlLW9yZGVyaW5nIHdyaXRlcy4N
Cg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KPg0KPiBUaGFua3MsDQo+IExpam8NCj4NCj4+IEFs
ZXgNCj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+DQo+
Pj4gLS0tDQo+Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMgfCAy
ICstDQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2
aWNlLmMNCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYw0KPj4+
IGluZGV4IDFmMWQ3OWFjNWU2Yy4uZmIwODdhMGZmNWJjIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYw0KPj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYw0KPj4+IEBAIC03NzksNyArNzc5LDcgQEAgYm9v
bCBrZ2Qya2ZkX2RldmljZV9pbml0KHN0cnVjdCBrZmRfZGV2ICprZmQsDQo+Pj4gICAgICAgICAg
aWYgKGFtZGdwdV9hbWRrZmRfYWxsb2NfZ3R0X21lbSgNCj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAga2ZkLT5hZGV2LCBzaXplLCAma2ZkLT5ndHRfbWVtLA0KPj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAma2ZkLT5ndHRfc3RhcnRfZ3B1X2FkZHIsICZrZmQtPmd0dF9zdGFydF9jcHVf
cHRyLA0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgIGZhbHNlLCB0cnVlKSkgew0KPj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGZhbHNlLCBmYWxzZSkpIHsNCj4+PiAgICAgICAgICAgICAg
ICAgIGRldl9lcnIoa2ZkX2RldmljZSwgIkNvdWxkIG5vdCBhbGxvY2F0ZSAlZCBieXRlc1xuIiwg
c2l6ZSk7DQo+Pj4gICAgICAgICAgICAgICAgICBnb3RvIGFsbG9jX2d0dF9tZW1fZmFpbHVyZTsN
Cj4+PiAgICAgICAgICB9DQo+Pj4gLS0NCj4+PiAyLjM0LjENCj4+Pg0KDQo=
