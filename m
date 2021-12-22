Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F74C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 08:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0251125CB;
	Wed, 22 Dec 2021 08:18:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BEEF1125CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 08:18:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpGEr05ZTpoWZvonU/0jX2Lp0Nsw1bu14/G7xatoWYB/cI5xyOTxDo51FZvq25a59Bg8+XyyD599x3g1hz9Ko3p0IUSEGiaY0RNEjpGxVaa7Sv/XxvDwJvn18Dn/bWNPTRsEIiTXw4fIJXrJ2IPh7xQAc45uEgDkpanaeLHjymVVi71fOAufF25pEnkWuyTG5UQqmEjG0aoFyLeOX71502hBWWVZut5UHlinhBKt0DgvIKIigx26gURBd1oaRSXO+XxKhUAz+/tLQgNQ+A5qglEr9MKbg+De3oT5U3N/eG0TZVDogyrkwcpC/gshV58apDlw4tmULzpbl2rfxL/PIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnPYdQDSwKp7VBUr4JCshe3uzNJF/ty0cCbJBj7bJE0=;
 b=lOaH6QwTpramfsGFlfaz/Wwo9Y0s9vgcrvBDWHFXaME9AWIXALK906n4rJXImxcUvx8fFrrl7c0MeYiFyZ083Vz57uG3tNa5cq/XIVM3T14TZsufwpyymUNzZeY3F/s/dOWt6sZrRbgorfut3rArc3VjGhK/cQOgFJvXUvx49Ec3PlAP+egiGXcAwukRW8KFyEMs3llMmoOGtJpNY3yk5mL3BRIJBK6xeibsfga0gosbO5fzxyx6fhwyiv29ngYmPHTIg7jBTZP7QcGw3v4vcUj/osu92hVOZGv/XRbcJ0sUsAOMPmZpiGmg6lpusEsxzJq/V96nC3/zjVtJ6mssoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnPYdQDSwKp7VBUr4JCshe3uzNJF/ty0cCbJBj7bJE0=;
 b=ZsuTEuQ46sD7MO9aKSTn9HrAyltZmTgrud/glflFIXf10bv5YY8xtithX6V2Ah9D1SuqxGm6+KNHIt6qLbRhMRQfWRsadLRYL+xZcYsiYMf+KF0mV/2O/TH7XgMt3MNlRMUcmSSo6lLoGUE+rB/bs5SPHeb5anwdPFZqcE52D/g=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Wed, 22 Dec
 2021 08:18:15 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::b85e:962f:c2ae:b58a]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::b85e:962f:c2ae:b58a%5]) with mapi id 15.20.4801.015; Wed, 22 Dec 2021
 08:18:15 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/ttm: add workaround for some arm hardware issue
Thread-Topic: [PATCH] drm/ttm: add workaround for some arm hardware issue
Thread-Index: AQHX9vgKVbmRhUpew0q7E3aAWG80Jqw+KPmAgAABp0A=
Date: Wed, 22 Dec 2021 08:18:14 +0000
Message-ID: <PH0PR12MB5417224A3CDAAE1B030BAAE88F7D9@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20211222055140.1215839-1-Victor.Zhao@amd.com>
 <b6edb4d8-b9b6-224f-d35f-5477fc1f7687@gmail.com>
