Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36FCCD691B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 09:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F37510E1BF;
	Tue, 10 Oct 2023 09:44:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AA2410E1C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 09:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgvVJ2gkO6zH6g4Xg9nVcplQu9GpVNlUw/vPSh/bkKd/D4o3fcO7Kx1lx7LRwV8hphke0r7Ppwuru1PriF4IM3usjEKSEou4L+mdF+HpC6mK0bn/t4UHbI3lgrTQLDQDxYKk33IMprcO7B0lBqh4msfyjvU1kGM+gb1DRxPJhN859bDp4qQ7WoLCznmUBf3dQQm48hKHNQCirvxI1IyMwY5K4Ve4Hq5yZS0mLsF836ZR8bYDlJx1quacV+Cyz+x/R27SarP6PiSEfehqqP+r7kxwOwYSNALsXD1qdRf0BSNxQzJvh7tG8mC3d09kHsedO6knff6jl9rocFeqaicyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbJOYsTd035q3cf7FztHwIr0SaI4r2ChSFolWRZWUEU=;
 b=iNcnZG+me4CnpTr5WW/IYiecmoknLvHGAkzUjqt2D8t0PS0VnN0BPB0/Xz3zmiczs7Q8iAWIZK0TQE+3QLI+kgwV2e8z3iBduyEk3YKtS6uJ9NLo072GVDqr4s9D+mjRUYCBf2NikiR/6BXN0dznvtKcMx2JSZT6uQaqntV/6XyjgsFa4x/KEKqFWcY66O1I5uImZ5TF70Tplr0sbBgRyKKk/58uN0smBWV/oTIxSpa1Jdn36ffFUCqVJLvyFVrW7/rMXS3XI3cJBfe4pLHFwQ01u8rxhXjP7moIfl64Ch9MJulltrgRYJr5E16d83RLjNvJxTCDrIb5DJRyaYHTxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbJOYsTd035q3cf7FztHwIr0SaI4r2ChSFolWRZWUEU=;
 b=e86o7yIUEIeh0d3t9VjEP+4exb4WkfIS4jFHSVo7eM6jKtULOrICkF6GDO7jVB8E+2cydpLcJ4gSug0WIqeWIKpu4v5W/XnNjozb+wVh9fnQ+NOJc/vUzxTV7JDahdpBu1HaF+67/reXC1+x4GBTQ2UxtBQCm1Vbe850NOWbg68=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 09:44:25 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::dcd1:7d96:fd8a:ba35]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::dcd1:7d96:fd8a:ba35%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 09:44:25 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Thread-Topic: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Thread-Index: AQHZ+c8qZ0SmqTbiB0uJBjZ5G/CDQ7A/5QOAgADKnbCAAHhagIABhvew
Date: Tue, 10 Oct 2023 09:44:25 +0000
Message-ID: <CH2PR12MB4152B02343D266D3F61A8FF6FECDA@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20231008100642.1915677-1-Feifei.Xu@amd.com>
 <PH7PR12MB59972CEAF0241F48E6B342CE82CFA@PH7PR12MB5997.namprd12.prod.outlook.com>
 <CH2PR12MB4152A458EC29B83672A600FCFECEA@CH2PR12MB4152.namprd12.prod.outlook.com>
 <10a568bd-e514-4ce1-b3d5-3c7534a8f3e7@gmail.com>
