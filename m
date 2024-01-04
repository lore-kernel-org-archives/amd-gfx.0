Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A602C3DA6E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 02:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A602210E2EA;
	Thu,  4 Jan 2024 02:40:06 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3868710E2EA
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 02:40:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HS2EExnKPbkFaVpDNXchlRohG4PnA1doRopifD2HgwFkaVx16GMbp3dN9f153JMvCdeB1hRuqDBGmk46w1MuIAmRUIF8/9ogYl1NDdehAa7av5FzhJX3CneZQpXSI7iM2mCacsIStEnqCXmjquPqGtlN/8fi4dy0MYiQ7Fhc9ymbgMNOORKJSNcewfbaO2yAk4QC+GondE7nbEjiaoR/s2AwX7b1WtuLMzssfuvob5j6XrWJHrjPYxiVgdWoDgA9h1zzfqG6NY5rJJZ8ADVdLvGVOgkpYFteZYIFPwhiJ+NwrSOBGJc2zCG+NqSEyIzir1zxLRxiB114lDUvqZ5KRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diAa9gG8tOpuhwQjYab6NVyePCwbl3C0siC2BkaPZJc=;
 b=Fai1TRoyO5HJ2MpM5OBA+QaPu0LRZRF5rb5FVG++T1bSSX7T2JhYen0j4MGd7Qny3N9A80IkKMrdYLe4n3ZZNK+IeJ3SPhvqr+iuACb1ulBvZgWQ04a6NQkBuh6nG2Aq2ZyaFLrF2K7gTejVmf8VkTCkypSrfxn7lhertm2LHEfGPQTDY4YG2Fv29qSyQkkz+GHs/rVcf+XCJTYDO1Im3UlQoa+yK0/Oc4rB2jcOsRHpeH828NCMZWVbXvUc6npqa50lTtphonz1unKL5w2IWNTRaNrf+2MFZH/NDNbW+/Ytcj7LfCL7X8Es3TgOZ6stR2ucZbDsYAS5j1oODntZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diAa9gG8tOpuhwQjYab6NVyePCwbl3C0siC2BkaPZJc=;
 b=JYGq1WBW/1Yke7sbhXqlHXnQduWrYzYCLnPDLY7XxPGf5UFOBqaLocQ/EH/H8Tn9GCGZ9h4M+diS1lN4Wkg6ES+mfG01OG1InOdLYXB+5VP7lg/xA5Ms4NHfIwuHQg1uvqUYE9rq/StmN5uuaZIUusiyv4gT3l8mdPHoXL/PdIg=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 02:40:03 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 02:40:03 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix variable 'mca_funcs' dereferenced before
 NULL check in 'amdgpu_mca_smu_get_mca_entry()'
Thread-Topic: [PATCH] drm/amdgpu: Fix variable 'mca_funcs' dereferenced before
 NULL check in 'amdgpu_mca_smu_get_mca_entry()'