In-Reply-To: <b6edb4d8-b9b6-224f-d35f-5477fc1f7687@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fdff2788-d426-4b1b-9db8-8021cbf4b0cc;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-22T08:16:55Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da7510de-7f18-4462-6793-08d9c5239a30
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_
x-microsoft-antispam-prvs: <PH0PR12MB5404B345B3690BC0E00312828F7D9@PH0PR12MB5404.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EZNX6G1q77nRyxeZFGduKiHmv8nCuwy8dxYgJP1OzlhNI7DL+z4xXWTf4tu5tB4E8tRRIyxWy6nMaUw9BjK56JzAkJd97Sk4FzygMRHMHZdmvU8qcEvPg8u+9McV0H/ytqBPvmK8M/IgewzJ8MAVYfMem5jM/2pK6MP4W63/iveIOkzNf6CFmRLLZLryhxnhGo4syXLV36BRMVSvU9M5KLsdBbI3I5INWs9Ie33kbF/i/AOoQxEwVt2VXeXmupD+tjg/YXHZ+5O1o5yV9NgI3/vj7SPfw5BHcoRBh56eUyfb4kuROgnMPW/CB/12TGaAG79xvQLCwJXYEEjszE+lcQhXLBmSL4o8uAQDxYq2P5ovStcxO54Vf5r32j0FFFkDYlMHUJcykebeOrL5B58LgBpM1T5U6rTP7ZLKKOW262gVHU9gHjrvlXizWjyKJvSwpP0OfbXVJCamJQP4jc7O68lhiv1jm0hpgH15RPk4HlR46dxgZXleB2tgvso/X4vBhmYCe/24rvn8giSckd+4K0HZ3SqbBlFRbJa1AasOxh/CzeBbPwdCdMeF8HylSD2Feewyhs9LydPmaoLPBUezwqmN4xlEbawiZ1KA9Pf6QWP8wpo9en94Q7KsPm6tVdEQCNkZwkIgHtqqyGUiVfm8fgki30WWZePlV3jz82Gwfm3HwzoPnXDVjc1kkRogjPF76+V8o8f1M7wIkrGcHQD7MQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(71200400001)(110136005)(7696005)(38100700002)(122000001)(66574015)(38070700005)(83380400001)(55016003)(66946007)(5660300002)(9686003)(26005)(86362001)(76116006)(6506007)(316002)(33656002)(8936002)(8676002)(2906002)(66476007)(66556008)(64756008)(66446008)(186003)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTg4YU5XcjlDSm1lVExDalRCOFZJWjY0ZzZJbzVTaTZHR2RsRlJ2bVJDQVg4?=
 =?utf-8?B?ck5QMEwvYVNLMkt1OERaYnRnOE9WNGUrMkdPY3ZPNXZZaTl4RHloZU9WaDlz?=
 =?utf-8?B?R21uamlOVU5kckk1SGxGN2o4SXhaZUIzWGdWanp1RkFwc1J2Q0M4bFBUZmVO?=
 =?utf-8?B?Z2wwTXBtRkdnVmVFNnZWYk1PR3A5OTBvQmtOMWpsZ0x2VUdwN1hBcGd1ZTlM?=
 =?utf-8?B?U0RNckR4cUwwcDZSaW5RZ1V6RjdPQVRiZVp4RkdUem53eVV5U09qeGlEcmY0?=
 =?utf-8?B?dFdkL3cxcnA1VjA5RGZFRm1xWEdSVTdzSEVvTTZrcm5FMVZ0dk44aERlUEMx?=
 =?utf-8?B?V3ZTNHY5WkEzYURGbzd1ZHVLbzVySzMzeStDbWZUQnRTbHFPSjhwaU93cEIr?=
 =?utf-8?B?UnQwc1cxcGxiUGtDVE9NNEkxZytxSzlkcEZmc3ZCZ1g3eERSaE9UYys5a0Ru?=
 =?utf-8?B?NnRBZE1VcHJ1ZTRlU3Zock5SNm5KZGV1T2p4RW15d3VxSk9sOVREUnZZeGxI?=
 =?utf-8?B?ZUI4Q1dIRmxIaURrcHFHYVlkQ1QxSUNwenROdW9xSDJwT0xtdHkreE9ObGQ2?=
 =?utf-8?B?UFJPand0dFJYdUxOWWxoQWsxM1dZZitadXllM0pGQTdsaWJsOVhUNjFIWVJE?=
 =?utf-8?B?M0RBb3Z2K1RML0RVUlRsc2JkZk1tZlRGMjBreHR4eTV1OXMrMGNhMjhENHlu?=
 =?utf-8?B?eEh1c2NwdkU4S044WHlrUlZubENTaEtBR2R3Vk1VajFhUmdSTGNjMFhIMXZx?=
 =?utf-8?B?ZmpWcmpoWG1td0ovT2xHczY5ei9LTWNTWkE3VkFUQnVmN2cvdzZmTzlTNEpi?=
 =?utf-8?B?Z1dMazlITzJIVVRDaDVKZ0FSbURtaXNhdGxvMGFGT2RGN1FoMW1yRG9pRUtR?=
 =?utf-8?B?dXozemErRHh3MyswV0E0eCs4WnZPeUovK3h1YjduOUdIWWRCNWdObm8zRWRL?=
 =?utf-8?B?dlBxdkdYcVpKSzZ6NUpybFppTUJKYkFOSHVwV0hURDRRWnYyS3RpR2JGQ04y?=
 =?utf-8?B?Y0NPTEY3SGhZZDhteXVjUWhWZWw4dVEvQ2I2QkxNKzFLenpSM0dBMXNKRWRo?=
 =?utf-8?B?VE1EaTNKREZmRlp1MzAvN2tVYk9kc0JaWHpmUDNXOWs4MitnSTNPSnZjTTNn?=
 =?utf-8?B?ajJxelo4ZFZSdEZMSGYxTERWTisrcVFYYmJmdUZBVVREYmE0dzczWDFjbmFy?=
 =?utf-8?B?K29ZRDZhREtoV1d1NUg1enAydCtOZkNFdkM5RXRDODdwemlkQjlzbzljWkpL?=
 =?utf-8?B?S2RCaDYrQUMwa1hqL0MrVnNxUVQrdEhCOStUQmVLcElsL2JoVktxbTM4VEp3?=
 =?utf-8?B?NENIR1BzSUZqRi9mSmlGYlhrdGlCSjh0emJuOWhSckJqbnJRL3FwT2JjbUgx?=
 =?utf-8?B?NzRVTXlma21QY1cwVGp4clUyQ01Manc2LzBwNmdVTnNldlZqMVVPVk44S0x1?=
 =?utf-8?B?anRiR0NUZlViVk1oK01Ed25JRG1VQmN3Mk03RmFmVkR2S2lEZ3hxTGkyU2R5?=
 =?utf-8?B?Y2Mwelh4YXpOcmRoeW9OSGZ1ZGtmK3R4ZHlZWkdmNGYvVzZ1UlMzWG1pUDNK?=
 =?utf-8?B?dVhybGUyeVBCVDFmOVViUjlmVkRtNlVMY3pzdVgzZW5iQnpDUjF3SURxTkVm?=
 =?utf-8?B?UHdudHhzM2RTUGxNaEk4dzBrUityYXM1ZE9oMnRyUmtVcW1OV3Jwb3RGd01C?=
 =?utf-8?B?b3VqVzlNZzU1TVVzczNrOUhLeFhvcHNyUkJQYkJmS1RHUkpLQmw4eTVNQ0dp?=
 =?utf-8?B?bDk4UHNJR21CZHUrVHQrQmdtQVdSUlg3U1VTaDgycWtucllEZUZzZ0JkY3hI?=
 =?utf-8?B?Tng4d29RcGxxSHFncFFlaXBlZXpwaTRESThFY3dyYTF1cGx3ZklGQTNyL09L?=
 =?utf-8?B?Y05QQ0V3bFhYL09BUjcxNnJHbUdxM1pYZVA0STV5OGRaTHllUFFKaHJMb2xh?=
 =?utf-8?B?MFlOa3Fma3IrWGE2dEVXcTlKWmg1aWwvQXNxbTRQWmJ3TGJHQUFyRjlDblU0?=
 =?utf-8?B?WFpEaUIzT2xDZ05ZV2ZQUW45RWI2NGlaSlFqMHR2S1JDTXNBYTlrMVc4dU9X?=
 =?utf-8?B?ZzVJYzJTYjBEa1VTZ0R0K2xpT3pYWGxxb3VrN3JFbkV6eVJicjN5azArMHBC?=
 =?utf-8?Q?WA3M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7510de-7f18-4462-6793-08d9c5239a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 08:18:14.9194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hpMmlrgKDvDeXc8O97iynGkRbe6/0xboS+Tc7ggAchT83+DSvIyRwvpeHjfbGQnz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KQ3VycmVudGx5LCBvbmx5IGFtcGVyZSBmb3VuZCB0