In-Reply-To: <10a568bd-e514-4ce1-b3d5-3c7534a8f3e7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ae2e522e-c1b0-4e23-b578-7c8d202fd1ae;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-10T08:10:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|DM4PR12MB5120:EE_
x-ms-office365-filtering-correlation-id: 6efe4a98-6997-4f11-551e-08dbc9757d27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BrtYI1lmC3mQyOUUhPmOTphbS8q9kwJWpY6sSNRMEdpExBWgHCzhYVeMRQSRm5bizJAnq6khBnDfQV3fxEOk4hj/YM4HhJwCaXHKJ2px/uvUpEM8WQ5yTDuUceGRZmpkE1rP16u8AZkPKpThTwvYICsvw7W2C0dtPRCY2fPTy8rMENjQKlsuPJIZP40RAtpet+vFmBU8fzBTSrDn3uFwedr98+Gb7Sk1NzGhafyKwtcMom8MWP91ZQ6LF6T2Mx4baLI71dnnBvLjyOmvfUACt/ht+WKJ9dhUVA3iRwZgrr4C0hOeuvZS0LMm24uloslxZJ12m8Vax95mW+CUSCwfHBomDy2UDNZSbmsHnSQnM90GaccUiwnDaicIqHZqO61oYfaijntjhzgdWAV6ARfET3eLvaidmkH/UJdIljeovb26EyQBnTH3EBl0JJXg1C0Setzp6Sb4dlCVlMuTq3CM2b6oAnEGnFNErFkRW+K/vUXKv/Hdr6zptHb7j4WWuXyCco5UVoMg1JvIa2kkC/vpWGDHJ9OJ6sOfJpnSGO4GDl4z36BCOoHYyIAjgk9m5mDWOSgA6MXPCwM6+6ZOAr6j/BpXC3+fPnRndjyj7Bd1QowZy2ls7Bw7FMa2OXPbiDth
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(26005)(38070700005)(66946007)(66556008)(110136005)(54906003)(64756008)(66446008)(66476007)(316002)(76116006)(33656002)(41300700001)(53546011)(38100700002)(4326008)(8936002)(2906002)(8676002)(122000001)(52536014)(5660300002)(55016003)(66574015)(71200400001)(6506007)(7696005)(86362001)(9686003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTJJaVI5cnNrL0hNSU4rd0dTbW1YeGJlNmp4NG1FSzBmRHJUNHBrNmtyU2lx?=
 =?utf-8?B?MkhZb1krRXRLT2MwOEFnVVUzMHZiUlhOcFlaREovNW5NNlcrTGRIcXRsUXBP?=
 =?utf-8?B?V1MvU0pkdGx1T3c5bXF0a2xnaHVYS2xMbW8wREZFdHR1WDkxUVJrS01SNUQy?=
 =?utf-8?B?VlJQa2ZUTCtNeHhsV3dnU3BGNTVRSWpBK0Zjd21uUDRnS2dTbjc1N2ZWS2pN?=
 =?utf-8?B?SDlzekFlMVpsMmRqMUQ1S2ZzVmcyd1pqakhpTUEwN09qMmNmQU1TcTNhWmty?=
 =?utf-8?B?d296VTB0d1gzNlpiUXE2amhRb2hvb2lGeXJvamdLdGFXWm13Sms3SHkxTEpF?=
 =?utf-8?B?ZFhvSVRBbGlnUG43VnBBVDdvVDdLUVd4eE9hZ01pOVNRdmMwa2tybTFLSVNp?=
 =?utf-8?B?ZFFocjcyUEUzSFBiV3VyUCs4YUowdjJTeENROEpKdDdBNUhON1UrNlp4VEFL?=
 =?utf-8?B?bGdVeUZEekdHelRNdU5mbWZUZmlPWWNIVWhYYkVyWHVrcllmYlNBOWZ0VUE3?=
 =?utf-8?B?UzRTd1ZUdGhwbkpSU3REdnZLckZGdnhFK2ZYWkRlbHlrSmMrS3VIdnlZTzFs?=
 =?utf-8?B?VFh4d3JLaDFZZFpaOSt3ZHFXcWx2bXZ2Sm9WSWkreVBjMlhxMzZHWnduRmlk?=
 =?utf-8?B?MUtXSXNaT0gxTUJwZWtGN29NMU9LVWRid0tJTlRieEd4SmYzb0RmTjZLRlhk?=
 =?utf-8?B?UlR4RWpuY1VrNUtpYjRqeTJpMVhKeExkb1FNQjQyTlR5S1lQMW9XVlFGM3Vw?=
 =?utf-8?B?NnlMb01vVzkrQmdiSVBpakJGemVMUkdpKzZqSVhZTUVBZ0Zlbk1tMUtkSkNk?=
 =?utf-8?B?dEZTWkU3T2E4TlpSNVM4RG95MG5mMkZLcmdLN1BtYzVTYUxhem82SHlJTVBX?=
 =?utf-8?B?c0xMS3R1S0tvbzBQckhtc3N5MnpzTjQ4amtiamNoNXhYZE9udnBTeEJuWm1v?=
 =?utf-8?B?VjBOR0RqWUE5VjladXpiUzNBM2dib0V4NDVnZzRaeTNFcm5NVnhJL3ZRZVVX?=
 =?utf-8?B?TDRHc0w3OHc2QlpqemJvcG4rSzdTdENFVlhTR3FibVhtNndjNnZQUmU5QVZv?=
 =?utf-8?B?aHo0Y0dvMXZyZXNmUThQYjhjNmRRRFpnLzBQcjMzbVNEK0xYOU1COFJRMmJ0?=
 =?utf-8?B?QlM4TG5EWm56UFVJYTQxZnIrcFZZUmFySVdIdnhwT2I5RzlXMmZMMGtHNnd1?=
 =?utf-8?B?cWJVc1ViZTZLQ29WRkFUaDBobWVTTHR4SkNGRnFnREpsK2FZaDFrZnpnekp2?=
 =?utf-8?B?MFZiRW5JZGNxZ2dFWmtLbW5yalROQ2tyWFd0ckYxZk1udFYxMXpZUk9EYU9z?=
 =?utf-8?B?Ymt5bWZjRDdNUmdQbERBd3NCU1lEd0VYNXhhVHNOUVFqTnhIdDZoZTVEcUFX?=
 =?utf-8?B?Q1NLeENPR282NXBrcHdCOGtLS0hVanphc21FOUxSUExQS1U2MmhXaTlMWGY5?=
 =?utf-8?B?NkNzN01zMGZkZWJoV083YnR0ZzdOdEZoVUFDZEVKV1oyb2hwcjJnbFNTczlv?=
 =?utf-8?B?TDRabUxabHMrUE4rbjdoVFlmSmZldDlyZGhSNmFpSlBkMDhNQW5OdE5XN2JI?=
 =?utf-8?B?RWgyWXBlRmV5a1hSQ0N2ZXJFN3pJOFZEdnptZVBGVmZUMEpacjN3eFp5dGl5?=
 =?utf-8?B?czhqTmVSaWNGcjlYdzNjNW1XcUFRRXdlbUpxVVoyeUlRZUJRdGJhMUxuVk83?=
 =?utf-8?B?YllnWWtKUzUzT3RJMDE3T3QwTHBkcUxXQjlsalViaEV6d1NQU016MHBHaW5x?=
 =?utf-8?B?Q0dRaXpMUGdFTWs1dnU5RTNORzRWbUkveThoNWYzN3hLeWpjTEdnWHFoNjJO?=
 =?utf-8?B?NVFLb0syVlBTa0E4U1k0QlE2MGpqTy84MGJrMFBkcXZIR3hKTld2dExISndY?=
 =?utf-8?B?TkhmNEVxMDFRb21sbENURUJoK2IwK3NvQVRsLy8zNjJPTlMxREgvdVFBTzh3?=
 =?utf-8?B?cVc3eWpnNXlsSWh1WUF0UFR2MG5mR1dnSE5MbVRhQXBFeWdjNVIzQ2FiZzVq?=
 =?utf-8?B?TzhRYURLVVk0K2RTeUlnMDFWclAzMjJBTk9mMENzZ01uMmoxVWVObXlBVVIz?=
 =?utf-8?B?R1U0MURzamxoMGJyeGoyOXFjZkJ3RG9IbmZFTXV3cDFVTWxjVTlBdTljd2dr?=
 =?utf-8?Q?4VC0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efe4a98-6997-4f11-551e-08dbc9757d27
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 09:44:25.1141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1dtwVF5PBr4ovzY6R6lyYZ5pPPrdYzPKQPi8vwyxU3DFQZQ3lvkvzL8cPtlrgZHf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4+IFRoZW4gYSBUTEIgZmx1c2gg
c2hvdWxkbid0IGJlIG5lY2Vzc2FyeSBvbiByZXNldC4gQSByZXNldCBpbXBsaWVzIHRoYXQgdGhl
IFRMQiBpcyBjbGVhcmVkIGFzIHdlbGwuDQpIbW0sIGluIGN1cnJlbnQgaW1wbGVtZW50YXRpb24s
IHdoZW4gd2Ugc2F5IGEgcmVzZXQgaW1wbGllZCB0aGF0IHRoZSBUTEIgaXMgY2xlYXJlZCwgYXNz
dW1lIHRoYXQgdGhlIFRMQiBjbGVhciBpcyBwdXJlbHkgaGFyZHdhcmUgYWN0aW9uLiBUaGVyZSdz
IG5vIGdwdSB0bGIgZmx1c2ggaW5pdGlhdGVkIGJ5IHNvZnR3YXJlL2RyaXZlciBhZnRlciBzdXNw
ZW5kLg0KDQpXaGlsZSBpbiBzb21lIGFzaWNzIG9mIGdmeDExIChsaWtlIG52MzEpLCBncHUgdGxi
IG5lZWQgdG8gYmUgZmx1c2hlZCBieSBzb2Z0d2FyZS9kcml2ZXIgYWZ0ZXIgc211IHJlc3VtZSBz
dWNjZXNzZnVsbHkgaW50ZW50aW9uYWxseS4NCldpdGhvdXQgdGhlIGdwdSB0bGIgZmx1c2ggb24g
bnYzMSwgUzMgb3IgcmVzZXQgd2lsbCBiZSBicmVhayB3aXRoIGdmeCBwYWdlIGZhdWx0Lg0KDQo+
PiBGaXJzdCBvZiBhbGwgdGhlIHBhdGNoIGlzIGJyb2tlbiBiZWNhdXNlIHlvdSBvbmx5IGhhbmRs
ZSB0aGUgbG9ja2luZywgYnV0IG5vdCB0aGUgdW5sb2NraW5nIHBhcnQuDQpGb3IgdGhlIHVubG9j
a2luZyBwYXJ0LCByZWFsaXplZCB0aGF0IHlvdSBhbmQgS2V2aW4gYXJlIGNvcnJlY3QuIExvY2sv
dW5sb2NrIG5vdCBwYXJpZWQuDQoNClRoYW5rcywNCkZlaWZlaQ0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtl
bkBnbWFpbC5jb20+DQpTZW50OiBNb25kYXksIE9jdG9iZXIgOSwgMjAyMyA0OjUyIFBNDQpUbzog
WHUsIEZlaWZlaSA8RmVpZmVpLlh1QGFtZC5jb20+OyBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5Z
YW5nLldhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogS29l
bmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5n
IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1
OkNoZWNrIGdmeCBwb3dlcm9uIHdoZW4gc2tpcCBmbHVzaF9ncHVfdGxiDQoNCkFtIDA5LjEwLjIz
IHVtIDAzOjUwIHNjaHJpZWIgWHUsIEZlaWZlaToNCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAt
IEdlbmVyYWxdDQo+DQo+IEhpLA0KPg0KPj4+IEJhc2VkIG9uIHlvdXIgZGVzY3JpcHRpb24sIHRo
ZSBhYm92ZSBjb2RlIHNob3VsZCB1c2UgInx8IiBpbnN0ZWFkIG9mDQo+Pj4gIiYmIiwNCj4gJiYg
aXMgdG8gYWRkIG1vcmUgcmVzdHJpY3Rpb24gaGVyZS4gIFRvIGF2b2lkIHNraXBwaW5nIG5lY2Vz
c2FyeSBUTEIgZmx1c2ggYnkgcmV0dXJuLg0KPiBGb3IgQXNpY3MgPCBHRlgxMSwgIWFkZXYtPmdm
eC5pc19wb3dlcm9uIGlzIGFsd2F5cyB0cnVlICh0aGlzDQo+IHBhcmVtZXRlciBpcyBpbnRydWRv
Y2VkIGZyb20gR0ZYMTEpLCBvbmx5IGRlcGVuZHMgb24gcmVzZXRfZG9tYWluLT5zZW07IEZvciBB
c2ljcyA9IEdGWDExLCAhYWRldi0+Z2Z4LmlzX3Bvd2Vyb24gbWlnaHQgYmUgZmFsc2UgKHdoaWNo
IGdmeCBtaWdodCBhbHJlYWR5IHBvd2Vyb24gaW4gdGhlIHJlc2V0KSwgdGhpcyB3aWxsIG1ha2Ug
dGhlIGlmICgpIG5vdCB0dXJlLCByZXR1cm4gd2lsbCBub3QgYmUgZXhlY3V0ZWQsIHRodXMgZmx1
c2ggVExCLg0KDQpGaXJzdCBvZiBhbGwgdGhlIHBhdGNoIGlzIGJyb2tlbiBiZWNhdXNlIHlvdSBv
bmx5IGhhbmRsZSB0aGUgbG9ja2luZywgYnV0IG5vdCB0aGUgdW5sb2NraW5nIHBhcnQuDQoNClRo
ZW4gYSBUTEIgZmx1c2ggc2hvdWxkbid0IGJlIG5lY2Vzc2FyeSBvbiByZXNldC4gQSByZXNldCBp
bXBsaWVzIHRoYXQgdGhlIFRMQiBpcyBjbGVhcmVkIGFzIHdlbGwuDQoNCldlIGRpc2N1c3NlZCB0
aGUgcG9zc2liaWxpdHkgdG8gYXZvaWQgdGhhdCwgYnV0IHRoaXMgaXMgbm90IHN1cHBvc2VkIHRv
IGJlIGhhcHBlbmluZyBhdCB0aGUgbW9tZW50Lg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+
DQo+Pj4gQW5kIGFmdGVyIG1lcmdpbmcgY29kZSBpbnRvIG9uZSBsaW5lIG1heSByZXN1bHQgaW4g
dGhlIGxvY2sgbm90IGJlaW5nIHJlbGVhc2VkIGlmIHRoZSBsb2NrIGNhbiBiZSBhY3F1aXJlZCBz
dWNjZXNzLg0KPiBJZiAhYWRldi0+Z2Z4LmlzX3Bvd2Vyb24gaXMgdHJ1ZSwgdGhlIHJlc2V0X2Rv
bWluLT5zZW0gd2lsbCBub3QgYmUgZG93bl9yZWFkX3RyeWxvY2ssIHRodXMgY291bGQgYXZvaWQg
dGhpcyBkZWFkbG9jay4NCg0KPg0KPiBUaGFua3MsDQo+IEZlaWZlaQ0KPg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldh
bmdAYW1kLmNvbT4NCj4gU2VudDogU3VuZGF5LCBPY3RvYmVyIDgsIDIwMjMgOTozNiBQTQ0KPiBU
bzogWHUsIEZlaWZlaSA8RmVpZmVpLlh1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBDYzogWHUsIEZlaWZlaSA8RmVpZmVpLlh1QGFtZC5jb20+OyBYdSwgRmVpZmVp
IDxGZWlmZWkuWHVAYW1kLmNvbT47DQo+IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZw0KPiA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0K
PiBTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kZ3B1OkNoZWNrIGdmeCBwb3dlcm9uIHdoZW4g
c2tpcA0KPiBmbHVzaF9ncHVfdGxiDQo+DQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+
IE9uIEJlaGFsZiBPZg0KPiBGZWlmZWkgWHUNCj4gU2VudDogU3VuZGF5LCBPY3RvYmVyIDgsIDIw
MjMgNjowNyBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IFh1
LCBGZWlmZWkgPEZlaWZlaS5YdUBhbWQuY29tPjsgWHUsIEZlaWZlaSA8RmVpZmVpLlh1QGFtZC5j
b20+Ow0KPiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgWmhh
bmcsIEhhd2tpbmcNCj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OkNoZWNrIGdmeCBwb3dlcm9uIHdoZW4gc2tpcCBmbHVzaF9ncHVfdGxiDQo+
DQo+IFRvIGZpeCB0aGUgZ3B1IHJlY292ZXJ5IGZhaWxlZCBvbiBHRlgxMSB3aXRoIGdmeGh1YiBw
YWdlZmF1bHQsIGZsdXNoIGdwdSB0bGIgYWZ0ZXIgcmVzZXQgb24gR0ZYMTEuDQo+IEdmeGh1YiB0
bGIgZmx1c2ggbmVlZCBjaGVjayBpZiBhZGV2LT5nZnguaXNfcG93ZXJvbiBzZXQuDQo+DQo+IEZp
eGVzOiBkMGM4NjBmMzM1NTMgKCJkcm0vYW1kZ3B1OiByZXdvcmsgbG9jayBoYW5kbGluZyBmb3Ig
Zmx1c2hfdGxiDQo+IHYyIikNCj4NCj4gU2lnbmVkLW9mZi1ieTogRmVpZmVpIFh1IDxGZWlmZWku
WHVAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dtYy5jIHwgMyArKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ21jLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMN
Cj4gaW5kZXggMmY5YmI4NmVkZDcxLi4wNDhkMzJlZGVlODggMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMNCj4gQEAgLTYxMSw4ICs2MTEsOSBAQCB2b2lkIGFt
ZGdwdV9nbWNfZmx1c2hfZ3B1X3RsYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMy
X3Qgdm1pZCwNCj4gICAgICAgICAgICAgICAgICAvKg0KPiAgICAgICAgICAgICAgICAgICAqIEEg
R1BVIHJlc2V0IHNob3VsZCBmbHVzaCBhbGwgVExCcyBhbnl3YXksIHNvIG5vIG5lZWQgdG8gZG8N
Cj4gICAgICAgICAgICAgICAgICAgKiB0aGlzIHdoaWxlIG9uZSBpcyBvbmdvaW5nLg0KPiArICAg
ICAgICAgICAgICAgICogRm9yIEdGWDExLCBnZnhodWIgZmx1c2ggY2hlY2sgaWYgYWRldi0+Z2Z4
LmlzX3Bvd2Vyb24gaXMgc2V0Lg0KPiAgICAgICAgICAgICAgICAgICAqLw0KPiAtICAgICAgICAg
ICAgICAgaWYgKCFkb3duX3JlYWRfdHJ5bG9jaygmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pKQ0K
PiArICAgICAgICAgICAgICAgaWYgKCFkb3duX3JlYWRfdHJ5bG9jaygmYWRldi0+cmVzZXRfZG9t
YWluLT5zZW0pICYmDQo+ICshYWRldi0+Z2Z4LmlzX3Bvd2Vyb24pDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm47DQo+DQo+IFtLZXZpbl06DQo+IEJhc2VkIG9uIHlvdXIgZGVzY3Jp
cHRpb24sIHRoZSBhYm92ZSBjb2RlIHNob3VsZCB1c2UgInx8IiBpbnN0ZWFkIG9mDQo+ICImJiIs
IEFuZCBhZnRlciBtZXJnaW5nIGNvZGUgaW50byBvbmUgbGluZSBtYXkgcmVzdWx0IGluIHRoZSBs
b2NrIG5vdCBiZWluZyByZWxlYXNlZCBpZiB0aGUgbG9jayBjYW4gYmUgYWNxdWlyZWQgc3VjY2Vz
cy4NCj4NCj4gQmVzdCBSZWdhcmRzLA0KPiBLZXZpbg0KPg0KPiAgICAgICAgICAgICAgICAgIGlm
IChhZGV2LT5nbWMuZmx1c2hfdGxiX25lZWRzX2V4dHJhX3R5cGVfMikNCj4gLS0NCj4gMi4zNC4x
DQo+DQoNCg==
