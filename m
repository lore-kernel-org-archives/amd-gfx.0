Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EDEECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 06:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99EDE10EAA1;
	Thu, 15 Sep 2022 06:38:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD3C10EAA1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 06:38:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbjSLecxG6XToV7ROfPcWGYCDnn41ErSsBMqN+5sGGSyt1wnaSoercZ48zF85nrcTg0FBHDkcApTNskOgU5LXfYzmkFyL3G91+Y1cSE1qfQAQoaCeAwpoNVKVEcHc34Kh2gEU2C9XZS9ECYKVcz3w1sDDBI7R6SCJx9ODtlNflMiBtz4wg+AbA+H1MlcJ55vNfjSe4PFgD3rY0Ycz8g2B6Wb5PrUDC6DmAzDVBmjwcdujzAOEkjqXhApg39hSukf3qbQifAbpbHIWLUuHjKMnYx8qm7OZT982DIsA3vEikdNCsa2HeyG/XvNQj5SbqJc+OumnBt1cfI4F71Z7SEQgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GyhObplxVnjHVpayD060VfV3apIw9F+xI2Q8J0z6tw=;
 b=cVk47JMId+t1ioWTEuzcJbllU9ZZiRRHFbyEDJCuqQyW/C6kcm17aLeg8Q3/QsvywWZN+PGDqPHQUU28yivxVzKYYJy7LH93/hYxqkcLszCuk/MAQZt4yMBUcqpt788XCV0khvl6lW9p0uT/mFS4FvtlmkLOlE+K5bB1u0zjvqxX/sq/f81zv2uOS8UXiSywYfqRDT6MqXQ0+n/ruFSshB/CDfzACbNx/KJ7BG7KNlyxAA+3OYvtR1HruoiFhNaVP227wtdZHas9fJQBjYuSKjbMSs3A2zF6RxEUoBGTzcAemyI70s2bzGDBxmtz/JgiFTJ/hIArLckgeE1/u2v+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GyhObplxVnjHVpayD060VfV3apIw9F+xI2Q8J0z6tw=;
 b=sODg1pYAJxNmpVRiZwJsRKqO1IY/jvxewdM6V47m/1A7qoPcGkXLKHdUpJmvewyE0D2QaWNYUZA2HyVGQQYkRvBkBiw/KRZKqMU2a8A6bIvmbtn9oiKaUaMeuFFUZamOipJsFXXnnnKFoy+nu5Kc/kUlDvQqcZRBNX4uVjl2OCc=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 PH7PR12MB6857.namprd12.prod.outlook.com (2603:10b6:510:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 06:38:12 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::7118:ff85:f7ee:b1ce]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::7118:ff85:f7ee:b1ce%4]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 06:38:12 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: move enable irq later to avoid race with
 ih resume
Thread-Topic: [PATCH 2/2] drm/amdgpu: move enable irq later to avoid race with
 ih resume
Thread-Index: AQHYyCJa31wYmCMhXU6bqIazn5JAw63f/9cAgAAKBsA=
Date: Thu, 15 Sep 2022 06:38:12 +0000
Message-ID: <DM6PR12MB4340C1B8A689A0AA8B5DB27DFA499@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20220914101025.366954-1-Victor.Zhao@amd.com>
 <20220914101025.366954-2-Victor.Zhao@amd.com>
 <6d96d72b-cde6-ad13-ec3a-ef26cd0f068f@amd.com>
