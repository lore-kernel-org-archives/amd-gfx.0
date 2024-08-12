Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB24C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 02:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E82010E021;
	Mon, 12 Aug 2024 02:10:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NpB3E70E";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF0EB10E021
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 02:10:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P58mPFtiZerl93hhwrGHAARZcZVGkGw837E88vIF7DW5F88O4ZDEkV3u32mEI+mv8KVp6mw5dxyggaCp/N7FUyyCOhTiZhxC380pl6C6Ge/Fl1JxuQOixgWFdfPTC+Bdp4XLXuFCXlJQiGTdlDc55DGBy1Mrftv7mXbA8U3DSaOQseSwJ2jgltrip/lCDkEiCjomjI7Vgh1FSn5ps8xRH/OKg8j19M4OW/8fr3HCNHpv3GXqbfuu0mUSDRG5jagyRCs/3pbyeGDHITCkh/ZB49kD0g09nDyuk3rx1x4HjD1M5867hKNHktUoT8RD5/5kF+h7lyKG43co46nMTIor6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7YCs8ZddN7NaSrKfl8RMfYIsOX0rhsPWYww/Pte7Wg=;
 b=GV1yA1HdH/Fea8kXuhsoqVjTtMStL5Faw2jekLI/y6QtOvizlipFHU1O0Lpko6dFaWjVRue8HMTA2FW9QUQHqGaYClZ62JSOObzJ1paAqnc6ngIuhmeZstuo0HBJ+jCT/+6oSD5cF7Foao4i1gmsZ5iPT86spVsGQLynF699/tmSlPpswj60MovZXe/MD0QEW+BB0XqEfP/L9go5mLteSysdAiF/UsHmpiMbxYVxjM6rIvPx/RhVeqMwvJstRUvI8WgUero3rtlT7Z63lJveikT9Ju4d0Y+fTI8VGbUxviPDMsMFk1rP124IvhE76ajr8suMDnxOIvatSTV/Vpr6jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7YCs8ZddN7NaSrKfl8RMfYIsOX0rhsPWYww/Pte7Wg=;
 b=NpB3E70EjNrIGUl6TwQPq7nCIYIe/M6wAIs71AcYU0KKp5MB3ngZ/Xc5odFphHykd78j1MqaZ2rVdp9G2rkRmtrB3slxkqBpq/IghVSzoOF0Iw42UfJvK16hJNu8mp6uoT+cnfSkOu9yAvbdl2eeuoSQx3rb8QOee/jyQxJK/lo=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by IA0PR12MB7531.namprd12.prod.outlook.com (2603:10b6:208:43f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Mon, 12 Aug
 2024 02:10:52 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 02:10:51 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: keep create queue success if cwsr save area
 doesn't match
Thread-Topic: [PATCH] drm/amdkfd: keep create queue success if cwsr save area
 doesn't match
Thread-Index: AQHa6W881OX1vpnp0U6vbxJOQG6+0LIdcF4AgADz69CAATLeAIADSLpw
Date: Mon, 12 Aug 2024 02:10:51 +0000
Message-ID: <CY5PR12MB636906514896C3B015D04623C1852@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240808084421.2755417-1-yifan1.zhang@amd.com>
 <CY8PR12MB7099066850F032CF0AF32A038CB92@CY8PR12MB7099.namprd12.prod.outlook.com>
 <CY5PR12MB63696ECC884783C0812DF219C1BA2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <bd4a1e0f-6ce2-449c-bb49-2378d0778dc9@amd.com>
In-Reply-To: <bd4a1e0f-6ce2-449c-bb49-2378d0778dc9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=624f6fb3-0981-4599-89d0-ff0424e78c9a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-12T01:45:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|IA0PR12MB7531:EE_
x-ms-office365-filtering-correlation-id: e6c66975-a830-4301-d966-08dcba73fd9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RjJ3M1VWQUljdlVHNEJBbDFxV3cyM3o1NG01MVZKbnpVV3F4UXc4cHpKVDFC?=
 =?utf-8?B?TnpEM0kvSDhmM3VYZHMwSEpGYkk3MUVmRUhyeHhPbW5OQ3lhbkg3VVNaRDM5?=
 =?utf-8?B?ZFNJcTFjaW11ZjExa3RHWTFrYktlbWdSMjNScS9EMFpOYWw5a082U0l6ZStm?=
 =?utf-8?B?QVZUbW13czF5b05BaUs4NFA4Tis5WXhhRkRISGVvdmZIczRFOXIvanRBVmlU?=
 =?utf-8?B?RkFzZTdHSGhoc2FXQ3RHTE1Rd25JdUZMTTViRWRPSUtPWDdrQnVPSUtGMEdK?=
 =?utf-8?B?OFpteGp6WXZ4M3hhZlVjRDYrcks3eWN5TTJUZlFXVUxZcXpveE1PRGVMcHVa?=
 =?utf-8?B?REVMUXV6SmxYM2dnM0had2ZKUjdTWUVUTGxTczlwS3NoOUdNSVoyZ1JaV0xH?=
 =?utf-8?B?cmtsTk9RMFpZWmx5ZXdlUGd5VXVYWElvTy9TTm9FOHBXeEdzVEUzTENsMi9t?=
 =?utf-8?B?K3lxTmx5U3BKK3JGdjFzVnlWeVgyRHVrdzJOVy9RRHBxN0c5Q29QSXJpcytK?=
 =?utf-8?B?eVZhd2liRGNSUDQ2MlFpaDVBQm84RnhqOWJpc0w3bnFSNW5ST0toOE5kODRj?=
 =?utf-8?B?Z0tTZ29TZE54ODRHZld0L0s5NXQ4ZlhiUDhEbnYwN1gzMU1scm9GQ0hoZUFN?=
 =?utf-8?B?bXFlQ3B2RkNZWGpzQXBGQk1lbDNJK01NNnhoZk1BRWlGZjFtRGlQa3M1RE9n?=
 =?utf-8?B?eUZtb2JsMVFEWTJNdk1ZWlljMlYzRHI1cjVVcVVuVkFRQVFkeFhuNk9RM2My?=
 =?utf-8?B?UjMrYXloSWYrdW9FY0N1TFFmVmlPZ0xkTGdtZGpqSDRnUUw1d0hTQnlvT1Q5?=
 =?utf-8?B?NEJQb0FDRkxVSTF6SGlQdkNKOC85MFl5ZjFISEpqVDZ1emUvWmVGZ2wrL2FV?=
 =?utf-8?B?QVdGQ3EydFpkcmJYemNGOSsyK2tJQmE0Y2Z1MEVhS3BleXBUYzJvcmpPeWk1?=
 =?utf-8?B?MGRnSUNNNGgyVlRJZU9YUDN3VnlHTHphV2RWZlhVMU5LYWorYWJRVmJ2YzFT?=
 =?utf-8?B?M3JYS3VZRkpsVW10MlREOEhnSitmb28zV0hudmhRaHJzMWtUYjdFTC9Ea3Qv?=
 =?utf-8?B?MVRac1lja2FOMjYrSTBIL3I2Y09vMmt6SEZzSHJwdm5qRUZLQzRYM21kcFk2?=
 =?utf-8?B?WVlacFR1QTRnbUY1cU5FNXNFdStRdlp1V0hMcy9qNHdUQVoxNU54VmxueVNL?=
 =?utf-8?B?Rk4vbllsY0VwNXNscGQ1bTNvWCtxTldPYmk0eDg5TEdXSlhNSXBnRkNHNHRK?=
 =?utf-8?B?YkFQMDVrSHQ0TzZ0c2M5Z2ZJZVpzczlXM1BudUVnM2JWRWhneTNxalNEYVhm?=
 =?utf-8?B?V1ViczkzcVZMRkY4eEd0ZVZwLzZYL2hxQU5NS0tsWDBTU3VwbjFZZWxFRWxS?=
 =?utf-8?B?M01iZlpCV1ErOXk4dTREcXFxcUNVSHkxczI1elpMQTVza2VqOGdFdTBxN2Z4?=
 =?utf-8?B?TDFENTNqUEYybUFEcjBsalkvMkhpQUJlZ01ORDcrYkMvaWRwMFp6L2h4TVk2?=
 =?utf-8?B?Rlh1OFl4blUzdW1GS2JCL0NZUDhBQkRyVm1rYWoyWFRzWm5nM09MVFNOeS9r?=
 =?utf-8?B?TGphSzIxTEE2WTB5dElHUWR3aEM0cjUzYThGQllZUDFCam1kaWt2c0UySXd6?=
 =?utf-8?B?WmNDUVNtdzBBKzFGbERSN2pRdTd2SUVJMnpOeldjQWFtTXVwVjBwVEhEcjZu?=
 =?utf-8?B?QVc4OEE0SitxNkVDdUlOQ1BFRTFFVmJuMm1iV05EUU1TRG9FSkhqbTFGa2dv?=
 =?utf-8?B?OFVhL2ZhUTVic3RkYk8vZW8yd24yYkdFeXhSeW1zVjcxZXdIQmZWWlNQYjRT?=
 =?utf-8?B?WDNDdGl1SFphbFhFanVIV0JqYVc3RTRQMDF2MGZJZlVtNDZaampMUVdzcC8w?=
 =?utf-8?B?UDE1Tjczd3kvZVBaRWpLNjhoMzVnVGZFNHZoT05JK0xwMWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2ovcHVuWnI4ekdqdDVLcGVuOFkxQjQ5ZC9PWUFJRWhHWWxRMEtUVnlmSCtQ?=
 =?utf-8?B?VU9rZXgrWFY3N3lOTEkxK0xXa0tDL3M0TDJzMDJHNCt6ZDlHTitBeFA0b1VK?=
 =?utf-8?B?VlhDZzcrOWdiVzdRd1NEdVV0R0dvUTZzcHFuS0JnOHg3dTNuaFd1OWsvT01z?=
 =?utf-8?B?bk53VHRzVmNFQlpOV3UxOS9yNUtobzZaUHp2TlNHc3l0bHBWcFo3K0ZKekdL?=
 =?utf-8?B?aDhXUGFaaFZSYWJqWHE0NHora3pDNjJwS2JSUDNmZU1rbTAxTFhnNXFPZWZH?=
 =?utf-8?B?U1g5Ukl2VVBHMkRHRG5jOGt5ZEx3Y2xBemVFakgwYzZzMjFETTRNMGtaYWU0?=
 =?utf-8?B?WXcrY1FlQkpZc2g1MkNGUXV2NWNEcmdUM1pYMW1UYjUvYW9IZGh3b1lwekM2?=
 =?utf-8?B?OGRWUnVUODVoYjQxaHB3ZDdSajI1N1lraUR3NkNRTDdpK3FlNTI1QWo5MjY4?=
 =?utf-8?B?bWNRQ09VQTBvVVV0VmNYQ0ZxM0xsTk9aMmFxSkh5eWV4WVNLakh1a040N0Vu?=
 =?utf-8?B?M0JsVkgxVnJsaWs4VCtmZjJtZ001RExnczNPbXkweHRBemhDK2dma2dSQThj?=
 =?utf-8?B?ZGFLbWZnMjAxdVk1WVNZVTM2S3Y3ZXA2Nkthc0YrNnBOcTBoRDJLQzlRaysv?=
 =?utf-8?B?QlBZUDRTa0c5V3RmRkM1cmRVNDVmUkVmQmtuSUZDYTkyWEZZQUNCRi83L01S?=
 =?utf-8?B?aE9Ja2o1WDlOVWZoenF3QmdYb24vOVFuY0YvVjFxNFVuMVJPOEswaTV1b0dk?=
 =?utf-8?B?dVNWcTBDbTRCZ0F5S1EyYngwNzY2KzM1OEZyeVFmUUZ2dTlBNDVPUU9jb1Vw?=
 =?utf-8?B?UE9aM2dVQWFFalpCa3BNL2gvUTY0Snp6SERqK1hoVVR2dXMvWXMwVWlXMnNH?=
 =?utf-8?B?NzU4MllHTDNFZVMzeWZnT1Zaa2hLdWhKNzd1d21RM0hudWJ1RVZMZWVFc3pR?=
 =?utf-8?B?YThubHVsaHVlSExhWHZwd1dnOGVkY2d3YXlmcERWeWNYRE1haUZuZlBJMGRR?=
 =?utf-8?B?WmxDVjQvTkZiZHduL0V2anZhaHlmZGhQUTlGWlJ1anJBZVFuR1REVGdlTGdO?=
 =?utf-8?B?UWdlWlpCZzlOeU1jam0rTUJWdVpYWjBTeUFIZWJNQTRzRHEzY2c0WkFJaVMx?=
 =?utf-8?B?T2RkY0E5amp0UmtIeTZHRElWWGVINTVxNEVRN1J6TGNha1pCTWJqMzZhcnB4?=
 =?utf-8?B?R0g0N1V2YlZkbERFVWUvWEpTWG5GdUduMEkvVmh1U1hDc1hjZk9LeGI2d0pL?=
 =?utf-8?B?N2N5dDFNWXlZekhaK1NOQjJyRDRrR0UxY09TQ2FHQ0ZHZFBWcjh2RzB5dzhM?=
 =?utf-8?B?dUZnMGh2N01FQkdrbWY3aGpPRTFBYW1ocXpCZ3o0VVNvSmxkM3JhVFdlVHFz?=
 =?utf-8?B?cFJrQ240S0ZzbDBrTk11djJWY2dSL0hHM0s2OHhTcXo3bHVGTXIwQ3lRQjhB?=
 =?utf-8?B?b2xjY2ZOQ0ZhVHBTZm1BSGd0UXdwWXFpY3VlaDNnSS9XellDOUtrdloyd09i?=
 =?utf-8?B?Tmx6eXlZTC9IdnhxYzljWXJueGE3cktxbzB4Q080dGxaQUJ2cU9iYTNIVVNh?=
 =?utf-8?B?WnN0Ylg2YnpIeEFxc2NzNmVSV2d6Mjd3dnhyeVYrenIwbkYwUVMzTTN3aU5u?=
 =?utf-8?B?L0IrSzZrY1U4Ymd6bytxNThPaHVhTzZkd3IvSG10NUMzNHRGWDU0VHJsNzRL?=
 =?utf-8?B?anhNMHQ4RExrbnZFQXVVQmFHUkU2YXh5dzBFQWJPcEY3TlZzV0wvM0tIN3hh?=
 =?utf-8?B?YUpoZHRGQ212eXQzQnQxSkpPUW9ZeVl0TzdEWGFqUmdtVDNVYnp4eVJuQnhv?=
 =?utf-8?B?VFJJZUtkMjVmYU5HanJRYU42NUU5OVpjNXRzaDFoNndVVmx3STdzay9YQlQ0?=
 =?utf-8?B?SU8xaG0yUEF5UmRQWEJwS3M1aTRXS2VNY0N4cExXR0pPcTA3WUd3c2szVXR2?=
 =?utf-8?B?UUdkenZvYTRHa0lDMkEvemhRNGd0UjR3dkF2K0FpTE9lQzkybWFHNWZ5ay9U?=
 =?utf-8?B?MjZyRDJKeGlIR3hYTUJRbFN0UC90Ly90RHdoVGlzS3JGdGt2M2l1QmlvQmpO?=
 =?utf-8?B?ancxdlI1eCtUcXE2UGpJalRPb053WTVIb3I5NlRmck1DaDdja1pUNjQzeGpy?=
 =?utf-8?Q?N850=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c66975-a830-4301-d966-08dcba73fd9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 02:10:51.8222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VcCXqCy53CPU4MXrVKKJcKnIsrlEnPXUEnMrRrBn14ptjtY7hk+s1/weStNZTjbC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7531
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
Cg0KSSBhZ3JlZSB0aGF0IGFkZGluZyBleHBfaHdfc3VwcG9ydCBpcyBhIHNhZmVyIGFwcHJvYWNo
LiBNeSBjb25jZXJuIGlzIHRoYXQgSFNBX09WRVJSSURFX0dGWF9WRVJTSU9OIGhhcyBiZWVuIHVz
ZWQgZm9yIGEgd2hpbGUgYW5kIGhhcyBiZWNvbWUgYSBzdGF0dXMgcXVvIGZvciBydW5uaW5nIFJP
Q20gb24gdW5zdXBwb3J0ZWQgQVBVcy4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgYXBwcm9hY2ggd2ls
bCBiZSBhIGJ1cmRlbiBmb3IgQVBVIGVuZCB1c2Vycy4gQWRkaW5nIGRyaXZlciBsb2FkIHBhcmFt
ZXRlcnMgaXMgbW9yZSBjb21wbGljYXRlZCB0aGFuIHNpbXBseSBhZGRpbmcgYW4gZW52aXJvbm1l
bnQgdmFyaWFibGUgb24gY29uc3VtZXIgUENzLg0KDQpCZXN0IFJlZ2FyZHMsDQpZaWZhbg0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5L
dWVobGluZ0BhbWQuY29tPg0KU2VudDogU2F0dXJkYXksIEF1Z3VzdCAxMCwgMjAyNCA3OjM3IEFN
DQpUbzogWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdAYW1kLmNvbT47IEthc2l2aXN3YW5hdGhh
biwgSGFyaXNoIDxIYXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFlhbmcsIFBoaWxpcCA8UGhpbGlwLllhbmdAYW1kLmNvbT4N
ClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IGtlZXAgY3JlYXRlIHF1ZXVlIHN1Y2Nl
c3MgaWYgY3dzciBzYXZlIGFyZWEgZG9lc24ndCBtYXRjaA0KDQpNYXliZSB3ZSBjYW4gdHVybiB0
aGlzIGNoZWNrIGludG8gYSB3YXJuaW5ncyBpZiwgYW5kIG9ubHkgaWYgdGhlIGV4cF9od19zdXBw
b3J0IG1vZHVsZSBwYXJhbSBpcyBzZXQuIFRoYXQgd2F5IHdlIGRvbid0IHdhdGVyIGRvd24gdGhl
IGNoZWNrcyBvbiB0aGUgcHJvZHVjdGlvbiBjb2RlIHBhdGggYnV0IGFsbG93IGV4cGVyaW1lbnRh
bCBzZXR1cHMgdG8gcnVuIHdpdGhvdXQgYSBzZWF0IGJlbHQuDQoNClJlZ2FyZHMsDQogICBGZWxp
eA0KDQoNCk9uIDIwMjQtMDgtMDkgMDE6MzksIFpoYW5nLCBZaWZhbiB3cm90ZToNCj4gW0FNRCBP
ZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4NCj4g
WWVzLCBJIHRoaW5rIHdlIG5lZWQgdGhhdCBjaGFuZ2UgZm9yIGEgbm9ybWFsIGNvZGUgcGF0aCwg
YnV0IHRoaXMgY2FzZSBpcyBpbnRyb2R1Y2VkIG9ubHkgd2l0aCB0aGUgSFNBX09WRVJSSURFX0dG
WF9WRVJTSU9OIGVudmlyb25tZW50IHNldHRpbmcsIHdoaWNoIGltcGxpZXMgdGhhdCAidGhlIG92
ZXJyaWRlIEFTSUMgaXMgY29tcGF0aWJsZSB3aXRoIHRoZSByZWFsIEFTSUMuIiBJdCBpcyBpbnRl
bmRlZCBmb3IgZXhwZXJpbWVudGFsIHB1cnBvc2VzLiBXaGVuIGEgdXNlciBpcyB1c2luZyBIU0Ff
T1ZFUlJJREVfR0ZYX1ZFUlNJT04sIHRoZXkgc2hvdWxkIGJlIGF3YXJlIG9mIHRoZSBwb3RlbnRp
YWwgcmlza3MgaXQgbWF5IGJyaW5nLiBVc3VhbGx5LCBIU0FfT1ZFUlJJREVfR0ZYX1ZFUlNJT04g
aXMgdXNlZCB0byBmb3JjZSBhbiB1bnN1cHBvcnRlZCBBUFUgdG8gYmUgcmVjb2duaXplZCBhcyBh
IFJPQ20tc3VwcG9ydGVkIGhpZ2gtZW5kIGRHUFUsIHdoaWNoIGhhcyBhIGxhcmdlIGN3c3Igc2F2
ZSBhcmVhLCBtYWtpbmcgdGhlIG9wZXJhdGlvbiBzYWZlLiBUaGlzIGNoZWNrIHdhcyBhZGRlZCB0
byBLRkQgdHdvIHdlZWtzIGFnbywgdGhlIEhTQV9PVkVSUklERV9HRlhfVkVSU0lPTiBlbnZpcm9u
bWVudCBoYWQgYmVlbiB3b3JraW5nIGZpbmUgYmVmb3JlIHRoYXQuDQo+DQo+IEJlc3QgUmVnYXJk
cywNCj4gWWlmYW4NCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2Fz
aXZpc3dhbmF0aGFuLCBIYXJpc2ggPEhhcmlzaC5LYXNpdmlzd2FuYXRoYW5AYW1kLmNvbT4NCj4g
U2VudDogVGh1cnNkYXksIEF1Z3VzdCA4LCAyMDI0IDEwOjQ2IFBNDQo+IFRvOiBaaGFuZywgWWlm
YW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gQ2M6IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT47IFlhbmcsIFBo
aWxpcA0KPiA8UGhpbGlwLllhbmdAYW1kLmNvbT47IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5n
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IGtlZXAgY3JlYXRl
IHF1ZXVlIHN1Y2Nlc3MgaWYgY3dzcg0KPiBzYXZlIGFyZWEgZG9lc24ndCBtYXRjaA0KPg0KPiBb
QU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0K
Pg0KPiBJbiB0aGlzIGNhc2UsIHNob3VsZG4ndCBsYXJnZXIgb2YgdHdvIHNpemVzIGJlIHVzZWQu
IEFsc28sIHdlIHNob3VsZCBoYXZlIGFuIHVwcGVyIGJvdW5kIGNoZWNrLg0KPg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4gWWlmYW4gWmhhbmcNCj4gU2VudDog
VGh1cnNkYXksIEF1Z3VzdCA4LCAyMDI0IDQ6NDQgQU0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+IENjOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5j
b20+OyBZYW5nLCBQaGlsaXANCj4gPFBoaWxpcC5ZYW5nQGFtZC5jb20+OyBaaGFuZywgWWlmYW4g
PFlpZmFuMS5aaGFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRrZmQ6IGtl
ZXAgY3JlYXRlIHF1ZXVlIHN1Y2Nlc3MgaWYgY3dzciBzYXZlDQo+IGFyZWEgZG9lc24ndCBtYXRj
aA0KPg0KPiBJZiBIU0FfT1ZFUlJJREVfR0ZYX1ZFUlNJT04gaXMgdXNlZCBpbiBST0NtIHdvcmts
b2FkLCB1c2VyIHNwYWNlIGFuZCBrZXJuZWwgdXNlIGRpZmZlcmVudCBzcGVjIHRvIGNhbGN1bGF0
ZSBjd3NyIHNhdmUgYXJlYSwgY3VycmVudCBjaGVjayBtYXkgZmFpbCBjcmVhdGUgcXVldWUgaW9j
dGwuIENoYW5nZSBlcnJvciB0byB3YXJuIHRvIG1ha2UgY3JlYXRlIHF1ZXVlIHN1Y2NlZWQgaW4g
dGhhdCBjYXNlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZaWZhbiBaaGFuZyA8eWlmYW4xLnpoYW5n
QGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9xdWV1
ZS5jIHwgNCArLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0
aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3F1ZXVlLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcXVldWUuYw0KPiBp
bmRleCBlMGEwNzNhZTRhNDkuLjlmMjgzYWZmMDU3YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3F1ZXVlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX3F1ZXVlLmMNCj4gQEAgLTI5NSwxMSArMjk1LDkgQEAgaW50IGtmZF9xdWV1
ZV9hY3F1aXJlX2J1ZmZlcnMoc3RydWN0IGtmZF9wcm9jZXNzX2RldmljZSAqcGRkLCBzdHJ1Y3Qg
cXVldWVfcHJvcGUNCj4gICAgICAgICAgfQ0KPg0KPiAgICAgICAgICBpZiAocHJvcGVydGllcy0+
Y3R4X3NhdmVfcmVzdG9yZV9hcmVhX3NpemUgIT0gdG9wb19kZXYtPm5vZGVfcHJvcHMuY3dzcl9z
aXplKSB7DQo+IC0gICAgICAgICAgICAgICBwcl9kZWJ1ZygicXVldWUgY3dzciBzaXplIDB4JXgg
bm90IGVxdWFsIHRvIG5vZGUgY3dzciBzaXplIDB4JXhcbiIsDQo+ICsgICAgICAgICAgICAgICBw
cl93YXJuKCJxdWV1ZSBjd3NyIHNpemUgMHgleCBub3QgZXF1YWwgdG8gbm9kZSBjd3NyDQo+ICsg
c2l6ZSAweCV4XG4iLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgcHJvcGVydGllcy0+Y3R4
X3NhdmVfcmVzdG9yZV9hcmVhX3NpemUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICB0b3Bv
X2Rldi0+bm9kZV9wcm9wcy5jd3NyX3NpemUpOw0KPiAtICAgICAgICAgICAgICAgZXJyID0gLUVJ
TlZBTDsNCj4gLSAgICAgICAgICAgICAgIGdvdG8gb3V0X2Vycl91bnJlc2VydmU7DQo+ICAgICAg
ICAgIH0NCj4NCj4gICAgICAgICAgdG90YWxfY3dzcl9zaXplID0gKHRvcG9fZGV2LT5ub2RlX3By
b3BzLmN3c3Jfc2l6ZSArDQo+IHRvcG9fZGV2LT5ub2RlX3Byb3BzLmRlYnVnX21lbW9yeV9zaXpl
KQ0KPiAtLQ0KPiAyLjM3LjMNCj4NCj4NCg==
