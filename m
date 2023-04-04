Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A67C761A6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 14:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD0D10E412;
	Tue,  4 Apr 2023 14:43:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F1F10E412
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 14:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKF0o8g6CjW92Zh9EuFefcozy5HYB/M42+YbzUtO9WS+dHo0FHdPgsTa3O9v7Iatzd8cDlCxsBPbNF+oWMpYXm0NCXGHR61+WcySlECU1GBPLfkLwGElXLgdoR0rqL/vkdlr7S5rXdP1+IZ/YwCtIRQiK0hIGM9KjoUQczJF+sOvno14Ng4QCEWhhdrVHgtogF3bFJnqYwg5pLdkQ2bgn30HGQm2JpTn3aph8S3nX1YkY45axc7Pki/osxwSfPWxhHmBRufLv8wi94IFoaNJS5/Ob8e8cdNAHSgtaKFsMPHbzT/IoI4IeixqKcK9ICHcAwPuMoqHTLvebF8KHANKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2oFmpxi/aYxVXbYKN3ijKHouldn458y7Di1dqATi28=;
 b=EULcyt+jxeGOwsgkx389BPcE6+3RX6m+SnlnzWvvFy2PUd7YnJywDp+ys5Te33kkvq91uokjgdgZ54GNgXOty0J75cM/qNc0WgXGqB1O70ek3Tav+7N8MKaABGMaPtuk++KhUBJ++GiD1r+HoOGj61zK7vL5LWR4hq32EtBbC3mmhLUMpQjhhF5TNObly/kQ9uM9qJqhAjyCdfYRRn87HeG44IaGr6xZZsCIZ4xbAh77RJID981p+tW7g82rzBBlrSIgGHjeWy+hLL4cXIqmrHA5yP1d0e1M32LC7/NHLi013Y8tyJoB3bsn9EQw1DI8KgBDVOny5eoq5n8L7bw5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2oFmpxi/aYxVXbYKN3ijKHouldn458y7Di1dqATi28=;
 b=1LyRkxyna6RNPmImzbmoIpJfdBCaIPfQYQ571TlTnhva/qpkMRS8ATlIlPVOtEsphMR5OEyRFcuaDeVRTsS19SQcHp6nMtB9L4C14TW0NBoWwJEGTQB89UgjUhAyUNDXJhxrB+hGpzmtLxf3yIAubIiFg40od+KYtS623HMTspw=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 14:43:03 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::6b6e:7238:b357:8185]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::6b6e:7238:b357:8185%9]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 14:43:03 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs when
 iommu is on
Thread-Topic: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs when
 iommu is on
Thread-Index: AQHZZtvUozkdp1zAF0e4jgIRazGDMa8a8iCAgAAEpfCAACK0gIAAECUAgAANzVA=
Date: Tue, 4 Apr 2023 14:43:03 +0000
Message-ID: <DM4PR12MB5261F405598A14CAF81598469D939@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20230404095640.3277840-1-shane.xiao@amd.com>
 <cd5efdb0-d6f6-8e91-353f-35906a1fe62f@amd.com>
 <DM4PR12MB5261B08BE4730541920230F89D939@DM4PR12MB5261.namprd12.prod.outlook.com>
 <c5bd045a-a5ff-36ea-ed9b-bc4732b50b16@gmail.com>
 <539b143b-64fd-9108-1967-04e2ef27848e@amd.com>