Thread-Index: AQHaPrZAINYlX+USUEuwg0SMLinM4rDI75wQ
Date: Thu, 4 Jan 2024 02:40:02 +0000
Message-ID: <PH7PR12MB59977C3CC6C4876DF5063D628267A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240104023138.2226002-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240104023138.2226002-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=96f94589-e8d3-455f-8663-932e32aa863a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-04T02:34:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS0PR12MB8415:EE_
x-ms-office365-filtering-correlation-id: 3d445f23-63b8-4155-c24a-08dc0cce7408
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jIBJ4wJasd4Xfcme7ZI+9fQn7J5yTYt4tlytDGFisF5ucIhEXmluusgVygo01Ob4WmUIzzpz9n9LTS3+RePGLxphr2inLxyxaTBYBBAFIwRhxwfjhVPz/g2G+/fLCPrGsbP9e2qq7iF5NhgI055/0UEJLo1ZptT2r4Ernjyd7ZJ0W2rE4y/DP9NwsOfLUuQvfGaT3oSXyDuJ21gSUgt3+AuXZBLf0/C7iLeJuWcxSZP6k4UVrIFN3Ha1s+bdPhyK5asGZHO57YJ3x7zW2i3upmdd5BF0JqkUB9pBmT6OzwYdyrpeokLBgz1RtNrOWG8BuuuftW44C5v8yTwYoZ5I4yO3X1/3q3fTgZbabYp9O9DTSDPArjhq07TDjM6wpJ2AhhY/M9b/kfl21z+iM4zQep13uuNB4z43+ePvjv3cfCY16TX4hjF7PQnRvbI4Ho/w1HxFfF6nCC8ua/aHJ9RFTZaDuECGbdXoS5prvEL8cm2PQ0Ifv1YE/4bzdUKMyXON5hOHjWNRSaUuT5M5UdWtiyPRQ8mkbc4ziMauNsfQPWoOY88192ZKwC40lWAD4typjA9AMR5li3E8x6IlRah1W50JYbCmOirGmeqvHfp+lbA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(26005)(41300700001)(38100700002)(122000001)(5660300002)(8936002)(8676002)(71200400001)(110136005)(316002)(54906003)(4326008)(6636002)(478600001)(2906002)(52536014)(53546011)(76116006)(66446008)(7696005)(6506007)(64756008)(66476007)(9686003)(66556008)(66574015)(66946007)(38070700009)(86362001)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aU1GakJWWVBsWE1idGJnbGZROWgzdnduUXZHWWVMSUI2ZTRqRE5FMGJXcVlj?=
 =?utf-8?B?UUtua0VHVHhHMTBpazUvTkM0QXEzTDhRdU1pNWxuZWNUejRhR3R4QTlTdmNK?=
 =?utf-8?B?dEJFTy9kcTRCRXV6TG44MjFadWw3M0ZkRFdHeEVQYXhZS2t6MW4vQTRBVFp6?=
 =?utf-8?B?MFJEdXZ6SlNPaDVkVnU0RVBRT1ZhVy9oWVAxdktMQ1Njby9jQnY4TGp0R2RV?=
 =?utf-8?B?ZGorOU1SY3FqK25oaVM5ZTV3N0Q1eU96VzMwc0NWd0JxSnlYbTMrd2M0UWwv?=
 =?utf-8?B?MHl5RlZyZ2hhcXcvS3VNWXlPL3Q4bkJ6VVh0WFprZUtnVCt0bDRCT0d0QTlI?=
 =?utf-8?B?dUpqS2NJM1NhZUpuUU1OZkU4K3N6SkFQbnBNVWhMOEg2WllnSitCRFBtbi83?=
 =?utf-8?B?aGkrS3JzNjQ5VXI1TDFkZFhzZmVHcTBzQUdkVldYbG0vVFNOYVVKRjJsTTEy?=
 =?utf-8?B?TnV6NlNoWTBRa1N0OUNNSVp3eU1MY2R1UjRSa1YwcklVSUpPMTVEM09FNGNj?=
 =?utf-8?B?WHJ5SU9Mam03dFZXVWNZWmRnbGM1TUEyOEIzTlY2ZzUrbU5YNWwxNFBwc1BC?=
 =?utf-8?B?OXU0RklMVitOcnlOTjlGcUtKY3JWc1VIUTNKYUs5K2lIcVFaclI3NDg4UWxE?=
 =?utf-8?B?cTlpSVhhNnlhZFhab0hlekQ1dTUwZS80dUxRN1BwZFBJQ1ZqTmxoSFJGdDd4?=
 =?utf-8?B?T2ZxbFB1VmJCcWxpWmZTU2JPcWhzaWJaK2Rrcm0yT2pzcm9aQWFTaXZEOURV?=
 =?utf-8?B?MTdqMlFNQktDSGExMFNxNkFXRThBRFhFai9YSUZZWW5XdVFlYXZRem1ocFQ2?=
 =?utf-8?B?TE5qb2RwdjZ3dWRjc1p0QjNiVTdjaU1XNjVwT1BKYXF5L0s1d2txL3VFajVL?=
 =?utf-8?B?MEV6VkYzM0JwUHRmKzdITUZ1c1hSTFFrQm9oTWp3K25IOTRkTjRqbFpobSt1?=
 =?utf-8?B?MTJOdGFZb2FnckxXcjV6Q1Roby9HSm5SaFpsbnVpM2lRa1B3cmd6YnVrK2tB?=
 =?utf-8?B?bjd5bC8vR0xKNERKRHRuUDI2aFhkMC9sRTVSa016dThHN3NhVGEwdWtSUTZC?=
 =?utf-8?B?bTZiYXdTWFpSVjBEYUNVMk1WM1NGNXpZMjlBTms2eXlkVEtsa1dZV2J1bTJK?=
 =?utf-8?B?S1Z5RTVWeG1EY3B5Q3lNL0dGNEVYdTFaa2dEcVBNWDF0c0g5bmRGc1NTUHQ0?=
 =?utf-8?B?M1Y1anBZV0hmd2x4ZlBCRzJ1ZVJnQ0hHek5BNmoyNlFsTlFuem1xSWp5MnhD?=
 =?utf-8?B?c09Lc2lNVG9BS0dwQldKNkoxcEhaSmdUYUJSSlF0MUJFajhRYjI3KzFFMFNX?=
 =?utf-8?B?MnhUL3FBd3A3bnBQbEJYenNBRitvVGkrb24rUGpXdzRlc2YwekQxenNmRkN3?=
 =?utf-8?B?ZnhsZ1RHYzY5eUwyaGVEUE4rVTBsZmN1WHRtakhpUXBRYS81WTJoRUYvbVI3?=
 =?utf-8?B?U1VZc1ozYW9ObWwyNnNDelNxN3ZLNDZRUDV6S0NLcGJwUWZwa3NuaUtiVnNo?=
 =?utf-8?B?YmRWcDdHVXZLaUJHd08va0g1Y016eUgwemlzbFFWelppc3VEakJ6dWltYVF2?=
 =?utf-8?B?am10L3ZNR2p3L0N1aXcrb01UV0Njd1JBZGVZQkZEYm54OVIrS1IyWmVQdUh4?=
 =?utf-8?B?MVllQWszTTJyWTkvcEZzS25CVnJ5TzdFenQ5a09jWXp6MUVuRzNIT2RZSXMx?=
 =?utf-8?B?ZG5zYzhkMUthTHRHZmlQajlqMGNzcnBDSEhxUldlc056ZGhaRG5IZUYzTUhu?=
 =?utf-8?B?bmhhWTRVU0xRQmtRT1NEelpleC93TzIxZVRZWE1YMUkrdGh5TnMyelRQWFk3?=
 =?utf-8?B?VFc0SlVPYU16RFdEakNtYlA0UDljNTZieUQxS2ErNFpYUTNNdjVWeGxTSXJr?=
 =?utf-8?B?VGJlTXQ2TEFsSUFoME9aMXMvdEtvNnppTG10MkhrYU9vYTVNVkxSbWZpSTVT?=
 =?utf-8?B?TlpReGw1K2RiQzJqc29DOUhtcTJRaUlDVmRvejBPOFFHZU9hUnJtQ0pZNzY2?=
 =?utf-8?B?d3NUMDE3NWU4Q0w2bU1ObXNqQUZER2ttUDR2aXJSQ1dYdk5BMnl6ZVhQTjZz?=
 =?utf-8?B?aEtaM0VaV3YvQmFmSTF4WHJlbklFeVFoTVJKMlBoRDQ4bFVnajFpUkRXWXVx?=
 =?utf-8?Q?RTSY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d445f23-63b8-4155-c24a-08dc0cce7408
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 02:40:02.9133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17w6nsgFpoa11amjjKeHB9cwoLoVdTj23qRorJEedcujckGCNSBjk741D1YqiswZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FN
QGFtZC5jb20+DQpTZW50OiBUaHVyc2RheSwgSmFudWFyeSA0LCAyMDI0IDEwOjMyIEFNDQpUbzog
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBD
aHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdB
TUBhbWQuY29tPjsgV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5nQGFtZC5jb20+OyBa
aGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBGaXggdmFyaWFibGUgJ21jYV9mdW5jcycgZGVyZWZlcmVuY2VkIGJlZm9yZSBO
VUxMIGNoZWNrIGluICdhbWRncHVfbWNhX3NtdV9nZXRfbWNhX2VudHJ5KCknDQoNCkZpeGVzIHRo
ZSBiZWxvdzoNCg0KZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21jYS5jOjM3NyBh
bWRncHVfbWNhX3NtdV9nZXRfbWNhX2VudHJ5KCkgd2FybjogdmFyaWFibGUgZGVyZWZlcmVuY2Vk
IGJlZm9yZSBjaGVjayAnbWNhX2Z1bmNzJyAoc2VlIGxpbmUgMzY4KQ0KDQozNTcgaW50IGFtZGdw
dV9tY2Ffc211X2dldF9tY2FfZW50cnkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW51bSBhbWRncHVfbWNhX2Vycm9yX3R5
cGUgdHlwZSwNCjM1OCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgaWR4LCBz
dHJ1Y3QgbWNhX2JhbmtfZW50cnkgKmVudHJ5KQ0KMzU5IHsNCjM2MCAgICAgICAgIGNvbnN0IHN0
cnVjdCBhbWRncHVfbWNhX3NtdV9mdW5jcyAqbWNhX2Z1bmNzID0NCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPm1jYS5tY2FfZnVuY3M7DQozNjEg
ICAgICAgICBpbnQgY291bnQ7DQozNjINCjM2MyAgICAgICAgIHN3aXRjaCAodHlwZSkgew0KMzY0
ICAgICAgICAgY2FzZSBBTURHUFVfTUNBX0VSUk9SX1RZUEVfVUU6DQozNjUgICAgICAgICAgICAg
ICAgIGNvdW50ID0gbWNhX2Z1bmNzLT5tYXhfdWVfY291bnQ7DQoNCm1jYV9mdW5jcyBpcyBkZXJl
ZmVyZW5jZWQgaGVyZS4NCg0KMzY2ICAgICAgICAgICAgICAgICBicmVhazsNCjM2NyAgICAgICAg
IGNhc2UgQU1ER1BVX01DQV9FUlJPUl9UWVBFX0NFOg0KMzY4ICAgICAgICAgICAgICAgICBjb3Vu
dCA9IG1jYV9mdW5jcy0+bWF4X2NlX2NvdW50Ow0KDQptY2FfZnVuY3MgaXMgZGVyZWZlcmVuY2Vk
IGhlcmUuDQoNCjM2OSAgICAgICAgICAgICAgICAgYnJlYWs7DQozNzAgICAgICAgICBkZWZhdWx0
Og0KMzcxICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCjM3MiAgICAgICAgIH0NCjM3
Mw0KMzc0ICAgICAgICAgaWYgKGlkeCA+PSBjb3VudCkNCjM3NSAgICAgICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQozNzYNCjM3NyAgICAgICAgIGlmIChtY2FfZnVuY3MgJiYgbWNhX2Z1bmNz
LT5tY2FfZ2V0X21jYV9lbnRyeSkNCiAgICAgICAgICAgICAgICBeXl5eXl5eXl4NCg0KQ2hlY2tl
ZCB0b28gbGF0ZSENCg0KQ2M6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCkNj
OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQpDYzogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2Ft
IDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X21jYS5jIHwgNSArKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9tY2EuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9tY2EuYw0KaW5kZXggODkxMTMxMGY5OGRmLi4xODc5MGQ1Yzk2YzcgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWNhLmMNCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tY2EuYw0KQEAgLTM2MCw2ICszNjAsOSBAQCBpbnQgYW1k
Z3B1X21jYV9zbXVfZ2V0X21jYV9lbnRyeShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgZW51
bSBhbWRncHVfbWNhX2Vycg0KICAgICAgICBjb25zdCBzdHJ1Y3QgYW1kZ3B1X21jYV9zbXVfZnVu
Y3MgKm1jYV9mdW5jcyA9IGFkZXYtPm1jYS5tY2FfZnVuY3M7DQogICAgICAgIGludCBjb3VudDsN
Cg0KKyAgICAgICBpZiAoIW1jYV9mdW5jcyB8fCAhbWNhX2Z1bmNzLT5tY2FfZ2V0X21jYV9lbnRy
eSkNCisgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7DQorDQogICAgICAgIHN3aXRj
aCAodHlwZSkgew0KICAgICAgICBjYXNlIEFNREdQVV9NQ0FfRVJST1JfVFlQRV9VRToNCiAgICAg
ICAgICAgICAgICBjb3VudCA9IG1jYV9mdW5jcy0+bWF4X3VlX2NvdW50Ow0KQEAgLTM3NCw3ICsz
NzcsNyBAQCBpbnQgYW1kZ3B1X21jYV9zbXVfZ2V0X21jYV9lbnRyeShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgZW51bSBhbWRncHVfbWNhX2Vycg0KICAgICAgICBpZiAoaWR4ID49IGNvdW50
KQ0KICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KDQotICAgICAgIGlmIChtY2FfZnVu
Y3MgJiYgbWNhX2Z1bmNzLT5tY2FfZ2V0X21jYV9lbnRyeSkNCisgICAgICAgaWYgKG1jYV9mdW5j
cy0+bWNhX2dldF9tY2FfZW50cnkpDQogICAgICAgICAgICAgICAgcmV0dXJuIG1jYV9mdW5jcy0+
bWNhX2dldF9tY2FfZW50cnkoYWRldiwgdHlwZSwgaWR4LCBlbnRyeSk7DQoNCltrZXZpbl06DQoN
CmlmIChtY2FfZnVuY3MtPm1jYV9nZXRfbWNhX2VudHJ5KQ0KSSB0aGluayB5b3UnZCBiZXR0ZXIg
cmVtb3ZlIHRoaXMgY29uZGl0aW9uIGJlY2F1c2UgdGhlIGFib3ZlIGNvZGUgaXMgYWx3YXlzIHRy
dWUsIHJpZ2h0ID8NCg0KV2l0aCB0aGF0IGZpeCwgdGhlIHBhdGNoIGlzLg0KUmV2aWV3ZWQtYnk6
IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCg0KQmVzdCBSZWdhcmRzLA0KS2V2
aW4NCg0KICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7DQotLQ0KMi4zNC4xDQoNCg==