In-Reply-To: <6d96d72b-cde6-ad13-ec3a-ef26cd0f068f@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-15T06:38:07Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=25f1657c-c2b3-425a-942d-78f07dabfc32;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-15T06:38:07Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 62a33c7a-f13c-4495-a26c-b87960fff66a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4340:EE_|PH7PR12MB6857:EE_
x-ms-office365-filtering-correlation-id: a5f3ba10-6a8b-4460-648e-08da96e4dcc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ME5CAeSIMUGJX0yFI6aILDes/iEO3vBe35Fa71BPcG2uZUwphe9DBKQiPkf3YShelW8s62l/ngK7xafzQyvLignfofSOiGOQ6Ttq0mGesbGPWLNMFKKcLzhwtOlf3IOFlqmcRmGOfN4twV5SaTNbi9IJ+Qjs1i7uPzZ3b6MCM6W+fIjLmLiGy0z0EuyY50XIinxt+GS9riyJAyfygCaSzGtNRMUx+d68dcGyigD+ByZtaO5TgDe6Q5CIo82N20/Vm3x1YFyywcPBm+ubqXe2wqK7gIlMCzjUgtuLjSPd9w7pjp4ec0w80gRwTPVH7kOLV2lc3IdwJMom3nBGCVw6l+6MVIMxMtoYTeS2chc90uyFmuGacG+tpfvc0xsCzXO/z+JTAioqpS+R+UqM5QFqXU/6DIGyQDQ9Rfdyxd8pbewyzKew2niK5AmHFoE5s53de0NXTmSKIb7PRjcgPwZrBXOv/0urkf+TsS3eAJgPN4GHtXBFDutu2dVINCOtghblGOIBubmW/4lhhxpQK+QPFsreWxo+F1g8nKWXmHgwaClOWSayx8/igElYh+EIH8Nx12/JFw714Bed/FFZPpT3wCqwQg9I8M0MAEs4Twm8oYwlvphU0ir7GqnQXwZqzqpmXjmuOpUMJcPnmXcYA9hvWzVu+Pi2ldbWDEpZOhp33gDp+ZB6A6shPDDkWuytMbAUOKvW5CVZ9/L/EajKv1ymMJ+e3vdMCEo02g1XgEUjHkLKipC52LPd2KuQ12uGKMWvSn/hpkDpKf88o6c6Lq2jsw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199015)(41300700001)(8676002)(6506007)(55016003)(4326008)(7696005)(66476007)(86362001)(66946007)(66556008)(38100700002)(38070700005)(316002)(83380400001)(186003)(9686003)(33656002)(53546011)(52536014)(2906002)(8936002)(54906003)(478600001)(64756008)(26005)(71200400001)(110136005)(66446008)(5660300002)(76116006)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODVaeE1xSnFnTEVCSnRCRUpyVHpZamM0eTllbU1IdkdWdGJXNEpZVmNLN3VX?=
 =?utf-8?B?V0lGdWh5SWhodWpQL2tLUVRJTVdWVHI4cnVMWlFNVzhmQmVwN3NEUHRINnpR?=
 =?utf-8?B?Y0RnT2VCbUIzMWpOTTB2YkN5QU5pdWdtQ2VUNnhKdzc5aEwwK3c3UHBxUWJz?=
 =?utf-8?B?NEwrRFlSK05aZDE1a3hlaXcyeDk4elhwQnBNcVZ1UzhmYWwvWmRZTGZuT3Zy?=
 =?utf-8?B?VXlwTm1KMVJvNHJCV292M0w4eVMrWVRyeG04cFJuRGNmVDhGOElXUGFxUHRX?=
 =?utf-8?B?RE1ZYlV5K3lKeTljU3RQMjd4eE0yL0w1cjNWSExPLzdBVkN6S2tDd3hDMHly?=
 =?utf-8?B?QXZsaGhuR2twK0x2cHpKTzNJeDlja2JsczFBbTdCOGN3bXpweEhIcUlWWFhv?=
 =?utf-8?B?Y1VUWE85bWpYdmZ1UGJwUTdJWjlRU3hkSkh0WHJHcjd6NGJFMEpQVnl6MHBy?=
 =?utf-8?B?Sm9UZVRSY21USEV2M0hCRFlmeHlDSUt3MWN3SHVyS25GNGFUNGh3TEpHbGNn?=
 =?utf-8?B?Qm1ndXkxaEhrV2NScVloMTZ5QnFTWTV1NDE0VFdOcXNKd09qMXdQY3R3dlNN?=
 =?utf-8?B?RHNtRGRoTGJCVGpBZFNNQ0doR3ArZ3UzUWhYYThOQnUzZzVObFpxc1dPdm9W?=
 =?utf-8?B?RWxnUzRibjJGNFM1bDM0cUFlVlBRc1RBSjVrbHRWOGNDSVd2cDNkR2pmMzU3?=
 =?utf-8?B?RnphaGg3RHZUNXFWcXlZYkNPWHNNVld0VU1pQ3hKeElVMG5ROHJEb2FZZDZZ?=
 =?utf-8?B?czN5QjZmdHJVczFDVDBnaDN5L09BaTR6KzZvczQzMDFvM2lCbTRTSHQyYzFI?=
 =?utf-8?B?enBWWFlMNkplOG1kY09adVRJcU5NSmRNVlFiS1Z0MHVKaWpLNGl5SC9QZUJG?=
 =?utf-8?B?TVBNU1YvR1MwN1JzY2s5S1VLZE1OSkVhQ0lSZlIvMkU4ZTJpeGpjd2VuUmtj?=
 =?utf-8?B?SjN4dUdXWjUyVy9kNlJWZHdiMXZyNzVMOG55ODJQLzhaQUoyc3p0cUQvWmdU?=
 =?utf-8?B?bVQ5R3dkWWsrN2Z0dmJMQVVxb2ZoWlpNYndadmhIVnNYVm9TNUJhSjBwSGJU?=
 =?utf-8?B?ZXpNNlBTSVZDTVRaOVBYOEtzamtPY0lmS1NyVDlmSWlTQlFnbjdEOGg5Nmd6?=
 =?utf-8?B?ZTVmRk8venFwczlGUW5hdTRiNmMrb0p6RzRZZmFLamFVRTVLMlRjZWloc0xw?=
 =?utf-8?B?RjF5MjFMQkJWa1BWTnNrelVPYjZoMkg2SDFTY00wTUFSVHYzc2J2MG1ZcDlr?=
 =?utf-8?B?UEEzaHNnWnRCMCtBbkkwZVJhakU4S055U0tWL05iK0FXUm1WeUNySWJtdXZj?=
 =?utf-8?B?SVBta1A5Q201ZHBKaVJLNGRMK2UwaXgyWWFic0kwOE0ySW5QU0RacEpxYjZ1?=
 =?utf-8?B?bW1jdDJld29KclRINk5lZjh2UHhZK1ZBcnpXK2Jwdy9HQ0grcjl5QVBoeHI2?=
 =?utf-8?B?R0hTcEpRZTZibTFoS2dWZVVrSDJ0SS90VXJZa092aThPakZlbnZrMEZhait3?=
 =?utf-8?B?WkFKbmxyS09yZWZ2Q0o2aXcxbSszdEkzWWtQbkJoYVlRWEMyckQ5Ky9qb0Iz?=
 =?utf-8?B?MU1STEIrZ2RPb1owbTcxbTR1OS9oM21xS3Z2T01NUDl5MG02RWN6SjJEcXl1?=
 =?utf-8?B?aWd3dWF2L3lWZlhjck5ZVk9BbXF5ak01bVNBM0V2QlhxVytmeXZoSE1Td1Ro?=
 =?utf-8?B?NXhLZldkcXpkc2tkVS9sTXJaZG9MRWtIOUFWMnRMQSt5R2pMYVdVMWJOMzdZ?=
 =?utf-8?B?L01XMWVWSGxsdkRWSy9vNHU3eEZUT1ZydnF5L3JhMWNYaSsrQncrVzZ4SWxN?=
 =?utf-8?B?MVVzS3B5R25lWitmMEY2ek9LUE1JZEx0RFpBZDl0SkNucjNtRWZBYmlwM0c1?=
 =?utf-8?B?OTRFVlhReVY4R2EwN3I0UXlSM1ViZkdrcC9LcEFJejAyQTkzVkxPTEFtSU91?=
 =?utf-8?B?cS9uQWY5SVVXQXJtT2RiWmNZckxTSHV4WmJ3VXJyN1N4RnNKMS9tM2E1ejdP?=
 =?utf-8?B?RkFSU3kydXhrSk5Pamk0d0s5TTZuYUdDNC9WUTVWbG1SZnhlQ0pDTnRBeVhi?=
 =?utf-8?B?SElmUXh4NXQ0OWIwaS9Zb0NJbmI1TVJLVWttMit4RC9kNmdRbzJFNEczZlp0?=
 =?utf-8?Q?0+tQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f3ba10-6a8b-4460-648e-08da96e4dcc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 06:38:12.6692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bgfj2ebMu4Yz8w01E89BsssJ8VwADTEwjep7toI6FvuzC5j0QjukDTBvYDSBGJ4s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6857
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIExpam8sDQoNCklIIHJlc3Vt
ZSB3YXMgYWRkZWQgdG8gcmVzb2x2ZSBhbiBpc3N1ZSBmb3VuZCBkdXJpbmcgbW9kZTIgYnJpbmcg
dXAgb24gc2llbm5hIGNpY2hsaWQ6DQotIGNsb3NlIGRvd24gbW9kZTIgcmVzZXQgYW5kIGRvIGEg
bW9kZTEgcmVzZXQgZmlyc3QNCi0gb3BlbiBtb2RlMiByZXNldCBhbmQgZG8gYSBtb2RlMiByZXNl
dC4gTW9kZTIgcmVzZXQgd2FzIGZvdW5kIGZhaWwgaW4gdGhpcyBjYXNlLg0KDQpSZXN1bWUgSUgg
aGVscHMgaW4gdGhpcyBjYXNlDQoNCg0KVGhhbmtzLA0KVmljdG9yDQoNCg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4g
DQpTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDE1LCAyMDIyIDE6NTggUE0NClRvOiBaaGFvLCBW
aWN0b3IgPFZpY3Rvci5aaGFvQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KQ2M6IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBHcm9kem92c2t5LCBBbmRy
ZXkgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0g
ZHJtL2FtZGdwdTogbW92ZSBlbmFibGUgaXJxIGxhdGVyIHRvIGF2b2lkIHJhY2Ugd2l0aCBpaCBy
ZXN1bWUNCg0KDQoNCk9uIDkvMTQvMjAyMiAzOjQwIFBNLCBWaWN0b3IgWmhhbyB3cm90ZToNCj4g
W2JhY2tncm91bmRdDQo+IE9uIGN1cnJlbnQgc2llbm5hIGNpY2hsaWQgbW9kZTIgcmVzZXQsIG9u
IHRoZSBzbG93IGpvYiBoYW5nIGNhc2VzLCANCj4gc2luY2UgcGFnZSB0YWJsZSBjb250ZXh0IHdh
cyByZXZlcnRlZCB0byBjb21wbGV0ZWx5IHN0b3AgZ3B1LCBpdCB3aWxsIA0KPiBnZW5lcmF0ZSBw
YWdlIGZhdWx0IGludGVycnVwdC4NCj4gDQo+IFNpbmNlIHRoZSBpcnEgYXJlIG9wZW4gZHVyaW5n
IHJlY292ZXJ5IHN0YWdlLCBkdXJpbmcgaWggcmVzdW1lIHN0ZXAsIA0KPiBpZiB0aGlzIGludGVy
cnVwdCB3YXMgaW4gcHJvY2Vzc2luZywgd2hpY2ggaW5jcmVhc2VkIGloIHJpbmcgcnB0ciwgYW5k
IA0KPiBpaCByZXN1bWUgbWVhbndoaWxlIHdpbGwgc2V0IHJwdHIgYW5kIHdwdHIgdG8gMC4gVGhp
cyBtYXkgY2F1c2UNCg0KQUZBSUssIG9ubHkgR0ZYL1NETUEgYXJlIGFmZmVjdGVkIGJ5IG1vZGUt
Mi4gSUggaXMgbm90IHN1c3BlbmRlZCBiZWZvcmUgbW9kZS0yLiBXaHkgZG8geW91IHJlc3VtZSBJ
SCBhZnRlciBtb2RlLTIgd2hlbiBpdCBpcyBub3Qgc3VzcGVuZGVkPyBJcyBpdCBhIHNwZWNpYWwg
Y2FzZSBmb3IgdmlydHVhbGl6YXRpb24/DQoNClRoYW5rcywNCkxpam8NCg0KPiBycHRyIGdyZWF0
ZXIgdGhhbiB3cHRyLiBTdWNoIGNhc2Ugd2FzIG5vdCBoYW5kbGVkIGluIGloIHByb2Nlc3MsIGFu
ZCANCj4gaXQgd2lsbCBjYXVzZSBycHRyIGNvbnRpbnVlIGluY3JlYXNpbmcgdXRpbCByZWFjaGVz
IHRoZSBtYXguDQo+IFN1Y2ggY2FzZSB3aWxsIG1ha2UgZmVuY2UgZmFsbGJhY2sgc2l0dWF0aW9u
IGhhcHBlbi4NCj4gDQo+IFtob3ddDQo+IE1vdmUgdGhlIGVuYWJsZSBvZiBpcnEgYWZ0ZXIgaWgg
cmVzdW1lZCBhbmQgYmVmb3JlIGliIHRlc3QuDQo+IEFkanVzdGluZyB0aGUgcG9zaXRpb24gb2Yg
ZW5hYmxlIGlycSBvbiBvdGhlciByZXNldCBwYXRocyBhY2NvcmRpbmdseS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFZpY3RvciBaaGFvIDxWaWN0b3IuWmhhb0BhbWQuY29tPg0KPiAtLS0NCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgIHwgOCArKysrLS0tLQ0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpZW5uYV9jaWNobGlkLmMgfCAxICsNCj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMg
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IGluZGV4
IGMwY2ZhZTUyZjEyYi4uMGI2NTgyMjVlOWVmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IEBAIC00NjI1LDggKzQ2MjUsNiBAQCBpbnQgYW1k
Z3B1X2RldmljZV9wcmVfYXNpY19yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4g
ICAJCWFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbihyaW5nKTsNCj4gICAJfQ0K
PiAgIA0KPiAtCWFtZGdwdV9mZW5jZV9kcml2ZXJfaXNyX3RvZ2dsZShhZGV2LCBmYWxzZSk7DQo+
IC0NCj4gICAJaWYgKGpvYiAmJiBqb2ItPnZtKQ0KPiAgIAkJZHJtX3NjaGVkX2luY3JlYXNlX2th
cm1hKCZqb2ItPmJhc2UpOw0KPiAgIA0KPiBAQCAtNDc1OCw2ICs0NzU2LDEwIEBAIGludCBhbWRn
cHVfZG9fYXNpY19yZXNldChzdHJ1Y3QgbGlzdF9oZWFkICpkZXZpY2VfbGlzdF9oYW5kbGUsDQo+
ICAgCQl0ZXN0X2JpdChBTURHUFVfTkVFRF9GVUxMX1JFU0VULCAmcmVzZXRfY29udGV4dC0+Zmxh
Z3MpOw0KPiAgIAlza2lwX2h3X3Jlc2V0ID0gdGVzdF9iaXQoQU1ER1BVX1NLSVBfSFdfUkVTRVQs
IA0KPiAmcmVzZXRfY29udGV4dC0+ZmxhZ3MpOw0KPiAgIA0KPiArCWxpc3RfZm9yX2VhY2hfZW50
cnkgKHRtcF9hZGV2LCBkZXZpY2VfbGlzdF9oYW5kbGUsIHJlc2V0X2xpc3QpIHsNCj4gKwkJYW1k
Z3B1X2ZlbmNlX2RyaXZlcl9pc3JfdG9nZ2xlKHRtcF9hZGV2LCBmYWxzZSk7DQo+ICsJfQ0KPiAr
DQo+ICAgCS8qDQo+ICAgCSAqIEFTSUMgcmVzZXQgaGFzIHRvIGJlIGRvbmUgb24gYWxsIFhHTUkg
aGl2ZSBub2RlcyBBU0FQDQo+ICAgCSAqIHRvIGFsbG93IHByb3BlciBsaW5rcyBuZWdvdGlhdGlv
biBpbiBGVyAod2l0aGluIDEgc2VjKSBAQCANCj4gLTUwMzEsOCArNTAzMyw2IEBAIHN0YXRpYyB2
b2lkIGFtZGdwdV9kZXZpY2VfcmVjaGVja19ndWlsdHlfam9icygNCj4gICAJCQkvKiBDbGVhciB0
aGlzIGZhaWxlZCBqb2IgZnJvbSBmZW5jZSBhcnJheSAqLw0KPiAgIAkJCWFtZGdwdV9mZW5jZV9k
cml2ZXJfY2xlYXJfam9iX2ZlbmNlcyhyaW5nKTsNCj4gICANCj4gLQkJCWFtZGdwdV9mZW5jZV9k
cml2ZXJfaXNyX3RvZ2dsZShhZGV2LCBmYWxzZSk7DQo+IC0NCj4gICAJCQkvKiBTaW5jZSB0aGUg
am9iIHdvbid0IHNpZ25hbCBhbmQgd2UgZ28gZm9yDQo+ICAgCQkJICogYW5vdGhlciByZXN1Ym1p
dCBkcm9wIHRoaXMgcGFyZW50IHBvaW50ZXINCj4gICAJCQkgKi8NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpZW5uYV9jaWNobGlkLmMgDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc2llbm5hX2NpY2hsaWQuYw0KPiBpbmRleCA3YWE1NzBjMWNlNGEu
Ljk1MzAzNjQ4MmQxZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
c2llbm5hX2NpY2hsaWQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaWVu
bmFfY2ljaGxpZC5jDQo+IEBAIC0yNDAsNiArMjQwLDcgQEAgc2llbm5hX2NpY2hsaWRfbW9kZTJf
cmVzdG9yZV9od2NvbnRleHQoc3RydWN0IGFtZGdwdV9yZXNldF9jb250cm9sICpyZXNldF9jdGws
DQo+ICAgCSogQWRkIHRoaXMgQVNJQyBhcyB0cmFja2VkIGFzIHJlc2V0IHdhcyBhbHJlYWR5DQo+
ICAgCSogY29tcGxldGUgc3VjY2Vzc2Z1bGx5Lg0KPiAgIAkqLw0KPiArCWFtZGdwdV9mZW5jZV9k
cml2ZXJfaXNyX3RvZ2dsZSh0bXBfYWRldiwgZmFsc2UpOw0KPiAgIAlhbWRncHVfcmVnaXN0ZXJf
Z3B1X2luc3RhbmNlKHRtcF9hZGV2KTsNCj4gICANCj4gICAJLyogUmVzdW1lIFJBUyAqLw0KPiAN
Cg==
