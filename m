Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724E7C71153
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Sep 2023 01:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF7910E265;
	Mon,  4 Sep 2023 01:23:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C841510E265
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 01:23:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMX/A9TxlGUtDrDdzoiGLQ6ogWSgT9rqvLJLZAZxRLt62jBT9SU7DCR34JXgPM07vg8ke0Rzj8WzFJmHlX3yLVW1Bzy0ay7UgB3hCDRM6HL1UTEZMuMh59Vgm7cPBeMRDkKHnOcvEi2y8pujQPtd/feb9LvZFDX3hS6B/165VegPEn0gXcS4Y2OzOOpwm+qgivU1CmWqXkLQAoBPdf+kVMLt3wsOtLshslFMwoQbU+roTh7iJCwMiS1bVXKwWWn4wsn2ljbERP+zEJKOnZYZ4YgKpSdiC8PUH24jo61vTAPKKySUQEeNCX+yHvcqBJeDYpUCMo2KaGImAWCmv/e/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amA/WAGfKETj+vJRf1RaLq/W+SnKAxVW1h5cqOHFh+c=;
 b=nSylgo3RoCa+fyVT7Ok60aWHhOHQdXrDBoKj38ev/647oJHRopxej7zZAOV/dT19wTZin4JGaeAcXzHOOi1AT25f+nVpldvYQO1lVbdwiqqYNMwBYhLvqWmmlL8DIJ3CBtVHJvDHlRmaIa9n3vRsEbTJRZO53lQDbTSwm/l3z375v2+Rra0BpnGuhGqVYWhX5Bf4ccNmn9XD93Z6OyfSEVDjDkPOG/DmdgZ6sIQvy7ei4en4YuOGWTLcUl3s+X5lboyFaojafRE4nUI46DLCpI1Ch8zDOY4d0GrhSMnMQVTPvlLkLu3i+0G6XW+k3ATFNPcg+g1lRoLV2VCQMtbDfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amA/WAGfKETj+vJRf1RaLq/W+SnKAxVW1h5cqOHFh+c=;
 b=D36sVc1lrDU8Sz2VwOb0YNHP83kyETKtI3Bj+g4veodJEIgKo4qJfuIGBSumlc5SwxUgCygK8Ud3fLY2jXgAKHSylFoJKys1xrFk9lqTOSQGlgJQOeSM6W1SSaxbkHrvedOQxP93aM8twIXsiJB7idt+CKZfAZPibx+FNqsuxsI=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.30; Mon, 4 Sep 2023 01:23:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::56a5:d451:bf62:2b06]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::56a5:d451:bf62:2b06%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 01:23:11 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [V3 0/7] A new set of Linux OD interfaces
Thread-Topic: [V3 0/7] A new set of Linux OD interfaces
Thread-Index: AQHZ2wbOOPW/kgfNLEu6hdeAHSkQlrAC1xSAgAHTWgCABThNYA==
Date: Mon, 4 Sep 2023 01:23:11 +0000
Message-ID: <DM6PR12MB2619A62E560384E195C286A8E4E9A@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230830055648.477908-1-evan.quan@amd.com>
 <CADnq5_MT5bNB2oYDKArk1K5FOW8e4=+6gxPzaWjoGi5=aep6xQ@mail.gmail.com>
 <CADnq5_O7bv1E7UE0ShoTcTmw2Nir7s+NszPCFo0NhL1_X7Y-2g@mail.gmail.com>
