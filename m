Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530E2C197A0
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 15:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E7710E60F;
	Thu, 16 Nov 2023 15:05:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6441C10E60F
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 15:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6fj8YgSN7xtw4wfWiB8VlPaD4OzfKsyrrb0yOPQa9N0rc9TwskD9hkLcESd6XYDzewtPb9S5EI9yitLRF450qnnPikoEwFM12OvHUdmegubU7HeUdHxd1GhL/Zh2RH3emDkGhUUnw1rmR+F0MJe1T8icpFIgoFzu04QTEAL0cP+qBkQsb3yqVFU8lF3BHOrjj5afaNDVwdBRexDyZOeveU4s3rYE2fInCCzGWg2W909xBvkpyq5yrxkx+vqpNYi8Q7VlVeEvNcRi5PJGEfNGGFOC6ZrrNN8Dyskb8F1oU1hX8ynxci6qg7tbG8WE2n98Fi5Qn9vMu6nGGcXOlC82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UC6CQqOyQke3NU2eoo8LF7l/KQPUCOe0xNtCYmYVZk=;
 b=BrSGePnAewAUVZtp5FaeD/5PN+ItQ5CHoEmNfX/p7YNRHVMvqdkt8J5ogTtaxXsZHkw2ar21H+QQGoEB400rrRCY8A7FlIYv0Xtx2azD52FwwenuCjJm92awBLFB6uCjdlXxyCo8iRHo/v4x8YDHTp03Bv911YyAp+EyYKqTIv83I4vxIB/2yb4QRjdU9sDycD0eIMIvlF0ZLda32S36xCsGDKdCpvh7jlsRQfX/SnIMSV8aIZbFS5i2ivCOY7sFlomc7H1maszYyfx/q9iomUIyx/wNqi7OtZJWP0mWKUpi2ynTR/S+g42zQLccvhohcFVx5g9KQ5v89LKZUKqfEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UC6CQqOyQke3NU2eoo8LF7l/KQPUCOe0xNtCYmYVZk=;
 b=IziuIJxlfqF7qmpzDvhN86b8ZfHhm80PZTPC8PSsutjp6UXf8xXL1EJDVQVWGrjnhEJ8aU1hxibW6SVf5kmBmoc641anNwjG9PpqEVgjRYNdYjzKGZbeezUolZ2c/llPBSuHVAjzMakfZEDI5zAYraTO4IrRLID45Aqh2lA3gw8=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 15:05:17 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 15:05:17 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0
Thread-Topic: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0
Thread-Index: AQHaE+TMEOy6LCNe6UqIOtkLiBXRErBzotaAgANdNwCABbhicIAAUWIAgAAGk5A=
Date: Thu, 16 Nov 2023 15:05:17 +0000
Message-ID: <CY5PR12MB63697858AB1F239752A7D324C1B0A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231110144701.1895397-1-alexander.deucher@amd.com>
 <59668638-00ce-4407-a0c1-47200480fe8f@amd.com>
 <CADnq5_O49zWhVhCopXFTC+9ijepy4iuV6vMbogP6+O8GWrZZOw@mail.gmail.com>
 <CY5PR12MB6369A027501FDC20699E31C7C1B0A@CY5PR12MB6369.namprd12.prod.outlook.com>
 <CADnq5_OpzAunvWdKqXp=kt3tVnVLH=i91feLEAq-T6KpRx_hgg@mail.gmail.com>
