Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E96C678D4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 09:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B69BC10E114;
	Thu,  2 Mar 2023 09:30:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D5AB10E114
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 09:30:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDV4CZZcXINHJ46NlhCb2KU22A/SVNA2JH+BKDZbZqA6whnGGd0LSUhLTeXp9QS4/5RI6hycWAEN5DqlD8Ha9p78+X//eanOzSxRQOHPW89oP93R0Uv4yK4qmawdalZkSQ8F82i0ietWTILM2ASaFWl6EdX8ultAg7GJ8+liWhs5Jw/a2hQzlS9z5+2uFuGzxMrvMCKrZpXrwlBdc72JlN8dRJ9MSrRxmzwRf6MwKD3ch2jnPchtduhcHNTKiPGtGngM/tiey0Yfkyp/M3KHNWFymzVhNTrsyrRk530lNJrLb5u4xMNrktWk7a/MGlYGlO3iSyLFkRLlv8KIeWU9Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+WYAuxx80BEUuCb1bAkHNpQD4uIu4wPOxIng6cCdIA=;
 b=Bpb1jkaiemnO80G3opVqkTL6pLLwh2KYLqhAQW4gRoDdcGCXqElacXLQ1eQdbDuSyLGT29n4I3PH5AlH3jijB1rxywBZ5JQLpJvX3sYcENzbuIfqbaPUbsrGNCXw20FBwbPuVXqND77ZVG4yVjD+R//yfSQiTWHzEOArTAIhr1EI9L1rFdZdKpWzNiP+zZZatlZgJRql7qu0fEjSl3tp15tyQyYWVG1JQpHx/2XIzQG5Os6g8DNN+6GoFcGwYjsvLzmDYxkuxmiW4P+y369oj4+XSkgN4cJjhxBLl8e1yh+6yMAQGaGnGP6dfB5bSO338BOUywVHMlMtL/DXzACEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+WYAuxx80BEUuCb1bAkHNpQD4uIu4wPOxIng6cCdIA=;
 b=ExSeLbIHeLAQWZP42qmY743IB5OycfgvlDV+DL8t+eLLybKHHQuz41mA3ziC0rADNRUT2NofymC1xM+g1UW2u4uxS5C5eZZWfnSc7zWHjTi685X5wxiClpbq7wZQmRhWMwmr9xuxUjnSy0PFQrnNvwyb3hXB4bXjATVr8yI7qDE=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 09:30:45 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%5]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 09:30:45 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable cstate properly for driver reloading
 scenario
Thread-Topic: [PATCH] drm/amdgpu: disable cstate properly for driver reloading
 scenario
Thread-Index: AQHZTNSN4d29W/wiL0e5VWf8g5wtfK7nKA6AgAALmwCAAAM5gIAAANPw
Date: Thu, 2 Mar 2023 09:30:44 +0000
Message-ID: <DM6PR12MB261981BCAAB3ECAC82031921E4B29@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230302065835.3905147-1-evan.quan@amd.com>
 <47d45518-bad2-0855-170c-31022ada6dae@amd.com>
 <DM6PR12MB26199B972F0D02381059933EE4B29@DM6PR12MB2619.namprd12.prod.outlook.com>
 <f72fe6fd-8d41-b99d-fd0c-d893e2d5e158@amd.com>
