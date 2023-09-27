Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32228E7F14E
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 13:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 392EE10E518;
	Wed, 27 Sep 2023 13:23:02 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA67010E519
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 13:23:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9lgcpsUSx+Al7ZHb7CLUAlxC1BGIxMrzli6lIwGYlWknVb92uQPutdJIqK6XQ1y1nGUyHBQkATJAW2AmgBlTW3CsSDGHNjlXfDMZJ/SknfXp4uUwpPUccSX1w2Z4qVJkdUnhVAGAlZflKd9/u72DPgIU62kY227JgSy18iFm6Of6fgJiMw85bZ38Q12CJsxQ2oUzDtCKjj9dg03EGJDLhgJmYZDi4cY7SeU5GOnAN7GQbWrYyQojEAvW2a0g9gp2ssWFHN7VonPxPyfwzq+ObsTWdacqqUT4r2eosrsGWs+fted5wUKMca6yFp+EAaR2ZnGFzVJlcxjz4RziWWsAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPz46V4uPrZ2mnvA7PMtCdWm9zN+hVUPsW+PpdsJZak=;
 b=P0npsYsZn3ZinXkmdS5cXARxYx//Glebt+ajMDo2JCiaMAkBR39I1IQg+Gm1arH4NFkGOg0GuK34QhFDV7u06f/DOMjFkWYk6BTITdUObY8hymaoCV+K76bOnny4I3yXzzi25T6ISCkv3dB9BJYncgUo9CuRpXzS2RrNpKmbmYAV3gSKnOjEHcqyM1AW4ck+iqYgS0V0YCSxHZSVtQ9PAvUa+3KLhYIQRuXNRU5nECrzNg0Wjz5Jar5CCdobSSfY4a5rm1wCDxVi3Fn08a0u0QDkxERKia7UTUs9KT5KVilfnmuruSZy1pi/0NmzTJ5b5UT4QWbsT4bbINtrmtBzYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPz46V4uPrZ2mnvA7PMtCdWm9zN+hVUPsW+PpdsJZak=;
 b=F61ETkU+JrVzUt5qhl3W7NPPGacX6wUp9EtF5BuZv8c85F6jnJ/dt3ERmr48tEtMofjFor8xdz43ZapIEdNtpt0A7T/N/npRDINcTg87OvP2j+ixHaed9NAhQgSs/Tw35eQev5UKdeVaxr9jj6aQdJo5QklWcYc4o32nv9WcYoI=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Wed, 27 Sep
 2023 13:22:56 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd%5]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 13:22:56 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amd/display: enable S/G display for for recent APUs
 by default
Thread-Topic: [PATCH] drm/amd/display: enable S/G display for for recent APUs
 by default
Thread-Index: AQHZ8QVvAPMWI1cW6UmEaeDUnYQ9h7AukpGAgAAUKQCAAAGcwA==
Date: Wed, 27 Sep 2023 13:22:55 +0000
Message-ID: <CY5PR12MB63690DF7BBAECEA70F3E224EC1C2A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230927054143.2169903-1-yifan1.zhang@amd.com>
 <5a02f9df-a198-600b-f413-79b60d2a2561@amd.com>
 <CADnq5_PD3n9Wmuf8ep8g50E3PZDQLsk-OWw=3eoZQn10W=RKGw@mail.gmail.com>