In-Reply-To: <CADnq5_O7bv1E7UE0ShoTcTmw2Nir7s+NszPCFo0NhL1_X7Y-2g@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=49125669-7bc0-4e7f-a0a9-1282ba5bb083;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-04T01:09:02Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DS0PR12MB6584:EE_
x-ms-office365-filtering-correlation-id: 59e72e29-f7be-4b4f-cf8e-08dbace580eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nrN7IKjdxYIpn3IScy/qcPnbQdDhR4Ec1nONRLoh5kXzYyzdWZ1WhATDOYU9endBBf7XY/RRumvjmdbW+bZDIA8lJ9JQ8n05++rWCum/ApIySFxAFoWgYzsYxkkSv+8oRfyfpgQa7zWu88epwiARFwyohVP7RHCZTSVoQ8ZOSUCQDGsmGlJmIoW6rOcOuB6ety/JQ5wiOIIV6MqYAj5XVxkYqKkThtjb1gUmDVU2FyO1nXmTexm2v+5IeDwn2PfcBLP7IrHayZSLmmOgJGuYQ0VOPQQtXxPl3jCGY8C04ezU4WFhmaOyA4PJFMVMB7UkrUCsQc5yKp1Vd1WW28o9Bh07W8uilClQVEGhGw37+SpWn1jMebSYYDT7u036mKQ2Y3qTU7zp2uZ5bLgKv+9mX9FNyCeCDG1uT/Xn51pCQQVZNg9aDSdbqHChEaAuhE/ARv4sRLEwdwqgJr/8g79LQXJFvKCLlkSJ84BPbCSM9IZ2U5IxdQg7NKuNF/xnaLqcy4wlCm1HtMzd09xyz+Y+IyC/1IioZmr+JRgcEN+Qk2ZxglTWB+8vSVjXRzQpgIbHuVYxqHUDg1UUlYNBM+pRj+6NM6K1XWrBJMwA/0HqDz0UdtgBsRYVykTsNaGq7Jf4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199024)(186009)(1800799009)(66556008)(66946007)(66446008)(66476007)(316002)(2906002)(54906003)(76116006)(64756008)(86362001)(6916009)(33656002)(55016003)(52536014)(5660300002)(8936002)(8676002)(4326008)(41300700001)(9686003)(38100700002)(38070700005)(83380400001)(26005)(478600001)(122000001)(7696005)(6506007)(71200400001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUxFYm9oZnJQOERab2ptcE5hMGdxU0hiY0l3RlRxSXlJRTFXcjVDRHZEQnhj?=
 =?utf-8?B?M3kxSEhaYTZiRUhoZWNiaTZVN3UybDdVRkJTYmlhUGN4UGVzUzNhY0dlL3l6?=
 =?utf-8?B?V3NJcXV0NnhFR0ZsSGVkTUpBM3BpaUNieFBBemJSa1pCQUdsZ3ladzR2NTRW?=
 =?utf-8?B?alhhaW1EQzY4RUxvdzZXcFViV0s0bFUvTTd2a0Q5SDVqMTdOakt5V3JaeEds?=
 =?utf-8?B?SWFtME5SL3JFM291cWMyMFpLUjZwVHNQWlpZdXN5YVAxT29kUm03ZjlPL2Na?=
 =?utf-8?B?ZkZOWnE1WmRFK2UxaHZBaHBxc1ZyOWJ2UC82cDZvQTBxb1k3SG9VZFY5TFFq?=
 =?utf-8?B?N1JwVGpCeXJtOE9BZ1pUTmxIbjlSeSt0ejVGM0tPMml5RGJxSVZtZThSazN6?=
 =?utf-8?B?Vmc4NnI4MmFPUGloQmdnUUZhNmMvd3Y1YWtLYm1tZ2tkWDk5L0hJMEw0ZHJO?=
 =?utf-8?B?ZGJpN2lvL01zb242OUw2KzhqaCtrOVlNeS9HelpZSDlvZHdoeVRnTGN4NitW?=
 =?utf-8?B?YXpmMUc1TDZYS1BuSnJFN3dONmxyaWVFbVpxdXUwSlBhTVlhVVRESTd1aTVK?=
 =?utf-8?B?aXpCcjZhZDdWWnQycDBZeXJsWjhpM1JmSlZ5WlMyUmRrM00wd1BjS0ZwUGNU?=
 =?utf-8?B?Y0VKSUVxVVROZmlvNEh4VlpWcWhhaEZpSjlYb3JaemRyajZ6eG4wYzlxWVJN?=
 =?utf-8?B?K3JUbEY2clVKcHhGN214MldMZzF1VElWSmhIb3RGOUJlQXQ3cXJjcU5iTjZQ?=
 =?utf-8?B?RkJPTk5nYWVzb3owcU9HakdJdGdWVDVncGpsYW9zV2lOMlBpbDNTYUtXNElR?=
 =?utf-8?B?V0U2MGlPaTZCTGdJM3RNWUdsQ3U4YTZzSURNMUtZRTZuYkV3MlFJbzh2NW9R?=
 =?utf-8?B?RXJTN3dOTHlBUVVNcDEybTVMd0xpOGpCSzJkbzF3cE1hTCt2aVJIU0pVV3kw?=
 =?utf-8?B?eXBhTlZDOERvUFBwVGFycUV3QVhMVFlDT2VjbUtGUmN0Ty8yZnlZelJzMEhR?=
 =?utf-8?B?cWRnK01vVUh6RHhaa2VVTU1LNEVTeVROMmV4Z0VPR3M3TEF1akZiSnNBb3BR?=
 =?utf-8?B?L2pidWVNeDdUVlNWeDVhVnpKcEdEbXZPdEs2U00zbHhsTkNHckhCVjFMZEN6?=
 =?utf-8?B?a1JMS00rNyt0RlJyOGZGWld6OXZBMTVaVnZKSTlsNUtDd0VyeElPU2x2UWY5?=
 =?utf-8?B?RDdoaWRudHpVMkIwUzVQNjVMeHNNQk9sSmxpZmJlOTIyVWYwZURiVXpBN1JQ?=
 =?utf-8?B?NmN1NTlHcjg2OVZJeG55ZUJVNEJIbURvVVFFKzA1U1k1NlRJU2hUTHpkZ2pi?=
 =?utf-8?B?OVpKTTk0MTUvbU80MEltanZNT3h4L2kyU0ZiWmhTT2duNHlRU1RBVEV2MWJL?=
 =?utf-8?B?M0puRUxRa0lKSGlLNkNpU0V5WjMyenhOdDBvcW5XL2ZDS3lyY3RRRjBEQmZT?=
 =?utf-8?B?UDg0Mm5BS3VGR0lUQmZoMktaZ0pxSmZFRUV5NzBGK1NOMWFLRVNWdER4alVv?=
 =?utf-8?B?UWp6TU91TTdqNDZwNnd0amhZL01pM2VhV3lMNFhtdFFIZ3p5MUpzNEdKdmJ2?=
 =?utf-8?B?Z2xTMWhRRGFjaTZTM05RaHRteWxHYmx6alBwa09YMXo2S0tCc3BFcVdaNEw5?=
 =?utf-8?B?Wnd1RDdFa0hCbHVtUDlvMGRRMWhkRmNPT1hiUFE2RmtDck04QUd3ZWVoRFdH?=
 =?utf-8?B?Y0JsYlFmM3FrVkRYYzhmQ0FyWnBIa2pxTU1WVmFta25ha0FRRHlmbm1pNDBp?=
 =?utf-8?B?Q00wNVVBMDdQaE1VVG9haFdJMXV6L3MvcVVMbGZTYU9Ta0VrdjZmbzFEcGRR?=
 =?utf-8?B?eU5HNGx5TXZtcW1wRUFON21PYm1BL0xFN3ZXUGc1SnpTaUo4M3RZUUE5WTg0?=
 =?utf-8?B?K3U1WFdZL1VwSy95SlRKc0I5MStCMTJYbGozSTFHSDBlTVlHZUNINzR4RTdy?=
 =?utf-8?B?TnBLM1IzM2ZSR2pLSXFrajFBdEVad3YxTlQwdW9ncyt3MVdDYUx5MElocCty?=
 =?utf-8?B?RFlKajVYNnJsSXVPcnVTOHAwU0FzbFArVHRteGRiaHhueEMrT2pqbGQrY0Rz?=
 =?utf-8?B?ditTb3R1bzZPbzlpQ0hHYStQYkpXL0NkOHRkV2c1M3Vkb0dWMWg2eTlJMFJB?=
 =?utf-8?Q?B+Iw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e72e29-f7be-4b4f-cf8e-08dbace580eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 01:23:11.3371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8nlNaXD6cOv9Fs3SuV+oXhR+htbEbGHMmkNGRtLAFI8dYNWSGF2EwqE2ZK5sPUw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkFjdHVhbGx5LCB3aXRoIG15IG9y
aWdpbmFsIGRlc2lnbiwgdGhlcmUgaW5kZWVkIGNhbWUgd2l0aCBhbiAncicgb3B0aW9uIHN1cHBv
cnQuDQpCdXQgSSBmb3VuZCB0aGF0IGJyaW5ncyBzb21lIGNvbmZ1c2lvbi4gU2luY2UgcGVyIGN1
cnJlbnQgJ3InIG9wdGlvbiBkZXNpZ24sIGl0IHdpbGwNCnJlc2V0IGFsbCBhdHRyaWJ1dGVzIGJh
Y2sgdG8gb3JpZ2luYWwgc3RhdGVzLiBUaHVzIEkgZHJvcHBlZCBpdC4NCg0KSWYgdG8gc3VwcG9y
dCAncicgb3B0aW9uIHBlciBhdHRyaWJ1dGUsIHNvbWUgcmVkZXNpZ25zIHRvIGN1cnJlbnQgbG9n
aWNzIHdpbGwgYmUgbmVlZGVkDQp0byBzdXBwb3J0IGJvdGggbGVnYWN5IGFuZCB0aGUgbmV3IE9E
IGludGVyZmFjZXMuIFRoYXQgd2lsbCBuZWVkIHNvbWUgZXh0cmEgZWZmb3J0cy4NCk1heWJlIHdl
IGNhbiBwdXQgdGhhdCBvbiBvdXIgVE9ETyBsaXN0Pw0KDQpFdmFuDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29t
Pg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAxLCAyMDIzIDE6MjYgQU0NCj4gVG86IFF1YW4s
IEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtWMyAwLzddIEEgbmV3IHNldCBvZiBMaW51eCBPRCBpbnRlcmZhY2Vz
DQo+DQo+IEZvciBjb25zaXN0ZW5jeSB3aXRoIHRoZSBvdGhlciBPRCBpbnRlcmZhY2UsIHdlJ2Qg
cHJvYmFibHkgd2FudCBhbiAiciINCj4gb3B0aW9uIHRvIHJlc2V0IGVhY2ggYXR0cmlidXRlIHRv
IHRoZSBkZWZhdWx0IHN0YXRlIGFnYWluLg0KPg0KPiBBbGV4DQo+DQo+IE9uIFdlZCwgQXVnIDMw
LCAyMDIzIGF0IDk6MzPigK9BTSBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4N
Cj4gd3JvdGU6DQo+ID4NCj4gPiBTZXJpZXMgaXM6DQo+ID4gUmV2aWV3ZWQtYnk6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPg0KPiA+IE9uIFdlZCwgQXVnIDMw
LCAyMDIzIGF0IDI6MzXigK9BTSBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KPiB3cm90
ZToNCj4gPiA+DQo+ID4gPiBUaGUgZXhpc3RpbmcgT0QgaW50ZXJmYWNlIGBwcF9vZF9jbGtfdm9s
dGFnZWAgaXMgdW5hYmxlIHRvIG1lZXQgdGhlDQo+ID4gPiBncm93aW5nIGRlbWFuZHMgZm9yIG1v
cmUgT0QgZnVuY3Rpb25hbGl0aWVzLiBTaW5jZSB0aGUgYnVmIHVzZWQNCj4gPiA+IHdpdGhpbiBp
dCBjb21lcyB3aXRoIHNpemUgbGltaXQgYXMgb25lIHBhZ2UuIFdpdGggbW9yZSBPRA0KPiA+ID4g
ZnVuY3Rpb25hbGl0aWVzIGFkZGVkLCB3ZSB3aWxsIGhpdCB0aGF0IGxpbWl0IHNvb24uDQo+ID4g
Pg0KPiA+ID4gVG8gYmV0dGVyIG1lZXQgdGhlIGdyb3dpbmcgZGVtYWluZHMsIGEgbmV3IHNldCBv
ZiBPRCBpbnRlcmZhY2VzIGFyZQ0KPiBkZXNpZ25lZC4NCj4gPiA+IFdpdGggdGhpcyBuZXcgZGVz
aWduLCB0aGVyZSB3aWxsIGJlIG11bHRpcGxlIGludGVyZmFjZXMgZXhwb3NlZCB3aXRoDQo+ID4g
PiBlYWNoIHJlcHJlc2VudGluZyBhIHNpbmdsZSBPRCBmdW5jdGlvbmFsaXR5LiBBbmQgYWxsIHRo
b3NlDQo+ID4gPiBpbnRlcmZhY2VzIHdpbGwgYmUgYXJyYW5nZWQgaW4gYSB0cmVlIGxpa2VkIGhp
ZXJhcmNoeSBhcyBiZWxvdy4NCj4gPiA+IE1lYW53aGlsZSBhbGwgZnVuY3Rpb25hbGl0aWVzIGZv
ciB0aGUgc2FtZSBjb21wb25lbnQgd2lsbCBiZSBhcnJhbmdlZA0KPiB1bmRlciB0aGUgc2FtZSBk
aXJlY3RvcnkuDQo+ID4gPg0KPiA+ID4gZ3B1X29kLw0KPiA+ID4g4pSc4pSA4pSAIGZhbl9jdHJs
DQo+ID4gPiDilIIgICDilJzilIDilIAgYWNvdXN0aWNfbGltaXRfcnBtX3RocmVzaG9sZA0KPiA+
ID4g4pSCICAg4pSc4pSA4pSAIGFjb3VzdGljX3RhcmdldF9ycG1fdGhyZXNob2xkDQo+ID4gPiDi
lIIgICDilJzilIDilIAgZmFuX2N1cnZlDQo+ID4gPiDilIIgICDilJzilIDilIAgZmFuX21pbmlt
dW1fcHdtDQo+ID4gPiDilIIgICDilJzilIDilIAgZmFuX3RhcmdldF90ZW1wZXJhdHVyZQ0KPiA+
ID4NCj4gPiA+IEV2YW4gUXVhbiAoNyk6DQo+ID4gPiAgIGRybS9hbWQvcG06IGludHJvZHVjZSBh
IG5ldyBzZXQgb2YgT0QgaW50ZXJmYWNlcw0KPiA+ID4gICBkcm0vYW1kZ3B1OiByZXZpc2UgdGhl
IGRldmljZSBpbml0aWFsaXphdGlvbiBzZXF1ZW5jZXMNCj4gPiA+ICAgZHJtL2FtZC9wbTogYWRk
IGZhbiB0ZW1wZXJhdHVyZS9wd20gY3VydmUgT0Qgc2V0dGluZyBzdXBwb3J0IGZvcg0KPiBTTVUx
Mw0KPiA+ID4gICBkcm0vYW1kL3BtOiBhZGQgZmFuIGFjb3VzdGljIGxpbWl0IE9EIHNldHRpbmcg
c3VwcG9ydCBmb3IgU01VMTMNCj4gPiA+ICAgZHJtL2FtZC9wbTogYWRkIGZhbiBhY291c3RpYyB0
YXJnZXQgT0Qgc2V0dGluZyBzdXBwb3J0IGZvciBTTVUxMw0KPiA+ID4gICBkcm0vYW1kL3BtOiBh
ZGQgZmFuIHRhcmdldCB0ZW1wZXJhdHVyZSBPRCBzZXR0aW5nIHN1cHBvcnQgZm9yIFNNVTEzDQo+
ID4gPiAgIGRybS9hbWQvcG06IGFkZCBmYW4gbWluaW11bSBwd20gT0Qgc2V0dGluZyBzdXBwb3J0
IGZvciBTTVUxMw0KPiA+ID4NCj4gPiA+ICBEb2N1bWVudGF0aW9uL2dwdS9hbWRncHUvdGhlcm1h
bC5yc3QgICAgICAgICAgfCAgMzAgKw0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYyAgICB8ICAzOSArLQ0KPiA+ID4gIC4uLi9ncHUvZHJtL2FtZC9pbmNs
dWRlL2tnZF9wcF9pbnRlcmZhY2UuaCAgICB8ICAxMiArLQ0KPiA+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vYW1kZ3B1X3BtLmMgICAgICAgICAgICB8IDczMA0KPiArKysrKysrKysrKysrKysr
Ky0NCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfZHBtLmggICAgICAg
fCAgMTQgKw0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5j
ICAgICB8ICAxMCArDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvc211
X3R5cGVzLmggIHwgICA1ICsNCj4gPiA+ICAuLi4vZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVf
djEzXzBfMF9wcHQuYyAgfCAyOTggKysrKysrLQ0KPiA+ID4gLi4uL2RybS9hbWQvcG0vc3dzbXUv
c211MTMvc211X3YxM18wXzdfcHB0LmMgIHwgMjk4ICsrKysrKy0NCj4gPiA+ICA5IGZpbGVzIGNo
YW5nZWQsIDE0MTEgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4g
LS0NCj4gPiA+IDIuMzQuMQ0KPiA+ID4NCg==