In-Reply-To: <539b143b-64fd-9108-1967-04e2ef27848e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-04T14:42:55Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3557e62c-0cf0-4102-8a5f-03aba1ae85ad;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-04T14:42:55Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: aa0ad256-bc46-4e68-ac41-87b5a9958a55
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|PH7PR12MB7258:EE_
x-ms-office365-filtering-correlation-id: 49bb08b1-edaf-4b6d-fc0f-08db351ae56e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XP3LAupzCXmxuYsmbQN9jZs5FGDdKxKETcb/00asHFN6s0YY3lXA7WwKcreUQm4FkfASfYaO2yReHiIMLL0KDkbP4+b+9s25zl7kn+57ifuq+19BIC92ZKmOvQgOV99DQipwtRnC9Djz1lX8Lqg1ju/7ZvyrIclwI6sVLKz/p5ad8vZDwcTm/X+MR9Q8ZVQqwpYm/HdTUAI8b0L4Pr/476b2aTsHRJUFTq060pZj/Ue/voyxreJVlcmqC+76ZbOb/Rn+as3BSrFOnARdVwOcNUCzsodvCDcmPTrSDeGZIADiDilQl5ZebyLr0rgeeF2LwNiUZaat7hoLhNwyuSRJSxeN86zrCv0KmVg0UfuID1OYBtT6hSw+a86NrudIXChGk+YvHXcoM/4GUcrv8KH6mHxw7qYueJ9TGWSqgkmZJUde36gZQgE6Ih2iNtFEsAH9Me0MVh11m38eznOAsMhdJKni4Z8AqiabXrI6HKP0nHwOChP7F4DLTOg6GaJ/bRBoxq0ceQFXTziGdk90IGMDm6h1aoCUgucC4/ID/cOuTeM7ygBiEo+AyH5HvcKyMulSCZHaWScvw24EWtMnongApmgJNb6iZUhUbnDFGTVbnYA+3Rr1bqDeopmwk4+rmrlt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(66476007)(186003)(66574015)(66446008)(64756008)(38100700002)(122000001)(41300700001)(71200400001)(7696005)(26005)(53546011)(6506007)(83380400001)(9686003)(66556008)(478600001)(110136005)(316002)(2906002)(33656002)(86362001)(66946007)(76116006)(55016003)(4326008)(8676002)(5660300002)(54906003)(6636002)(38070700005)(8936002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEtydW9YVGZnbUViRGhrbnUwWTlJeTB5ZnNxR1JNVUlFVC9BREs0Yk1MYU03?=
 =?utf-8?B?c3hyeFlidUhvMGtrUk84QWJ4ZXFybFFXSUZmUUxLc0hTSkdRUGN3U1liM3k4?=
 =?utf-8?B?Y04zQnZjazVMaS9sOUdDQ2x3REtteUt3ZUdBSlNlL1grU09QWXBmeTJTUjFD?=
 =?utf-8?B?dVBoYUREd2g2SWxjNzh0VHpMZGlsbnBnd1JqY3hkRDg0aUY0QVRZZkMzaWJZ?=
 =?utf-8?B?QVp0ZkxwRURBVzRXaFcrTW13bnhRQ05FK1FvazBGT2ZEWEZicFJCMXNSRUky?=
 =?utf-8?B?VjRDSk9UR3ZtZitTeGtyWXQzbjNYZk9YT01Wc1lmVFRHOExTaUdYMDhDTkxm?=
 =?utf-8?B?R05pWmZTOWhjdCtxT2xHbTkxaTBsTitybHJMUVdWUFVtWVZsYnpRYlpBTkhG?=
 =?utf-8?B?azhDZVY1RWYwOVVoVWFyOG5GVThzdjJSSmxsaFBUc3Vhdi96Q0ZNNktqc0ox?=
 =?utf-8?B?c2VreDhJM0lTSjN6U2dJVFN6WGlxY1RCQVVVcTJJREt0NHV6aUNRc1Noby80?=
 =?utf-8?B?UzNZTmxSOTFFYnNjSmc1ZG1Cci85VHZrZ0JZbTZlLzYvVWhySlRyVXBLZlVX?=
 =?utf-8?B?TFVkS04xWnZnTWlaQmFXUnVqS2dyQ3pUQVlRSTVRdGxJYmEwOGZKRDRmdWN1?=
 =?utf-8?B?U3AxT3FDWGlxL2x2dE41OW9Id050RDRwUVVUWWV5WnBFa09xaTl5S2N6SS9Y?=
 =?utf-8?B?NnZ0RzgvZWxUNHJZcjBVTlkzZGh5eGdlOVNUZ2FVcW1yK1haQzI5QTdTcjZI?=
 =?utf-8?B?amkva3oxZ3RqbFJBWkVNUDNPNFoveXBpamRsL3l5WG9FZFJDWVBzOXdTY3dm?=
 =?utf-8?B?dWlBRml2eFFDc1lkNGJZKzUzTmpKdmtRdjdiV0lrMVlGR2ZYQnNXSGE4OWVN?=
 =?utf-8?B?ZFRMM2IwTTZHY3U2cytkd3U2NUVadldmOVEySWlBRW04NmNLU2FwZUxGSlhU?=
 =?utf-8?B?Ry9ZaUFuSWxWVllEbThWTXZiZUJVMkZrb1ZUZVdKd1NKOXJPaUFRTkdISmNT?=
 =?utf-8?B?NDAreDFLMnBSR3FFYnBrV0VrSi9BSmRodnEydG1DcUYzcVZ4VDM0QXBTZldI?=
 =?utf-8?B?VllWTHc1ak11NEx0bDhkSWpBSjdkTU41b1lFeGFQVUFPL1gySU9BOGQ2UnpQ?=
 =?utf-8?B?VUpXd1R1ZVp0Z2dUb01VQWxhVEU0RkVRTXgycW10am9Hb0xYS3JNaGpsOHpr?=
 =?utf-8?B?bzNmWE5yQWt3cGNISGphZ2FQaFJXSEF0cmM1M003L1gxU21CbVNvN092MjJQ?=
 =?utf-8?B?OVljSFFJa0VIUDZ6eHJtS1lVWDE5Y2xmL0t1aTlCMlQxNFJuRXFSbWF1UVVR?=
 =?utf-8?B?ZXo2TFAzRnNFR3VOZVh1dEVlRkV4UlFCSk14WDJuOGdad2p3VGtUdkNiaUZ6?=
 =?utf-8?B?N3p3Q0hiWGptZ09RZXBpOGVyMUwvbklLWW9xRGtVQ1FNRk8rOW5sV0JDQ083?=
 =?utf-8?B?RWt5L1dkQzZHb3dLdS8yTS9tMHRYMm1JUmEyUEhWeFZMNlNXdmJiR1BmTHVC?=
 =?utf-8?B?ckxJeXpYczZkNlpSajVnY21QQ29YZTVZSUkvMHdWem5iK2VvYXppTzBGTzF3?=
 =?utf-8?B?Slp2ZzY3bmFHNk9OQ3hucFVqbVZ5UGpJRW54LzE0YkNZZ0FUb0hTd0tOVzhB?=
 =?utf-8?B?NWpLcm91V3F1VFlCTWp4QldBNjhETEYySWNJOE5lQ2FCQVdpMmlTVytRaEJh?=
 =?utf-8?B?RzBSNGZIREQ1czU2SC9IcFlJMEdRSXpDKytnbFZNQVRnNEtTdWV1T1ZGaGdw?=
 =?utf-8?B?aW44WjB3VGt6TWFMMzAzc2VDVEVoNDZrdytsKzNQQ3FYZ01JSDV1RWxaaUtU?=
 =?utf-8?B?RG43VzVScW5mU1NUeWlLQ1Z6U1ZFN1V5ektxd1hOZk9iSUNwaThwKy84UGJR?=
 =?utf-8?B?c0k4UGMxWjNidVlneFF3TnZ2ancwRzRmZ2wrK3JIS0trOHZHUHo4VFk1eWhS?=
 =?utf-8?B?enVidmhjRkIrQkRYcXl2aElmM003QjZWbGZnR1hDajd3SC9yUzVsek9iM29G?=
 =?utf-8?B?ZkFVRjQzVnlJMmdab2F5eFgxMDhvVlU5Y09tZ0tIcFVIWEVSd3IvSllqc016?=
 =?utf-8?B?Y1M4NzlyWGs5dEpKZGRnQmlLTlMzWXl0dDljVTZnZGoyaGhGWHBqQ0lSekNB?=
 =?utf-8?Q?JvQQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bb08b1-edaf-4b6d-fc0f-08db351ae56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 14:43:03.7355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5JOYnknEY+W+SLlZk+JzMRK58wT6NktkufWK0FF8bE/TOJDadZGkYjcN/i/yDI8YNIVUSTzptc+iFYa/qEZZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
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
Cc: "Liu, Aaron" <Aaron.Liu@amd.com>, "Guo, Shikai" <Shikai.Guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgNCwgMjAyMyA5OjQ1IFBNDQo+IFRvOiBDaHJp
c3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT47IFhpYW8sIFNo
YW5lDQo+IDxzaGFuZS54aWFvQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPjsNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFlhbmcs
IFBoaWxpcCA8UGhpbGlwLllhbmdAYW1kLmNvbT4NCj4gQ2M6IExpdSwgQWFyb24gPEFhcm9uLkxp
dUBhbWQuY29tPjsgR3VvLCBTaGlrYWkgPFNoaWthaS5HdW9AYW1kLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAxLzNdIGRybS9hbWRncHU6IEFkZCB1c2VycHRyIGJvIHN1cHBvcnQgZm9yIG1H
UFVzDQo+IHdoZW4gaW9tbXUgaXMgb24NCj4gDQo+IFsrUGhpbGlwXQ0KPiANCj4gQW0gMjAyMy0w
NC0wNCB1bSAwODo0NyBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6DQo+IA0KPiA+IEFtIDA0LjA0
LjIzIHVtIDEyOjU2IHNjaHJpZWIgWGlhbywgU2hhbmU6DQo+ID4+IFtBTUQgT2ZmaWNpYWwgVXNl
IE9ubHkgLSBHZW5lcmFsXQ0KPiA+Pg0KPiA+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPj4+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
DQo+ID4+PiBTZW50OiBUdWVzZGF5LCBBcHJpbCA0LCAyMDIzIDY6MjcgUE0NCj4gPj4+IFRvOiBY
aWFvLCBTaGFuZSA8c2hhbmUueGlhb0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7DQo+ID4+PiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+
ID4+PiBDYzogTGl1LCBBYXJvbiA8QWFyb24uTGl1QGFtZC5jb20+OyBHdW8sIFNoaWthaSA8U2hp
a2FpLkd1b0BhbWQuY29tPg0KPiA+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGRybS9hbWRn
cHU6IEFkZCB1c2VycHRyIGJvIHN1cHBvcnQgZm9yDQo+ID4+PiBtR1BVcyB3aGVuIGlvbW11IGlz
IG9uDQo+ID4+Pg0KPiA+Pj4gQW0gMDQuMDQuMjMgdW0gMTE6NTYgc2NocmllYiBTaGFuZSBYaWFv
Og0KPiA+Pj4+IEZvciB1c2VycHRyIGJvIHdpdGggaW9tbXUgb24sIG11bHRpcGxlIEdQVXMgdXNl
IHNhbWUgc3lzdGVtIG1lbW9yeQ0KPiA+Pj4+IGRtYSBtYXBwaW5nIGFkZHJlc3Mgd2hlbiBib3Ro
IGJvX2FkZXYgYW5kIGFkZXYgaW4gaWRlbnRpdHkgbW9kZSBvcg0KPiA+Pj4+IGluIHRoZSBzYW1l
IGlvbW11IGdyb3VwLg0KPiA+PiBIaSBDaHJpc3RpYW4sDQo+ID4+DQo+ID4+PiBXVEY/IFVzZXJw
dHIgQk9zIGFyZSBub3QgYWxsb3dlZCB0byBiZSBleHBvcnRlZC9pbXBvcnRlZCBiZXR3ZWVuDQo+
ID4+PiBkaWZmZXJlbnQgR1BVcy4NCj4gPj4+DQo+ID4+PiBTbyBob3cgY2FuIHRoZSBzYW1lIHVz
ZXJwdHIgQk8gYmUgdXNlZCBvbiBkaWZmZXJlbnQgR1BVcz8NCj4gPj4gSWYgR1BVcyBhcmUgYWxs
IGluIGlvbW11IGlkZW50aXR5IG1vZGUgd2hpY2ggbWVhbnMgZG1hIGFkZHJlc3MgYXJlDQo+ID4+
IHRoZSBzYW1lIGFzIHBoeXNpY2FsIGFkZHJlc3MswqAgYWxsIG9mIHRoZSBHUFVzIGNhbiBzZWUg
dGhlIHN5c3RlbQ0KPiA+PiBtZW1vcnkgZGlyZWN0bHkuDQo+ID4+DQo+ID4+IEluIHN1Y2ggY2Fz
ZSwgc2hvdWxkIHdlIGV4cG9ydC9pbXBvcnQgdGhlIEJPLMKgIHRoZW4gY3JlYXRlIGEgbmV3IFNH
DQo+ID4+IEJPIGZvciBhbm90aGVyIEdQVT8NCj4gPg0KPiA+IFllcywgYWJzb2x1dGVseS4gRWFj
aCB1c2VycHRyIEJPIGlzIG9ubHkgbWVhbnQgdG8gYmUgdXNlZCBvbiBvbmUgR1BVLg0KPiA+DQo+
ID4gRXZlbiBpZiB5b3UgY291bGQgdXNlIHRoZSBzYW1lIEJPIGZvciBtdWx0aXBsZSBHUFVzIGl0
J3Mgbm90IG5lY2Vzc2FyeQ0KPiA+IGEgZ29vZCBpZGVhIHNpbmNlIHlvdSB0aGVuIGhhdmUgbGl2
ZSB0aW1lIHByb2JsZW1zIGZvciBleGFtcGxlLg0KPiA+DQo+ID4gRS5nLiB3aGF0IGhhcHBlbnMg
d2hlbiBvbmUgR1BVIGlzIGhvdCByZW1vdmVkIHdoaWxlIHRoZSBvdGhlciBvbmUgd2hvDQo+ID4g
aW1wb3J0ZWQgdGhlIEJPIGlzIHN0aWxsIGluIHVzZT8NCj4gPg0KPiA+IEZlbGl4IGNhbiB5b3Ug
Y29tbWVudCBvbiB0aGF0PyBNeSByZWNvbGxlY3Rpb24gd2FzIHRoYXQgd2UgcmF0aGVyDQo+ID4g
aW1wcm92ZSB0aGUgc3RvcmFnZSBvZiBETUEgYWRkcmVzc2VzIGluc3RlYWQgb2YgZHVwbGljYXRp
bmcgdGhlIEJPcw0KPiA+IG92ZXIgZGlmZmVyZW50IEdQVXMuDQo+IA0KPiBGb3IgS0ZEIHdlIGN1
cnJlbnRseSBlbmFibGUgc2hhcmluZyBvZiB1c2VycHRyIEJPcyBiZXR3ZWVuIG11bHRpcGxlIEdQ
VXMgYnkNCj4gY3JlYXRpbmcgYSB1c2VycHRyIEJPIGZvciB0aGUgZmlyc3QgR1BVLCBhbmQgY3Jl
YXRpbmcgYWRkaXRpb25hbCBTRyBCT3MgdXNpbmcNCj4gdGhlIHNhbWUgcGFnZSBsaXN0IGZvciBh
ZGRpdGlvbmFsIEdQVXMuIFRoYXQgd2F5IHdlIGRvbid0IGhhdmUgdG8gY2FsbA0KPiBobW1fcmFu
Z2VfZmF1bHQgTiB0aW1lcyBhbmQgc2V0dXAgTiBNTVUgbm90aWZpZXJzIGZvciB0aGUgc2FtZSBh
ZGRyZXNzDQo+IHJhbmdlIG9uIGFuIE4gR1BVIHN5c3RlbS4gQnV0IHdlIGRvIGhhdmUgdG8gY3Jl
YXRlIE4gRE1BIG1hcHBpbmdzLCB3aGljaA0KPiBpcyBmYWNpbGl0YXRlZCBieSB0aGUgU0cgQk9z
Lg0KPiANCj4gV2UgaGF2ZSBhIGZ1cnRoZXIgb3B0aW1pemF0aW9uIHRvIG5vdCBldmVuIHN0b3Jl
IHNlcGFyYXRlIERNQSBhZGRyZXNzZXMgcGVyLQ0KPiBHUFUgaWYgdGhleSBhcmUgYSBkaXJlY3Qg
bWFwcGluZy4gSW4gdGhhdCBjYXNlIHdlIGp1c3QgaW5jcmVhc2UgdGhlIHJlZmVyZW5jZQ0KPiBj
b3VudCBvbiB0aGUgb3JpZ2luYWwgdXNlcnB0ciBCTy4gKEkgYWdyZWUgdGhhdCB3ZSBzaG91bGQg
YWxzbyBsb29rIGludG8gbW9yZQ0KPiBlZmZpY2llbnQgc3RvcmFnZSBvZiBETUEgYWRkcmVzc2Vz
LiBIb3dldmVyLCBsYXN0IHRpbWUgd2UgdGFsa2VkIGFib3V0IHRoaXMsDQo+IHlvdSBiYXNpY2Fs
bHkgdG9sZCB1cyB0aGF0IHNjYXR0ZXIgZ2F0aGVyIHRhYmxlcyBhcmUgYmVpbmcgZGVwcmVjYXRl
ZCwgYnV0IEkNCj4gaGF2ZW4ndCBzZWVuIHRoZSBhbHRlcm5hdGl2ZSB5ZXQuKQ0KPiANCj4gSSB0
aGluayB0aGlzIHBhdGNoIGZpeGVzIGEgcG90ZW50aWFsIGlzc3VlIHdpdGggdGhhdCBvcHRpbWl6
YXRpb24uIFRoZXJlIGlzIGFuDQo+IGltcGxpY2l0IGFzc3VtcHRpb24sIHRoYXQgdGhlIERNQSBh
ZGRyZXNzZXMgc3RvcmVkIGluIHRoZSBvcmlnaW5hbCB1c2VycHRyIEJPDQo+IGFyZSBhIGRpcmVj
dCBtYXBwaW5nLCBzbyB3ZSBjYW4gcmV1c2UgdGhlbSBvbiBvdGhlciBHUFVzIHRoYXQgYWxzbyB1
c2UgYQ0KPiBkaXJlY3QgbWFwcGluZy4gQnV0LCB3ZSBkaWRuJ3QgYWN0dWFsbHkgY2hlY2sgdGhh
dCBhc3N1bXB0aW9uLiBJIHRoaW5rIHRoaXMgcGF0Y2gNCj4gZml4ZXMgdGhhdCBmb3Igc3lzdGVt
cyB3aGVyZSBzeXN0ZW0gbWVtb3J5IGlzIGRpcmVjdCBtYXBwZWQgb24gc29tZSBidXQgbm90DQo+
IGFsbCBHUFVzLg0KPiANCj4gVGhpcyBzY2VuYXJpbyBzaG91bGQgcHJvYmFibHkgYmUgY2FsbGVk
IG91dCBleHBsaWNpdGx5IGluIHRoZSBwYXRjaCBkZXNjcmlwdGlvbi4NCg0KWWVzLCBJIHdpbGwg
YWRkIHRoaXMgc2NlbmFyaW8gb24gdGhlIGNvbW1lbnQuDQoNCj4gVGhlIGNvbmRpdGlvbiBpcyBh
bHNvIGdldHRpbmcgcHJldHR5IGhhcmQgdG8gcmVhZCBhbmQgdW5kZXJzdGFuZC4gTWF5YmUgbW92
ZQ0KPiB0aGUgYm90aC1kaXJlY3QtbWFwLW9yLXNhbWUtaW9tbXUtZ3JvdXANCj4gY29uZGl0aW9u
cyBpbnRvIGEgaGVscGVyIGZ1bmN0aW9uLCBzYXkNCj4gImFtZGdwdV90dG1fdHRfZ2V0X3VzZXJt
bShtZW0tPmJvLT50Ym8udHRtKSAmJiByZXVzZV9kbWFtYXAoYWRldiwNCj4gYm9fYWRldikiLg0K
DQpJdCdzIGEgZ29vZCBzdWdnZXN0aW9uLiBJIHdpbGwgbWFrZSB0aGUgY2hhbmdlLg0KDQpCZXN0
IFJlZ2FyZHMsDQpTaGFuZQ0KDQo+IA0KPiBSZWdhcmRzLA0KPiAgwqAgRmVsaXgNCj4gDQo+IA0K
PiA+DQo+ID4gUmVnYXJkcywNCj4gPiBDaHJpc3RpYW4uDQo+ID4NCj4gPj4NCj4gPj4NCj4gPj4g
QmVzdCBSZWdhcmRzLA0KPiA+PiBTaGFuZQ0KPiA+Pg0KPiA+Pj4gUmVnYXJkcywNCj4gPj4+IENo
cmlzdGlhbi4NCj4gPj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogU2hhbmUgWGlhbyA8c2hhbmUu
eGlhb0BhbWQuY29tPg0KPiA+Pj4+IC0tLQ0KPiA+Pj4+IMKgwqAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwgOCArKysrLS0tLQ0KPiA+Pj4+IMKgwqAg
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPj4+Pg0K
PiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1k
a2ZkX2dwdXZtLmMNCj4gPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmRfZ3B1dm0uYw0KPiA+Pj4+IGluZGV4IGU3NDAzZjhlNGViYS4uMzNjZGEzNThjYjllIDEw
MDY0NA0KPiA+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmRfZ3B1dm0uYw0KPiA+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYw0KPiA+Pj4+IEBAIC04MDQsMTEgKzgwNCwxMSBAQCBzdGF0aWMgaW50
IGtmZF9tZW1fYXR0YWNoKHN0cnVjdA0KPiA+Pj4+IGFtZGdwdV9kZXZpY2UNCj4gPj4+ICphZGV2
LCBzdHJ1Y3Qga2dkX21lbSAqbWVtLA0KPiA+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB2YSArIGJvX3NpemUsIHZtKTsNCj4gPj4+Pg0KPiA+Pj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmICgoYWRldiA9PSBib19hZGV2ICYmICEobWVtLT5hbGxvY19mbGFncyAmDQo+ID4+PiBL
RkRfSU9DX0FMTE9DX01FTV9GTEFHU19NTUlPX1JFTUFQKSkgfHwNCj4gPj4+PiAtIChhbWRncHVf
dHRtX3R0X2dldF91c2VybW0obWVtLT5iby0+dGJvLnR0bSkgJiYNCj4gPj4+IGFkZXYtPnJhbV9p
c19kaXJlY3RfbWFwcGVkKSB8fA0KPiA+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNhbWVf
aGl2ZSkgew0KPiA+Pj4+ICsgKGFtZGdwdV90dG1fdHRfZ2V0X3VzZXJtbShtZW0tPmJvLT50Ym8u
dHRtKSAmJg0KPiA+Pj4gKChhZGV2LT5yYW1faXNfZGlyZWN0X21hcHBlZCAmJiBib19hZGV2LT5y
YW1faXNfZGlyZWN0X21hcHBlZCkgfHwNCj4gPj4+PiArIGFkZXYtPmRldi0+aW9tbXVfZ3JvdXAg
PT0gYm9fYWRldi0+ZGV2LQ0KPiA+Pj4+IGlvbW11X2dyb3VwKSkgfHwNCj4gPj4+PiArc2FtZV9o
aXZlKXsNCj4gPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIE1hcHBpbmdzIG9u
IHRoZSBsb2NhbCBHUFUsIG9yIFZSQU0gbWFwcGluZ3MgaW4NCj4gPj4+IHRoZQ0KPiA+Pj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBsb2NhbCBoaXZlLCBvciB1c2VycHRyIG1hcHBpbmcg
SU9NTVUgZGlyZWN0IG1hcA0KPiA+Pj4gbW9kZQ0KPiA+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKiBzaGFyZSB0aGUgb3JpZ2luYWwgQk8NCj4gPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICogbG9jYWwgaGl2ZSwgb3IgdXNlcnB0ciBtYXBwaW5nIGluIHRoZSBzYW1lIGRtYQ0K
PiA+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBhZGRyZXNzIHNwYWNlIHNoYXJlIHRo
ZSBvcmlnaW5hbCBCTw0KPiA+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLw0K
PiA+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXR0YWNobWVudFtpXS0+dHlwZSA9
IEtGRF9NRU1fQVRUX1NIQVJFRDsNCj4gPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGJvW2ldID0gbWVtLT5ibzsNCj4gPg==