In-Reply-To: <f72fe6fd-8d41-b99d-fd0c-d893e2d5e158@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-02T09:30:40Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a4c57553-c362-4157-a92b-c340524cc554;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|IA1PR12MB6460:EE_
x-ms-office365-filtering-correlation-id: 669a2505-e83e-4f6d-83de-08db1b00cc95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WHLlCBhbawqp3rRrcNv96R/vgZXHtKVgmxGToRhBDcUBS3ok1yZmbqbnfjSy8GR3oCRmJJWgV3E6nFazFqQB5c0WXxCBX9iABykD+xO9mNkuFbomRFIAta1eKroZxmqRIM5oZGjTlT9bDangFSrTVQsbjxoJa97krH2ks2c7rxFRy9gNUWkAlhi3FOiQIt4SzAqsokvQG227eg4LqQgOR+eBFZH2V41Ow+GJyP6/OcFaY+KJ3/qAHdfZuiYGCBDz55P/yhHpLfWOFo1/D1/cjCE5HEVeMDWa/saAYa7ha8V/Rq58WjVhU6x5XKfS0jVzz4NK0Xt+iv5RIIYjdTdmyfGQAGVtz0MQlaAQDXjknF8KTlIgbx2xHWOJBKOc+5NSlQWx/n5/yM0BBDdTWkDSZ2tfD/2l4JB3+8PBfX42cbqryFOpSWIFfOKx40kT+mCXatWNqcEYvOhkDS81/yvUJT3LMWMlUPf/K7Qiz66gUgAEcEPqFiXRx/NvhRN2qChXY3cL0nNrAPo0fuyEL3UUEdFAb+I5Uv2TT+Mc0/VDGs2SDNE1BxelYykVUeX9JtmoeacOEpvBbbU2Ya7KSnDl56qArwSNP199NhAfLaru30zSn/AHfDWDYMPejUfSSX7P+cE8tjs7150LBbQMIjsTcFrRlpDBtLT1/O1jsMSejyl3UCYHyCIXFGe2cT8xLdxZcmSraRhOFLjXXA7pqP7wew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199018)(2906002)(316002)(5660300002)(478600001)(83380400001)(33656002)(52536014)(8936002)(86362001)(41300700001)(38070700005)(66556008)(76116006)(66446008)(64756008)(66946007)(66476007)(8676002)(110136005)(38100700002)(122000001)(6636002)(55016003)(7696005)(26005)(9686003)(186003)(53546011)(6506007)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vmw1cm10VEZUMy9xV3BoaDN1dFRNQ1pRcndhTXBSY3A3Mk1MK1A3eS9BYU9y?=
 =?utf-8?B?NTcyNlhJUHVWVGh1Y1NPQ2JsRjlLSUZpYmpjZHovdUg3WnFxaWJUV0JkUzVZ?=
 =?utf-8?B?ejRDU3NJN0Z3ekJ4bHpwM2RibHZwYk4rek4zSlpTcy84cHVTWUpMTG1veGpQ?=
 =?utf-8?B?RVg5L1JIcnZVTXlQTG9VNm80cTk4N0NHRnhkTGFwTUxxTXZaNW1FV0o5VW1D?=
 =?utf-8?B?QnVDSmNnV1JVcXJSMlhqdDdWbzNHbE5XbXhsRE9MVVp0dDVOUjhGcnN6REpU?=
 =?utf-8?B?R21tM214UFBUNnNlV1RQcmNLZjdwSi8vUndHVjJQN3Q3V3k3OWdPNDJoVito?=
 =?utf-8?B?aHZLZ0gxc3A4cDkyazZWWTZaREJyVGxCQmhkS2VzcWtmeU9xRXh0dFVRVEtL?=
 =?utf-8?B?d2J0cWVXa2g2TkJ6Nk56ZE9hMTcxR3hvZjQva2dWYWZ0eHpjRzduUUl1R0RF?=
 =?utf-8?B?aDZrS2t1aHBZR0dzZjZJQ2RwdytkYWppaHVzc3pKOFd3RXFUaHVOTmlpbjRB?=
 =?utf-8?B?NkZjVHBLaFVZcWNvNXlmK0dZaktsM1RRUE05SzFtWVRkWEpwa1lLdEFWLzh2?=
 =?utf-8?B?ODFNSHZwN21zVFRUWno3eWdpV1J0K2tQN3ZITlhlejJNWDlSUHgyNDFoY1la?=
 =?utf-8?B?dEUrclgvNUVIVk5OQURablp0dkk0R1lkdWY5dFhyRndBNlBCTDhlZFUwLzll?=
 =?utf-8?B?QWNqQ0thby9ndnJBbXlocmRmWVJKZThkSkY2Z29BSVcwOEprMW0yTjBCVHRv?=
 =?utf-8?B?RTdaOHdUcmR1d1FMbDRBTkVYYW5yS0hmRzBqTmZ1eHRmVjlZZTJoNU40S0xQ?=
 =?utf-8?B?TWUwUUljdU5ldHhMMVFUeUVaZ3QyZXBpZXcyZng5QVNTZ3B5VXdGYXEzcW96?=
 =?utf-8?B?N0dwYktMWDR3d0Y5Q1p0WHoyV1gwdWtrK1p2d3J1M1cvekdsUTBheVBsRENh?=
 =?utf-8?B?SC9kbkdXZDZPSTV0QWxzc1RobllIQzQwZGs5aEduQWg5Y2lnYTJBaFhvSWNu?=
 =?utf-8?B?N1JFbTMrVWpNNEhwUEMyUW1TNXdYejg1MERzQ3p2aVFkZ0xMd1pTQ3RzQm10?=
 =?utf-8?B?UW9tdTNOcEF4NW5oeU9DU1IvOWJtVHdkWmdpQjFBMlZRQkJpVW1sT0JxTlZN?=
 =?utf-8?B?azErTUFlU1FlZjh2c2pnZFN4WlUvM2ltTk9UZnRCNk5yMlo1aTcvYXpHdGhI?=
 =?utf-8?B?dGZlZ1FkQWxCMHdoODNzaEd6UlBDdUZjam1rb0xqTXptdGIwTkdwYmt0ZUZJ?=
 =?utf-8?B?K2hYMngyQVRGaEtyamY2QWpqRUZiTDJYSmJFcE1SYlJuOUNvYmZMNUhGdUI2?=
 =?utf-8?B?NkNHcko1WjVtSmdkeFI2eDdXbERQUzc5V0E2a3BhSDVuT3l5VG9RVWxUTW02?=
 =?utf-8?B?UUlNNUxUV1FFT0s4Y0g5SnhGVmxjbHdUbmhCZ0pUUy8rejNtbjBxZGEwN2E3?=
 =?utf-8?B?NVdJV01EZ1I5eHVRMFpuU2E1Q1dORzVZTDJqSHRJUGJWTnhob2ZyeFRhbnBE?=
 =?utf-8?B?K3oxc25qM2NSUWQzUXFOMzFkVXJQZTllclp3Mzg2RUJOeXFGRVU1Qm4wN0hY?=
 =?utf-8?B?NytWZm8zODZPREFUYXlLTUo1bXJpL0pzMW81a2l6djJ3SnZSRmxzSWRLREFs?=
 =?utf-8?B?citjSSsxejJwMVpCcGtwYVkrQUF6M0Jyb2tiTFU5ZDhheWRJNWp0S0w4c282?=
 =?utf-8?B?bllub3MybEQzdkNzaTN2aGY2eXA5SEl5UGxhbzR3SVFkTjkySFZZTVhjMWdx?=
 =?utf-8?B?azBvMCszOVVYV1dUU1o1QUJMNTVZSjQ2eWdSQjdHY2czcFlHdENWWm9CK2VP?=
 =?utf-8?B?Um1QR1pMTCtaTjJTaXdwQnFGcitkL0hVdVFZNTZYSjFxMUNpMmdJMkhrbzZw?=
 =?utf-8?B?T05lVll6dmdnVUh0c1ZjNmNCOFZPNjRDclNTOStzdWtwKzNOZ0loTjZBcGtB?=
 =?utf-8?B?Q0Z6VWJkMkRLbnZnbGtQVmR4Z3FaNmZPdHpnamtYVTg2dU5nNnVPVlN6SXMx?=
 =?utf-8?B?czBsS0FWUXJGNCsyVFBrSkMwZUZEa3FaSE1RTWRLd3NDRnZraVoybXYrVENF?=
 =?utf-8?B?S0dkUWhmTjJVS3dnbklkREtPVW9XcFozb3VvNENmOHFWVWZNd0c0TGRNVHN4?=
 =?utf-8?Q?BTPs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669a2505-e83e-4f6d-83de-08db1b00cc95
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 09:30:44.8732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nInkM0vN5Z7LpfrHAYwtX1uo6751etzMheHdo3tNhH61bf82k3R402a+RXuCy31M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyLCAyMDIzIDU6MjEgUE0NCj4gVG86IFF1YW4sIEV2YW4g
PEV2YW4uUXVhbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6
IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZGlzYWJsZSBjc3RhdGUgcHJvcGVybHkgZm9yIGRy
aXZlcg0KPiByZWxvYWRpbmcgc2NlbmFyaW8NCj4gDQo+IA0KPiANCj4gT24gMy8yLzIwMjMgMjo0
MyBQTSwgUXVhbiwgRXZhbiB3cm90ZToNCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gR2Vu
ZXJhbF0NCj4gPg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
Pj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gPj4gU2VudDogVGh1
cnNkYXksIE1hcmNoIDIsIDIwMjMgNDoyOCBQTQ0KPiA+PiBUbzogUXVhbiwgRXZhbiA8RXZhbi5R
dWFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+PiBDYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiA+PiBTdWJqZWN0
OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBkaXNhYmxlIGNzdGF0ZSBwcm9wZXJseSBmb3IgZHJp
dmVyDQo+ID4+IHJlbG9hZGluZyBzY2VuYXJpbw0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAz
LzIvMjAyMyAxMjoyOCBQTSwgRXZhbiBRdWFuIHdyb3RlOg0KPiA+Pj4gR3B1IHJlc2V0IG1pZ2h0
IGJlIG5lZWRlZCBkdXJpbmcgZHJpdmVyIHJlbG9hZGluZy4gVG8gZ3VhcmQgdGhhdChncHUNCj4g
Pj4+IHJlc2V0KSB3b3JrLCBkZiBjc3RhdGUgbmVlZHMgdG8gYmUgZGlzYWJsZWQgcHJvcGVybHku
DQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNv
bT4NCj4gPj4+IENoYW5nZS1JZDogSTVjMDc0YzI2NWMwYjA4YTY3YjY5MzRhZTFhZDlhYTNmZWQy
NDU0NjENCj4gPj4+IC0tLQ0KPiA+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jIHwgOSArKysrKysrKysNCj4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+Pj4gaW5kZXggNTFiYmVhYTFmMzExLi4zYzg1NDQ2MWVm
MzIgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYw0KPiA+Pj4gQEAgLTI4MTYsNiArMjgxNiwxNSBAQCBzdGF0aWMgaW50IGFtZGdwdV9k
ZXZpY2VfaXBfZmluaV9lYXJseShzdHJ1Y3QNCj4gPj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4g
Pj4+ICAgIAlhbWRncHVfZGV2aWNlX3NldF9wZ19zdGF0ZShhZGV2LCBBTURfUEdfU1RBVEVfVU5H
QVRFKTsNCj4gPj4+ICAgIAlhbWRncHVfZGV2aWNlX3NldF9jZ19zdGF0ZShhZGV2LCBBTURfQ0df
U1RBVEVfVU5HQVRFKTsNCj4gPj4+DQo+ID4+PiArCS8qDQo+ID4+PiArCSAqIEdldCBkZiBjc3Rh
dGUgZGlzYWJsZWQgcHJvcGVybHkgb24gZHJpdmVyIHVubG9hZGluZy4NCj4gPj4+ICsJICogU2lu
Y2Ugb24gdGhlIHN1Y2NlZWRpbmcgZHJpdmVyIHJlbG9hZGluZywgZ3B1IHJlc2V0IG1pZ2h0DQo+
ID4+PiArCSAqIGJlIHJlcXVpcmVkLiBBbmQgY3N0YXRlIGRpc2FibGVkIGlzIGEgcHJlcmVxdWlz
aXRlIGZvcg0KPiA+Pj4gKwkgKiB0aGF0KGdwdSByZXNldCkuDQo+ID4+PiArCSAqLw0KPiA+Pj4g
KwlpZiAoYW1kZ3B1X2RwbV9zZXRfZGZfY3N0YXRlKGFkZXYsIERGX0NTVEFURV9ESVNBTExPVykp
DQo+ID4+PiArCQlkZXZfd2FybihhZGV2LT5kZXYsICJGYWlsZWQgdG8gZGlzYWxsb3cgZGYgY3N0
YXRlIik7DQo+ID4+PiArDQo+ID4+DQo+ID4+IFRoaXMgbG9va3MgbW9yZSBsaWtlIGEgZmlybXdh
cmUgYnVnLiBEcml2ZXIgc2VuZHMgdGhlIFVubG9hZCBtZXNzYWdlIHRvDQo+IEZXLg0KPiA+PiBJ
biB0aGF0IGNhc2UgRlcgc2hvdWxkIGRpc2FibGUgYWxsIGZlYXR1cmVzIGluY2x1ZGluZyBDLXN0
YXRlLg0KPiA+IERyaXZlciBkb2VzIG5vdCBzZW5kIHRoZSBVbmxvYWQgbWVzc2FnZS4gV2Ugd2Fu
dCBQTUZNIGFsaXZlIGFuZCByZWFkeQ0KPiBmb3IgaGFuZGxpbmcgcG9zc2libGUgZ3B1IHJlc2V0
IG9uIHJlbG9hZGluZy4NCj4gPg0KPiANCj4gQWN0dWFsbHksIHNvYzIxX25lZWRfcmVzZXRfb25f
aW5pdCBjb2RlIGl0c2VsZiBoYXMgYSBidWcuIFBTUCB3b24ndCBnZXQNCj4gdW5sb2FkZWQgYnkg
ZGVmYXVsdCBvbiByaW5nIGRlc3RydWN0aW9uLiBFdmVuIGlmIFBTUCBzdG9wcywgaXQgY291bGQg
anVzdCBrZWVwDQo+IHRoZSBoZWFydGJlYXQgdmFsdWUgYXMgbm9uLXplcm8gKGp1c3QgdGhhdCBp
dCB3b24ndCBpbmNyZW1lbnQpLg0KPiANCj4gUHJvYmFibHksIHRoYXQgbmVlZHMgdG8gYmUgZml4
ZWQgZmlyc3QgcmF0aGVyIHRoYW4ga2VlcGluZyBQTUZXIGFsaXZlIGZvciBhDQo+IHJlc2V0Lg0K
QXMgSSByZW1lbWJlcmVkLCB0aGUgY2hhbmdlKGFzaWMgcmVzZXQgZHVyaW5nIHJlbG9hZGluZykg
c2VlbWVkIGludHJvZHVjZWQgdG8gYWRkcmVzcyBzb21lIHNyaW92IGlzc3Vlcy4NCkBEZXVjaGVy
LCBBbGV4YW5kZXIgbWlnaHQgc2hhcmUgbW9yZSBiYWNrZ3JvdW5kcyBhYm91dCB0aGlzLg0KVG8g
YmUgaG9uZXN0LCBJJ20gbm90IGEgZmFuIG9mIHRoaXMocGVyZm9ybSBhc2ljIHJlc2V0IGR1cmlu
ZyByZWxvYWRpbmcpLg0KDQpFdmFuDQo+IA0KPiBUaGFua3MsDQo+IExpam8NCj4gDQo+ID4gQlIN
Cj4gPiBFdmFuDQo+ID4+DQo+ID4+IFRoYW5rcywNCj4gPj4gTGlqbw0KPiA+Pg0KPiA+Pj4gICAg
CWFtZGdwdV9hbWRrZmRfc3VzcGVuZChhZGV2LCBmYWxzZSk7DQo+ID4+Pg0KPiA+Pj4gICAgCS8q
IFdvcmthcm91ZCBmb3IgQVNJQ3MgbmVlZCB0byBkaXNhYmxlIFNNQyBmaXJzdCAqLw0K