In-Reply-To: <CADnq5_OpzAunvWdKqXp=kt3tVnVLH=i91feLEAq-T6KpRx_hgg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d97b607f-5ed7-4b86-918b-59ec9e84e1aa;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-16T14:49:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SA1PR12MB6896:EE_
x-ms-office365-filtering-correlation-id: c8070722-dc9d-48f5-75ba-08dbe6b57192
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2MY9IGk47eEM5j72esPy2eMA9vUkQIz9WwjnFdWyKUB6vEkHZ6wEKUQDQoASh+/3uL6IQ89bOiE2pWXHsCFqPECGWrBQWtgAdy0O4HLnwrcmazo9VaZKCYoTzLQ4rCr5HCmHYps2zt5x8zQPYmApCk0DL0ah/EiJpyUQ/HJCaVn8POHKf0CqkCuAc1PZlCW9xQb2ee2xuqvQJ1X7EMeM0pIeTmIXb5M4riCgp6eqG0V6Qsd/7iL82bVpOYsk0wJo9CLRRJrQjw5fGK5HmvKBLiLIA5TMAxLu4rC74+qg87fb8vkPRzMbh3apJOPEHGz6yGkNUUzVQMybiWjYy8jI2e9M6BGFb8GWRhh+li9x+36lr1/SSocimkak5lVQyVUvrWhhpSWE7LdhPK6Nqw5beTZc70srzPvfZXKi7bnw0Kqb1OeJXtL3qSgpKo6Hn6oxUzMqCXiUHZSOvGdyiVWW7+xf6rwCkL0sj+9T60wAznrIF1bv7AJeeySCVCJRlR3vitgl9SGh65aNsUgbOQn5TpsJUUdSoU2TkV7EOpUcTPN1L5fIbMxhtgVPoNFG2ZeBEEPeCH0Do+ERlTrzk7WdFtbFSScK3Yb+v08fRrr45rnOYSQAz2wh/TapeiGK/qud
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(122000001)(478600001)(71200400001)(66574015)(26005)(38100700002)(52536014)(55016003)(66946007)(66556008)(66476007)(64756008)(66446008)(54906003)(316002)(4326008)(8676002)(6916009)(8936002)(41300700001)(2906002)(33656002)(5660300002)(86362001)(53546011)(76116006)(7696005)(6506007)(38070700009)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXQzS29TQWdBV2YvMWwvNUd5cHBEUXYrclB2WEcreHdjTlNURE5kN1RSQUJJ?=
 =?utf-8?B?VkZUZHFrNnlhWDFaOWkrSFJYUnB6bXF1VU5Sd2wvRU1wWjVhb2tuem5nZkUz?=
 =?utf-8?B?UURWMWhHcXpWb1JiUkpTVldHaXNzTmkzZnZpdVhzV3NpR1dtQ3ljZEZFWjh2?=
 =?utf-8?B?V0xjNUMrWVd2SGZBaXRsZExyNUJaNml1ajlCdFJxZjgwdGUrTmZPOUtQWEM2?=
 =?utf-8?B?SjIrU2oxR3YrZ3dpL2NTWG5IN2hrM05XTlJ3Vk5ZclJUZDNmdm9YdDk1aVZB?=
 =?utf-8?B?ajJEYmhuSEQ4K0IyaWVjY2FDdkUyaDFWQU1qZGI2cWdTWCtDaFU1VnlCU0Vv?=
 =?utf-8?B?ZXFWUHNiUnR5MFJPOGxZNEVGaTl5UWxGd0MvRncyZkJiWUxxckVwMEt2Rndz?=
 =?utf-8?B?ZVFYZVNGTVllU3p5NmgzL0ZmRGRzTlFBRUI5Qi9GOTNKK0s4dWZQQmM4UWZ3?=
 =?utf-8?B?SXJ4aXdwdjRmcDhycDJZMFdEUXBmWlh6WmpVby9LQTRTbjZ2eTRvUU9TTUZz?=
 =?utf-8?B?ZzVrWktxeXBaemNyWGE5SjF0VWFZR0RCRnJ4bHJhVGpoeklNRmxMMzFaMFI2?=
 =?utf-8?B?djYrMWtCaWJ3eWkrdVZ5bHZBNUNaWkFETWw4aG80UTllTUtUK0VUZG0wUWlx?=
 =?utf-8?B?MmxvcDE1ejdqTjZ4NlBYV3dUWTlXWks3RE9RM1IyYWJBMEdhTFdrZ0xJWWwy?=
 =?utf-8?B?M29OQmRCK2Qyc2ZSdDRKeGdNRldGQUVDUWlISW9HVlNsYzNCdTJyVFlnRkYv?=
 =?utf-8?B?NlA4c3VmbG1Mb2xBbENiOVI5bmwzT1g1WS9IRjRrNGFRaXpEaXVUd1ZESGg5?=
 =?utf-8?B?b0lxdmIwNk9MSldudkJSNkY1MXl5QVJaUUI1MXlhdnFJZUpZZDUxRGJDNmxY?=
 =?utf-8?B?UkNCZnJKeGF4b2tEZ3I2V2dYVTdtekVlMGxhVWtrQWhVblcybk41TWw4bVB0?=
 =?utf-8?B?Z3pJMTlKV2tRMXVjd1BHNmU2TWhHT09SeEN5Sm9nSTFXMHowQ0tEaWxYUHk3?=
 =?utf-8?B?bDFxWkZkSDNHOHNQRmpuWWpvalI1N0IvczdYVzBKWTdKWlJ3YUs1eWd1RlVa?=
 =?utf-8?B?U3ZiV3hRLzkzUGx3em1ZeWRyTlNHcnZ5NWkzNEJnRCttaTg4RHMrMHdJbFow?=
 =?utf-8?B?NFB4MnViQk9sRjdlWU1BeldsakpwbENLb1l5TVJKRlU2NDBLVkRQbmpsNlhn?=
 =?utf-8?B?b2paNjA5a1U2aUUzMlZ4QTJybEtjcFFMeWYwdCsxNDFaZ1VpTHVjaHhxcVlk?=
 =?utf-8?B?aWFJcS9MY2tJSjFPMnZaOTZlVjFUVkRlc0VwZ0ljN0h6c2N2TisxUVJxVXV3?=
 =?utf-8?B?MlRnMzY5UnhpQ2s4RTRhRWRMRFJXWTQ4QURlZU1wcXpHUmtVRmRmVUE3N3FS?=
 =?utf-8?B?bFh6b1hXeHk4SkY2eFMvK2tlbkdETG9iOFhHdC94aUJzbFh6UE5FUTY5clZZ?=
 =?utf-8?B?MXdZQzVyRVVWdmpxRzdvUDM4SmpBd3I4djFsRTRIWHFoOW9PWmMxZDdFOVV0?=
 =?utf-8?B?OVgrYjZtZmx5N29IWHZlVkdlUkVsRFdwbHpERG4yK0hlVHZPZWhwMGc0WVlG?=
 =?utf-8?B?c1F0OUlYcEJ0aFdMaGtKTWtxL3pCNmh0V0VqUGIxcm9ldDh3OEhNM0VjMERN?=
 =?utf-8?B?UWZjVlBrMi9WdndydUlZKzBDRklseExrTUVzZk9ESS9hYVg1NXRFYnJvUlEv?=
 =?utf-8?B?ZUR1L3Q4Z2t0Tkh1U1NzRlZrSm1EKytKSGI4djFjWnVOck94NUZOWC9oUUw3?=
 =?utf-8?B?UmlQWDM1VkdUdVJPd2wvSDM3UEluakRQOE9FL08xTTlmcllOWTd1ZGJnK0Q2?=
 =?utf-8?B?OWFsdTFGL1pGZ0xWOGQ3bmZiOW95SFVpaU9zbERDVlJ3Y3BZYmxkOHd3NFJm?=
 =?utf-8?B?di9WV1pDUWFURXcwcXhaYzlISm1oTi9jRVhnd0xyU1QyWmtVSVRGSTBBeGMx?=
 =?utf-8?B?UnlCaE5wSVo2Q1NDUWlIRUtFVklvdUpkYVM1em5pQUVSSUE0Yk9ERjRKZDFx?=
 =?utf-8?B?SFlwRFJTWUdFL2pXcmMyR2o0Y3NBN3BnVmU5YUZxZGw3RENXNVdSRHgyUHBp?=
 =?utf-8?B?aUd3Q3RqdkZBd3RobFlRc3BvbnRhRFdrK2pXWFhaNFBVNlh5cEMvb0cwdEpn?=
 =?utf-8?Q?fS9k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8070722-dc9d-48f5-75ba-08dbe6b57192
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 15:05:17.1733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9TWZrQ6nQZUg9lQUQTpBv79jxwyA+JySDsOHoIKXAwjNm3GhTIRPMi2xj51gG8i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClllcywgaXQgZml4ZXMgcmVncmVz
c2lvbnMgaW4gS0ZEVGVzdCBpbnRyb2R1Y2VkIGJ5IHRoaXMgY29tbWl0ICgiYjkzZWQ1MWMzMmNh
IGRybS9hbWRncHU6IGZpeCBBR1AgaW5pdCBvcmRlciIpLA0KDQplLmcuICBLRkRNZW1vcnlUZXN0
Lk1lbW9yeVJlZ2lzdGVyIGZhaWx1cmU6DQoNCmZhdWx0IGFkZHIgMHgwMDAwODA4NDU3NWE2MDAw
IGlzIGNhbGN1bGF0ZWQgYnkgKGdhcnRfc3RhcnQgKyBBR1AgYXBlcnR1cmUgbWMgYWRkcikgd3Jv
bmdseS4NCg0KWyAgIDQ2LjY2Mjg1Nl0gYW1kZ3B1IDAwMDA6YzI6MDAuMDogYW1kZ3B1OiBbZ2Z4
aHViXSBwYWdlIGZhdWx0IChzcmNfaWQ6MCByaW5nOjE2OSB2bWlkOjAgcGFzaWQ6MCwgZm9yIHBy
b2Nlc3MgIHBpZCAwIHRocmVhZCAgcGlkIDApDQpbICAgNDYuNjYyODkwXSBhbWRncHUgMDAwMDpj
MjowMC4wOiBhbWRncHU6ICAgaW4gcGFnZSBzdGFydGluZyBhdCBhZGRyZXNzIDB4MDAwMDgwODQ1
NzVhNjAwMCBmcm9tIGNsaWVudCAxMA0KWyAgIDQ2LjY2MjkwOV0gYW1kZ3B1IDAwMDA6YzI6MDAu
MDogYW1kZ3B1OiBHQ1ZNX0wyX1BST1RFQ1RJT05fRkFVTFRfU1RBVFVTOjB4MDAwNDBCNTINClsg
ICA0Ni42NjI5MjNdIGFtZGdwdSAwMDAwOmMyOjAwLjA6IGFtZGdwdTogICAgICBGYXVsdHkgVVRD
TDIgY2xpZW50IElEOiBDUEMgKDB4NSkNClsgICA0Ni42NjI5MzZdIGFtZGdwdSAwMDAwOmMyOjAw
LjA6IGFtZGdwdTogICAgICBNT1JFX0ZBVUxUUzogMHgwDQpbICAgNDYuNjYyOTQ3XSBhbWRncHUg
MDAwMDpjMjowMC4wOiBhbWRncHU6ICAgICAgV0FMS0VSX0VSUk9SOiAweDENClsgICA0Ni42NjI5
NTddIGFtZGdwdSAwMDAwOmMyOjAwLjA6IGFtZGdwdTogICAgICBQRVJNSVNTSU9OX0ZBVUxUUzog
MHg1DQpbICAgNDYuNjYyOTY4XSBhbWRncHUgMDAwMDpjMjowMC4wOiBhbWRncHU6ICAgICAgTUFQ
UElOR19FUlJPUjogMHgxDQpbICAgNDYuNjYyOTc5XSBhbWRncHUgMDAwMDpjMjowMC4wOiBhbWRn
cHU6ICAgICAgUlc6IDB4MQ0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBB
bGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NClNlbnQ6IFRodXJzZGF5LCBOb3Zl
bWJlciAxNiwgMjAyMyAxMDoyNiBQTQ0KVG86IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFt
ZC5jb20+DQpDYzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47
IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1k
LmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCBBR1AgYWRkcmVzc2lu
ZyB3aGVuIEdBUlQgaXMgbm90IGF0IDANCg0KT24gVGh1LCBOb3YgMTYsIDIwMjMgYXQgNDozN+KA
r0FNIFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBbQU1E
IE9mZmljaWFsIFVzZSBPbmx5IC0gR2VuZXJhbF0NCj4NCj4gUGluZy4uLiB0aGlzIHBhdGNoIHNl
ZW1zIHN0aWxsIG5vdCBtZXJnZWQuDQo+DQoNCkNhbiB5b3UgY29uZmlybSBpdCBmaXhlcyB0aGUg
QUdQIGlzc3VlcyB5b3Ugc2F3Pw0KDQpBbGV4DQoNCj4gQmVzdCBSZWdhcmRzLA0KPiBZaWZhbg0K
Pg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFs
ZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxMywgMjAyMyAy
OjEzIEFNDQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29t
Pg0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsN
Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpo
YW5nQGFtZC5jb20+Ow0KPiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IEFHUCBhZGRyZXNzaW5nIHdo
ZW4gR0FSVCBpcyBub3QNCj4gYXQgMA0KPg0KPiBPbiBTYXQsIE5vdiAxMSwgMjAyMyBhdCAyOjE3
4oCvQU0gQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IEFtIDEwLjExLjIzIHVtIDE1OjQ3IHNjaHJpZWIgQWxleCBEZXVjaGVyOg0KPiA+
ID4gVGhpcyB3b3JrZWQgYnkgbHVjayBpZiB0aGUgR0FSVCBhcGVydHVyZSBlbmRlZCB1cCBhdCAw
LiAgV2hlbiB3ZQ0KPiA+ID4gZW5kZWQgdXAgbW92aW5nIEdBUlQgb24gc29tZSBjaGlwcywgdGhl
IEdBUlQgYXBlcnR1cmUgZW5kZWQgdXANCj4gPiA+IG9mZnNldHRpbmcgdGhlIHRoZSBBR1AgYWRk
cmVzcyBzaW5jZSB0aGUgcmVzb3VyY2UtPnN0YXJ0IGlzIGEgR0FSVA0KPiA+ID4gb2Zmc2V0LCBu
b3QgYW4gTUMgYWRkcmVzcy4gIEZpeCB0aGlzIGJ5IG1vdmluZyB0aGUgQUdQIGFkZHJlc3MNCj4g
PiA+IHNldHVwIGludG8gYW1kZ3B1X2JvX2dwdV9vZmZzZXRfbm9fY2hlY2soKS4NCj4gPiA+DQo+
ID4gPiBSZXBvcnRlZC1ieTogSmVzc2UgWmhhbmcgPEplc3NlLlpoYW5nQGFtZC5jb20+DQo+ID4g
PiBSZXBvcnRlZC1ieTogWWlmYW4gWmhhbmcgPHlpZmFuMS56aGFuZ0BhbWQuY29tPg0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0K
PiA+ID4gQ2M6IGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbQ0KPiA+ID4gLS0tDQo+ID4gPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8IDEwICsrKysrKystLS0N
Cj4gPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jICAgIHwgIDQg
Ky0tLQ0KPiA+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X29iamVjdC5jDQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9vYmplY3QuYw0KPiA+ID4gaW5kZXggY2VmOTIwYTkzOTI0Li4xYjNlOTc1MjI4MzggMTAw
NjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0
LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3Qu
Yw0KPiA+ID4gQEAgLTE1MjcsMTAgKzE1MjcsMTQgQEAgdTY0IGFtZGdwdV9ib19ncHVfb2Zmc2V0
KHN0cnVjdCBhbWRncHVfYm8gKmJvKQ0KPiA+ID4gICB1NjQgYW1kZ3B1X2JvX2dwdV9vZmZzZXRf
bm9fY2hlY2soc3RydWN0IGFtZGdwdV9ibyAqYm8pDQo+ID4gPiAgIHsNCj4gPiA+ICAgICAgIHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KGJvLT50Ym8uYmRldik7
DQo+ID4gPiAtICAgICB1aW50NjRfdCBvZmZzZXQ7DQo+ID4gPiArICAgICB1aW50NjRfdCBvZmZz
ZXQsIGFkZHI7DQo+ID4gPg0KPiA+ID4gLSAgICAgb2Zmc2V0ID0gKGJvLT50Ym8ucmVzb3VyY2Ut
PnN0YXJ0IDw8IFBBR0VfU0hJRlQpICsNCj4gPiA+IC0gICAgICAgICAgICAgIGFtZGdwdV90dG1f
ZG9tYWluX3N0YXJ0KGFkZXYsIGJvLT50Ym8ucmVzb3VyY2UtPm1lbV90eXBlKTsNCj4gPiA+ICsg
ICAgIGFkZHIgPSBhbWRncHVfZ21jX2FncF9hZGRyKCZiby0+dGJvKTsNCj4gPg0KPiA+IElJUkMg
eW91IG11c3QgY2hlY2sgYm8tPnRiby5yZXNvdXJjZS0+bWVtX3R5cGUgYmVmb3JlIGNhbGxpbmcN
Cj4gPiBhbWRncHVfZ21jX2FncF9hZGRyKCkuDQo+DQo+IFllcywgdGhpcyB3YXMgZml4ZWQgaW4g
djIuDQo+DQo+IEFsZXgNCj4NCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gQ2hyaXN0aWFuLg0KPiA+
DQo+ID4gPiArICAgICBpZiAoYWRkciAhPSBBTURHUFVfQk9fSU5WQUxJRF9PRkZTRVQpDQo+ID4g
PiArICAgICAgICAgICAgIG9mZnNldCA9IGFkZHI7DQo+ID4gPiArICAgICBlbHNlDQo+ID4gPiAr
ICAgICAgICAgICAgIG9mZnNldCA9IChiby0+dGJvLnJlc291cmNlLT5zdGFydCA8PCBQQUdFX1NI
SUZUKSArDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X3R0bV9kb21haW5fc3Rh
cnQoYWRldiwNCj4gPiA+ICsgYm8tPnRiby5yZXNvdXJjZS0+bWVtX3R5cGUpOw0KPiA+ID4NCj4g
PiA+ICAgICAgIHJldHVybiBhbWRncHVfZ21jX3NpZ25fZXh0ZW5kKG9mZnNldCk7DQo+ID4gPiAg
IH0NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dHRtLmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jDQo+
ID4gPiBpbmRleCAwNTk5MWM1YzhkZGIuLmFiNGE3NjJhZWQ1YiAxMDA2NDQNCj4gPiA+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYw0KPiA+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jDQo+ID4gPiBAQCAtOTU5LDEwICs5
NTksOCBAQCBpbnQgYW1kZ3B1X3R0bV9hbGxvY19nYXJ0KHN0cnVjdCB0dG1fYnVmZmVyX29iamVj
dCAqYm8pDQo+ID4gPiAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ID4NCj4gPiA+ICAgICAg
IGFkZHIgPSBhbWRncHVfZ21jX2FncF9hZGRyKGJvKTsNCj4gPiA+IC0gICAgIGlmIChhZGRyICE9
IEFNREdQVV9CT19JTlZBTElEX09GRlNFVCkgew0KPiA+ID4gLSAgICAgICAgICAgICBiby0+cmVz
b3VyY2UtPnN0YXJ0ID0gYWRkciA+PiBQQUdFX1NISUZUOw0KPiA+ID4gKyAgICAgaWYgKGFkZHIg
IT0gQU1ER1BVX0JPX0lOVkFMSURfT0ZGU0VUKQ0KPiA+ID4gICAgICAgICAgICAgICByZXR1cm4g
MDsNCj4gPiA+IC0gICAgIH0NCj4gPiA+DQo+ID4gPiAgICAgICAvKiBhbGxvY2F0ZSBHQVJUIHNw
YWNlICovDQo+ID4gPiAgICAgICBwbGFjZW1lbnQubnVtX3BsYWNlbWVudCA9IDE7DQo+ID4NCg==