In-Reply-To: <CADnq5_PD3n9Wmuf8ep8g50E3PZDQLsk-OWw=3eoZQn10W=RKGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=87f67d52-1a63-4a08-9548-236353141be0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-27T13:19:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|DM4PR12MB5070:EE_
x-ms-office365-filtering-correlation-id: b641152f-d85e-4a2e-7c33-08dbbf5cdc81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n6363jwWLLbYJELXx/RvRh5K6xzUNpFu+92yQ2Rgy6E8Bqbm2KjkHMoEYHAMGd97exXhmIuOm33y+iqFtfL1HhUhTAOEkA16qlay7sm5pN2Fsz8jwFVtGV4niwVXTA123WjDGVU6LEkB6FJSFzkmUiQ42swZ3CSs4YjIMjyejAgP+10c5Qvdhh9r2awi9Od/4bMXRSqNKaOgNEETnc5URUFe2+qMbwObGeXyBwnXOcgwnH33o9ygBKv9M0Txgg/1xOzyatpJnW3A96eCaujEWjTj5Baf7qlBxIaeO2S608MbjAAJFg3djo0Q1GQCDRKvV4k66VgA0psLLhgA8HoHEWObsBRGIS3cDQYLUzSgvxXAh7VVh4x6A+qBCumfS/TKuJbMBWQRmpEct28lAk1WNeaMKblOD3DunOSp3aFfNOe7yRW1LOqGUL7sQX4Y3oBlQf+btV5q5JEpfLstH6y8QabwiI1C8rOIaktyd/yqEEebLFdrwkHDOrjK7Yy5/LN8OMVxnTrifh6KqAXBEH6dns1QjyF/OVruF5iDYQH+BCRLmzxT4I4nulPwkBfTynUIOF9WrOlhyAROTivzqoQCWL048+QRaWeLfoIK5P5yEG9zVdfMUbWEb+g1zfHMp4Do
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(346002)(366004)(396003)(230922051799003)(451199024)(1800799009)(186009)(86362001)(52536014)(8676002)(4326008)(8936002)(66476007)(6636002)(316002)(5660300002)(66556008)(41300700001)(110136005)(66946007)(76116006)(66446008)(64756008)(54906003)(2906002)(122000001)(83380400001)(55016003)(38100700002)(38070700005)(9686003)(33656002)(53546011)(26005)(478600001)(6506007)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vm54dzU1SHp6Rm9mQU9EZzNheldqa0dQRzBTaU92UDVKbFk4NDUvZnZ2WDNK?=
 =?utf-8?B?RWlRNHFrQllqSU1hZHVaM0JUV01aUjlpMHl3ZXR1RVA1TnVVVzRuR3lNSzBw?=
 =?utf-8?B?cVR2cGZBY05vbTg1OWpmSVV0TWVIQkFFYTZqQVdCMmtQZkdXeWt4REZqdEdv?=
 =?utf-8?B?SWUxTkxWMzdlaVZsU1luWk9zeVMrZEt5WjZkNlhBcXpkd0ZzN255Q01mcDd3?=
 =?utf-8?B?VzJ3c3JEQ3Z5T25ha0tuSEhMSHhJWGhDMDY3WEhKL1FvNi9qaksvSFVCcEpG?=
 =?utf-8?B?RFlqMXFPanZPV3AvWlJxcGdib0poUTVROE5URFFRWWUyQzdBV3ZVcU5tNVlU?=
 =?utf-8?B?K3NYL2RBYTFvNHExbSsrQTl0cmp3a05hUzRoK005cm1VODhBMkRwL3hYTmc2?=
 =?utf-8?B?K2hNc1ZTcDBDNDg1RER0NE83T3p3dm9ZeCs4NVM2bWVMNXBWZitvMFg3RDhR?=
 =?utf-8?B?a2ErbU5PVHNaZlJoalNHeE0vTjhkTWZBbkd6K21vOFZ3ZTI2eWpkdVN0RUZz?=
 =?utf-8?B?WXpLblBlRiszcUJ0Qy9KOTFVbmpJdWVWaFVBMFo3QVN2RHhpUlMyUUpSQi85?=
 =?utf-8?B?TWY1cm1DV2UvL1JkeUxqVGpvdnVCOUttalh4NU1rVXhSQ0tkSitVcXpTMUFs?=
 =?utf-8?B?bHllcGVIN0txWDZJclJ1TTdjZEdIWVRvS2MyY3JRUmpqcklaeWcrc1I5allL?=
 =?utf-8?B?azNHUjFncEp0RjFnTVZ0MEVWd3VRMXd3emFzbjQ4OEt0MGdhMmdVRVg0MGlF?=
 =?utf-8?B?MS9SSGVqQUpHWm5mT1dmWjk5LzZBaXNkb3J0cXVvS01nZ3NodXZDRUgvdWlQ?=
 =?utf-8?B?Y0l4KzdqUFJlNUo4UkhUOTRxakVLVkNzb2NOR1IxN0xzT2p5Vmp4dHUzc055?=
 =?utf-8?B?endHeWYyYi9wQkVNVk5YbThhQUUyVmRwK1lCU1lEOVRvSGkvWW0vaCtsNDB5?=
 =?utf-8?B?eWVyTjNRM0Z5Z0NYTFpFeFhkeGZ4ckpFOEV5Y1JxbVQwRDhhN0ltSUR1L1Vp?=
 =?utf-8?B?UW9KY1N1Q1JSRlkwY01rTjBWT25meDh1K0ptTGhSQlo2Q0ZKaDdBQjhLbDlw?=
 =?utf-8?B?S01MM01LTHZ6R25NUkhDZFRaQ2VocnJhVzN0YTd6NEZuNjNnWVVMdXArNDdl?=
 =?utf-8?B?T2ZnQk5JT3AvN0RHblRTdDg4WjFBUkU0eDAwNnpUTGVPaWlubnNGUmhyN0dV?=
 =?utf-8?B?MXU4T3M0NW5pK2MvRXRMcGxFaGw2MFFsQ0ViVW50dVdkYk1BMHk5WmdVQ0hD?=
 =?utf-8?B?b2tNei9DWHd4ZkZIaTdvQm8zUmFaTm1IVHlPc0NHcUNJLzJKVng0UExHZDVh?=
 =?utf-8?B?SjV6bUdqVUNJZDBlNXNWZitoQUVidk84T3dLeWdWaXpXbnZKYXlQL2pGbXRW?=
 =?utf-8?B?NkJJeXVXTm9kTTRYQUhDazU4OGVkQU1KWnBkUXVXL09QS21YUGJ5UWNuckdn?=
 =?utf-8?B?TmJqbjJXYzBkNnFkN0Q2cEhEWWhQTTIwUjQyUDVsNmxkRDJMck83VDJwQy9p?=
 =?utf-8?B?Rk5OSi9yVFBSb05EemdKWlRRYi9ZakNiWjVvc1hJRTJXWmR6bTRaejQ3QWM0?=
 =?utf-8?B?VVp6cTFtR0FFWGNuRnFLQzEyVy9oL1VRcCtYc292VTNQN21VSWMrY3JtOUFs?=
 =?utf-8?B?VjM1b1p3akxHN29ia2J5QXAxZDdjUkNja3lLa25DbkNCQnZrYytXaDdWZmJw?=
 =?utf-8?B?NnZTRjFORlJISVdaVEdkejFRSDYrR3A3YWR6Q3RLa2ZEMkRtVGdDMUt1QUhT?=
 =?utf-8?B?Y1owc0xJcDRWR0pvZ0tKK0x3T2ZMWWVENVBZbjV3WDMyZGluRFZFelByYUZ1?=
 =?utf-8?B?bEpZb0ZmcnBjMWxwWlAvLyt4b2VGZ1hmMWJhT1hVL0QrbnFLaVR3Z1RVQndI?=
 =?utf-8?B?ZEtjVU1neXlNNmJUaFQrZVkrcDhidzRXVlJHL2VmREppRW5XZGFsUkFpaXNl?=
 =?utf-8?B?Syt3WXRjTHVMTU1QQkZUOUJsQldLUGV3ZVJEV2hScGFQallxMUJPMi9wZnh3?=
 =?utf-8?B?UXFydTFLeWlNeXdsUzVXWjZ2Ykt0aVR4S2wycFk4RXF3VGQ2QlVaZE9VNFVj?=
 =?utf-8?B?MG1SQXFVaFNpUkhqZ2hVcGVWQUJtVTdSTE5OQTZnU0dNYTBmNE82L3BBak1Y?=
 =?utf-8?Q?Z/6k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b641152f-d85e-4a2e-7c33-08dbbf5cdc81
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 13:22:55.9813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d7IwDmLROzNAWcWjSGwfcVTDmNmk+g8PHQAzFGK3M9hh3CTMv6i4jntizn9KyCCO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkdvb2QgaWRlYSAhIFRoYW5rcy4N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRl
dWNoZXJAZ21haWwuY29tPg0KU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjcsIDIwMjMgOTox
MyBQTQ0KVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpD
YzogWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+DQpTdWJqZWN0OiBS
ZTogW1BBVENIXSBkcm0vYW1kL2Rpc3BsYXk6IGVuYWJsZSBTL0cgZGlzcGxheSBmb3IgZm9yIHJl
Y2VudCBBUFVzIGJ5IGRlZmF1bHQNCg0KT24gV2VkLCBTZXAgMjcsIDIwMjMgYXQgODoyNuKAr0FN
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6DQo+DQo+
IEFtIDI3LjA5LjIzIHVtIDA3OjQxIHNjaHJpZWIgWWlmYW4gWmhhbmc6DQo+ID4gV2l0aCBTL0cg
ZGlzcGxheSBiZWNvbWVzIHN0YWJsZSwgZW5hYmxlIFMvRyBkaXNwbGF5IGZvciByZWNlbnQgQVBV
cw0KPiA+IGJ5IGRlZmF1bHQgcmF0aGVyIHRoYW4gd2hpdGUgbGlzdC4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFlpZmFuIFpoYW5nIDx5aWZhbjEuemhhbmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDQzICsr
KysrLS0tLS0tLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCAzMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+ID4gaW5kZXggN2U2YTY5M2Q2MzY5
Li4yNDFmZDhkZWZkZWUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gPiBAQCAtMTYyNiw0MSArMTYyNiwxOCBA
QCBzdGF0aWMgaW50IGFtZGdwdV9kbV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0K
PiA+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gLSAgICAgc3dp
dGNoIChhZGV2LT5hc2ljX3R5cGUpIHsNCj4gPiAtICAgICBjYXNlIENISVBfQ0FSUklaTzoNCj4g
PiAtICAgICBjYXNlIENISVBfU1RPTkVZOg0KPiA+ICsgICAgIGlmICgoYWRldi0+YXNpY190eXBl
ID09IENISVBfQ0FSUklaTyB8fA0KPiA+ICsgICAgICAgICAgICAgYWRldi0+YXNpY190eXBlID09
IENISVBfU1RPTkVZIHx8DQo+ID4gKyAgICAgICAgICAgICAoKGFkZXYtPmZsYWdzICYgQU1EX0lT
X0FQVSkgJiYNCj4gPiArICAgICAgICAgICAgIGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIERDRV9I
V0lQLCAwKSA+PSBJUF9WRVJTSU9OKDEsIDAsIDApICYmDQo+ID4gKyAgICAgICAgICAgICAhKGFk
ZXYtPmFwdV9mbGFncyAmIEFNRF9BUFVfSVNfUkFWRU4pKSkgJiYNCj4gPiArICAgICAgICAgICAg
IGFtZGdwdV9zZ19kaXNwbGF5ICE9IDApIHsNCj4NCj4gTG9va3MgbGlrZSBhIGdvb2QgaWRlYSB0
byBtZSwgYnV0IHBsZWFzZSBkb3VibGUgY2hlY2sgeW91ciBjb2RpbmcNCj4gc3R5bGUgc2V0dGlu
Z3MuIFRoZSBzZWNvbmQgbGluZSBvZiBhbiAiaWYgKCIgc2hvdWxkIGJlIGluZGVudGVkIHNvDQo+
IHRoYXQgaXQgc3RhcnRzIGFmdGVyIHRoZSAiKCIgb2YgdGhlIHByZXZpb3VzIGxpbmUuDQo+DQo+
IEFkZGl0aW9uYWwgdG8gdGhhdCB0aGlzIGNoZWNrIGFjdHVhbGx5IGxvb2tzIHF1aXRlIG1lc3N5
IHRvIG1lIGFuZA0KPiBzaG91bGQgcHJvYmFibHkgYmUgY29udmVydGVkIHRvIGFsd2F5cyB1c2lu
ZyB0aGUgSVAgdmVyc2lvbiBpbnN0ZWFkIG9mDQo+IHRoZSBhc2ljX3R5cGUuDQoNCk9yIGp1c3Qg
ZXhwbGljaXRseSBkaXNhYmxlIGl0IG9uIHRoZSBoYW5kZnVsIG9yIHByZS1DWiBjaGlwcyB0aGF0
IGRvbid0IGFjdHVhbGx5IHN1cHBvcnQgaXQuDQpFLmcuLA0KDQpzd2l0Y2ggKGFzaWNfdHlwZSkg
ew0KY2FzZSBDSElQX0tBVkVSSToNCmNhc2UgQ0hJUF9LQUJJTkk6DQpjYXNlIENISVBfTVVMTElO
UzoNCiAgIHZtID0gZmFsc2U7DQogICBicmVhazsNCmNhc2UgQ0hJUF9SQVZFTjoNCiAgIGlmIChh
cHVfZmxhZ3MgJiBBTURfQVBVX0lTX1JBVkVOKQ0KICAgICAgIHZtID0gZmFsc2U7DQogICBlbHNl
DQogICAgICAgdm0gPSBhbWRncHVfc2dfZGlzcGxheSAhPSAwOw0KICAgYnJlYWs7DQpkZWZhdWx0
Og0KICAgdm0gPSAoYW1kZ3B1X3NnX2Rpc3BsYXkgIT0gMCkgJiYgKGZsYWdzICYmIEFNRF9JU19B
UFUpOw0KICAgYnJlYWs7DQoNCn0NCg0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+
ID4gICAgICAgICAgICAgICBpbml0X2RhdGEuZmxhZ3MuZ3B1X3ZtX3N1cHBvcnQgPSB0cnVlOw0K
PiA+IC0gICAgICAgICAgICAgYnJlYWs7DQo+ID4gLSAgICAgZGVmYXVsdDoNCj4gPiAtICAgICAg
ICAgICAgIHN3aXRjaCAoYW1kZ3B1X2lwX3ZlcnNpb24oYWRldiwgRENFX0hXSVAsIDApKSB7DQo+
ID4gLSAgICAgICAgICAgICBjYXNlIElQX1ZFUlNJT04oMSwgMCwgMCk6DQo+ID4gLSAgICAgICAg
ICAgICBjYXNlIElQX1ZFUlNJT04oMSwgMCwgMSk6DQo+ID4gLSAgICAgICAgICAgICAgICAgICAg
IC8qIGVuYWJsZSBTL0cgb24gUENPIGFuZCBSVjIgKi8NCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgaWYgKChhZGV2LT5hcHVfZmxhZ3MgJiBBTURfQVBVX0lTX1JBVkVOMikgfHwNCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgIChhZGV2LT5hcHVfZmxhZ3MgJiBBTURfQVBVX0lTX1BJQ0FT
U08pKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluaXRfZGF0YS5mbGFncy5n
cHVfdm1fc3VwcG9ydCA9IHRydWU7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0K
PiA+IC0gICAgICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDIsIDEsIDApOg0KPiA+IC0gICAgICAg
ICAgICAgY2FzZSBJUF9WRVJTSU9OKDMsIDAsIDEpOg0KPiA+IC0gICAgICAgICAgICAgY2FzZSBJ
UF9WRVJTSU9OKDMsIDEsIDIpOg0KPiA+IC0gICAgICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDMs
IDEsIDMpOg0KPiA+IC0gICAgICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDMsIDEsIDQpOg0KPiA+
IC0gICAgICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDMsIDEsIDUpOg0KPiA+IC0gICAgICAgICAg
ICAgY2FzZSBJUF9WRVJTSU9OKDMsIDEsIDYpOg0KPiA+IC0gICAgICAgICAgICAgY2FzZSBJUF9W
RVJTSU9OKDMsIDUsIDApOg0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBpbml0X2RhdGEuZmxh
Z3MuZ3B1X3ZtX3N1cHBvcnQgPSB0cnVlOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBicmVh
azsNCj4gPiAtICAgICAgICAgICAgIGRlZmF1bHQ6DQo+ID4gLSAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOw0KPiA+IC0gICAgICAgICAgICAgfQ0KPiA+IC0gICAgICAgICAgICAgYnJlYWs7DQo+
ID4gLSAgICAgfQ0KPiA+IC0gICAgIGlmIChpbml0X2RhdGEuZmxhZ3MuZ3B1X3ZtX3N1cHBvcnQg
JiYNCj4gPiAtICAgICAgICAgKGFtZGdwdV9zZ19kaXNwbGF5ID09IDApKQ0KPiA+IC0gICAgICAg
ICAgICAgaW5pdF9kYXRhLmZsYWdzLmdwdV92bV9zdXBwb3J0ID0gZmFsc2U7DQo+ID4gLQ0KPiA+
IC0gICAgIGlmIChpbml0X2RhdGEuZmxhZ3MuZ3B1X3ZtX3N1cHBvcnQpDQo+ID4gICAgICAgICAg
ICAgICBhZGV2LT5tb2RlX2luZm8uZ3B1X3ZtX3N1cHBvcnQgPSB0cnVlOw0KPiA+ICsgICAgIH0g
ZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICBpbml0X2RhdGEuZmxhZ3MuZ3B1X3ZtX3N1cHBvcnQg
PSBmYWxzZTsNCj4gPiArICAgICAgICAgICAgIGFkZXYtPm1vZGVfaW5mby5ncHVfdm1fc3VwcG9y
dCA9IGZhbHNlOw0KPiA+ICsgICAgIH0NCj4gPg0KPiA+ICAgICAgIGlmIChhbWRncHVfZGNfZmVh
dHVyZV9tYXNrICYgRENfRkJDX01BU0spDQo+ID4gICAgICAgICAgICAgICBpbml0X2RhdGEuZmxh
Z3MuZmJjX3N1cHBvcnQgPSB0cnVlOw0KPg0K