aGlzIGlzc3VlLCBidXQgaXQgaXMgaGFyZCB0byBkZXRlY3QgYW1wZXJlIGJvYXJkLCBlc3BlY2lh
bGx5IG9uIGFybSBwYXNzdGhyb3VnaCBlbnZpcm9ubWVudC4NCg0KQmVzdCB3aXNoZXMNCkVtaWx5
IERlbmcNCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGFtZC1nZngg
PGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPkNo
cmlzdGlhbiBLw7ZuaWcNCj5TZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDIyLCAyMDIxIDQ6MTEg
UE0NCj5UbzogWmhhbywgVmljdG9yIDxWaWN0b3IuWmhhb0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vdHRtOiBhZGQgd29y
a2Fyb3VuZCBmb3Igc29tZSBhcm0gaGFyZHdhcmUgaXNzdWUNCj4NCj5BbSAyMi4xMi4yMSB1bSAw
Njo1MSBzY2hyaWViIFZpY3RvciBaaGFvOg0KPj4gU29tZSBBcm0gYmFzZWQgcGxhdGZvcm0gaGFz
IGhhcmR3YXJlIGlzc3VlIHdoaWNoIG1heSBnZW5lcmF0ZQ0KPj4gaW5jb3JyZWN0IGFkZHJlc3Nl
cyB3aGVuIHJlY2VpdmluZyB3cml0ZXMgZnJvbSB0aGUgQ1BVIHdpdGggYQ0KPj4gZGlzY29udGln
dW91cyBzZXQgb2YgYnl0ZSBlbmFibGVzLiBUaGlzIGFmZmVjdHMgdGhlIHdyaXRlcyB3aXRoIHdy
aXRlDQo+PiBjb21iaW5lIHByb3BlcnR5Lg0KPg0KPkNhbiB5b3UgcG9pbnQgb3V0IHdoaWNoIGFy
bSBwbGF0Zm9ybXMgYXJlIHRoYXQgZXhhY3RseT8NCj4NCj4+IFdvcmthcm91bmQgYnkgY2hhbmdl
IFBST1RfTk9STUFMX05DIHRvIFBST1RfREVWSUNFX25HblJFIG9uIGFybS4NCj4+IEFzIHRoaXMg
aXMgYW4gaXNzdWUgd2l0aCBzb21lIHNwZWNpZmljIGFybSBiYXNlZCBjcHUsIGFkZGluZyBhIHR0
bQ0KPj4gcGFyYW1ldGVyIHRvIGNvbnRyb2wuDQo+DQo+U29tZXRoaW5nIGFzIGZ1bmRhbWVudGFs
IGFzIHRoaXMgc2hvdWxkIG5vdCBiZSBtYWRlIGNvbnRyb2xsYWJsZSBieSBhbg0KPm1vZHVsZSBw
YXJhbWV0ZXIuDQo+DQo+V3JpdGUgY29tYmluaW5nIGlzIHZlcnkgaW1wb3J0YW50IGZvciBnb29k
IHBlcmZvcm1hbmNlIGFuZCBzbyB3ZSBzaG91bGQNCj5vbmx5IGRpc2FibGUgaXQgb24gYm9hcmRz
IHdoZXJlIHdlIGtub3cgdGhhdCB0aGlzIHdvbid0IHdvcmsgY29ycmVjdGx5Lg0KPg0KPlJlZ2Fy
ZHMsDQo+Q2hyaXN0aWFuLg0KPg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZpY3RvciBaaGFvIDxW
aWN0b3IuWmhhb0BhbWQuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRt
X21vZHVsZS5jIHwgOCArKysrKysrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX21vZHVsZS5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX21vZHVsZS5jDQo+
PiBpbmRleCBlODdmNDA2NzRhNGQuLmIyNzQ3M2NiYmQ1MiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS90dG0vdHRtX21vZHVsZS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRt
L3R0bV9tb2R1bGUuYw0KPj4gQEAgLTQxLDYgKzQxLDEyIEBADQo+Pg0KPj4gICAjaW5jbHVkZSAi
dHRtX21vZHVsZS5oIg0KPj4NCj4+ICtzdGF0aWMgaW50IGVuYWJsZV91c2Vfd2MgPSAxOw0KPj4g
Kw0KPj4gK01PRFVMRV9QQVJNX0RFU0MoZW5hYmxlX3VzZV93YywNCj4+ICsgICAgImNvbnRyb2wg
d3JpdGUgY29tYmluZSB1c2FnZSBvbiBhcm0gcGxhdGZvcm0gZHVlIHRvIGhhcmR3YXJlIGlzc3Vl
DQo+PiArd2l0aCB3cml0ZSBjb21iaW5lIGZvdW5kIG9uIHNvbWUgc3BlY2lmaWMgYXJtIGNwdSAo
MSA9DQo+PiArZW5hYmxlKGRlZmF1bHQpLCAwID0gZGlzYWJsZSkiKTsgbW9kdWxlX3BhcmFtKGVu
YWJsZV91c2Vfd2MsIGludCwNCj4+ICswNjQ0KTsNCj4+ICsNCj4+ICAgLyoqDQo+PiAgICAqIHR0
bV9wcm90X2Zyb21fY2FjaGluZyAtIE1vZGlmeSB0aGUgcGFnZSBwcm90ZWN0aW9uIGFjY29yZGlu
ZyB0byB0aGUNCj4+ICAgICogdHRtIGNhY2luZyBtb2RlDQo+PiBAQCAtNjMsNyArNjksNyBAQCBw
Z3Byb3RfdCB0dG1fcHJvdF9mcm9tX2NhY2hpbmcoZW51bSB0dG1fY2FjaGluZw0KPmNhY2hpbmcs
IHBncHJvdF90IHRtcCkNCj4+ICAgI2VuZGlmDQo+PiAgICNpZiBkZWZpbmVkKF9faWE2NF9fKSB8
fCBkZWZpbmVkKF9fYXJtX18pIHx8IGRlZmluZWQoX19hYXJjaDY0X18pIHx8IFwNCj4+ICAgICAg
ZGVmaW5lZChfX3Bvd2VycGNfXykgfHwgZGVmaW5lZChfX21pcHNfXykNCj4+IC0gICAgaWYgKGNh
Y2hpbmcgPT0gdHRtX3dyaXRlX2NvbWJpbmVkKQ0KPj4gKyAgICBpZiAoY2FjaGluZyA9PSB0dG1f
d3JpdGVfY29tYmluZWQgJiYgZW5hYmxlX3VzZV93YyAhPSAwKQ0KPj4gICAgICAgICAgICAgIHRt
cCA9IHBncHJvdF93cml0ZWNvbWJpbmUodG1wKTsNCj4+ICAgICAgZWxzZQ0KPj4gICAgICAgICAg
ICAgIHRtcCA9IHBncHJvdF9ub25jYWNoZWQodG1wKTsNCg0K
