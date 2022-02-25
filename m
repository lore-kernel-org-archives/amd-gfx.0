Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773B3C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 07:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D47410E1DA;
	Fri, 25 Feb 2022 07:33:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD4D510E517
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 07:33:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMEwR0inapZcrljgMBGMW1ePo2Hvu5N7d0Z6fXLCEq7WZlmBkzNbM4rT59+UPFKr/t8j7ckC045jkoK0KP3j355Ggjz9wTlYNTGGlNERtbdQi+WLjzZjfXY1vehZOX5RuS68mRz1I0yRZ9VKZKk2yUGB0XLLPSe+XSpxCZTEnXjMTBuXeF6RqeObXxB23aUpjDPcJGfvM3OHX/Z/6+TDjeqqe8pSv5GlF/yzy9WL/NKvpJp7ti6ug7Q2fK3ipxVjLCy6YlrjbsXqoEehr4ppH/9waHMyonpxlagn85Ka8kyNrloT13LJDGcnECKELMkchmFc0rS+4ijzj/A6h9YH3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCnxzY3jHJFHSdj6OmKNPmbYqATJdTI+erBpLQrc2zY=;
 b=hvGp/og+eKNbHnjaabcOu7casgZQ9hdjk9kYDHpAh6Ke7ZHLAPH9poxGjLCfaQWPLFmweaGoM/7DCyIvYY83dyS1HVQeqrtP8LUtmYi4yFtQEWxJvoWUwkX2YGbAa8i5ij9VybY5wVTcW4oBm6xBrdgy+tRoM8zse5y5o3FBY/l4G2LCOySD0RFOV1FmbgtRPcRk92+V+7vYSWi/VL4jFdFlavWHJ/2+W7um2FUgQOB2d4DBt3uZDFgjailDIZLDLvY2flWrgcDZg3N8XCBYWzPnOjvrUNvHDN2mz3P/B3xQRoIVynNYN39B6kazLinVWmRh31pWZ+pNTB3uiY21qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCnxzY3jHJFHSdj6OmKNPmbYqATJdTI+erBpLQrc2zY=;
 b=sVckDmsDVjjb/WFK7vH/qa6BN9ep8RCZHgvD7QDT9If/aoQBlQLi4XTNvecJjRggwsT4sMd1UapDlt4ODH0l8lsGzC+i0wFYk81k/nnXHWKVgnkwtaOIpoWO18BEej+qBUk34ypAtAYRxKGG1Clyl006v0TelkMR4eo0DLkMv+I=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 25 Feb
 2022 07:32:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::7d61:f517:f3f8:9ea]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::7d61:f517:f3f8:9ea%5]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 07:32:58 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
Thread-Topic: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
Thread-Index: AQHYKf9K+ofRHyEfkUKWe1QTzunzDKyjvH1QgAAFmICAAAH9oIAAAo+AgAAWZMA=
Date: Fri, 25 Feb 2022 07:32:58 +0000
Message-ID: <DM6PR12MB2619810DBC53C6430A03535FE43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220225042156.676421-1-lijo.lazar@amd.com>
 <DM6PR12MB2619202956D5AF431734D5C8E43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <BYAPR12MB4614577C233FED50C0EFC80C973E9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <DM6PR12MB26192A826B2B5DF65ED8ED5CE43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <2bb4e178-b224-ff6a-e730-47ab780e44ca@amd.com>
In-Reply-To: <2bb4e178-b224-ff6a-e730-47ab780e44ca@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-25T07:32:55Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c420c8df-6945-4e84-8871-3222e48dbaad;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-25T07:32:55Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: f24faf9f-80bc-4b51-be8f-f66f447d59b3
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 598281e0-a673-4bad-a797-08d9f8310c09
x-ms-traffictypediagnostic: MW4PR12MB5601:EE_
x-microsoft-antispam-prvs: <MW4PR12MB5601F2DA9D221BEB204DFE7BE43E9@MW4PR12MB5601.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WWPnE9+I3h6lSeDQL7fOZNCoBGt572ldlFAANHQMuigmAbLF4HcTRkqQopIOC+v0Amq5aX0TzroapN2r2837HS4cfZ6/ZoLsK9jfZc+kDUXbYebtVvG7TADmlFsUKqZAlfpPDwzSug1C2NtUoin0d9mMGrOPCiSyNQqjabPHyrKyzpFYCSUHo+A3D9xxSNnBOpMtKcbG8WY8xpb3fTkU0l7GMFSv3rpEGEsHeXjHvEe9YHRu7eSXkGzVds/PnBNVn2bP7Av27m7egP7RWFkjFHiKoU5neDTXDH+sqCWUrF2pnGUFojXVxJU7JOlO6UF70vSOfBekhZeriqoBoZuqc5RIbfSyNzgJvh/MPUeSk9ddvlOjjklFm2HipD4CKqPohEk5mgw3RMyoNp5UGPjUBzQcOxGxOdeEnxkYVi0fIJ8hgdQPV18gOIJh0iCMC9s79UAyOQ0IG3HD7cfAHhl3Ut8RPv/Z7gMDLAqMDD18jqs0QUKLiniZ0dkiMliCPwQ/ljmJwDSvrMxEtQEfCqwa/ieFo3DhuZV4n/hYHEw9Paz23EjcMPlfm9pfpExea9y+hL4ZcRg/w1bpaVpuq7x6D0aPlU8iXxPPcusgKWlkPhRhh7cO6vcObFSgazP0s2MAI13/JWG1AEZiVSWob7X8DvA7sZdi5SrYOr2t5+w5kVc49RgcvCtekCRnkg9qmt/fMhz3qlp0K+WFARioZRoaNg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(66476007)(122000001)(8676002)(66556008)(38100700002)(4326008)(83380400001)(8936002)(76116006)(5660300002)(52536014)(66446008)(55016003)(508600001)(53546011)(66946007)(71200400001)(33656002)(2906002)(316002)(86362001)(7696005)(6506007)(9686003)(26005)(186003)(38070700005)(15650500001)(54906003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmFjYmQ1UFd1bHJ6S1pUeVdDRXppS2VOVG94b1g2VjA5SEtiMnZtQUxWK0Y3?=
 =?utf-8?B?bTBFQWxVeXpwOVZydFRmcVJuQ0poY2R3Y2lmMktGMlFGb2pnbTJMTGVPU1Jn?=
 =?utf-8?B?ZGdhTDlYYzQ3QldUOE5OcEcwaFVNZVhCajFQR0xWSDFLRVNGNlNWL2lTSFNB?=
 =?utf-8?B?SEFsMjlKYnl0cFhyV3VOb1N1bkRONFBnMC92bDN3dDZlTXNvNlNPSUVNZC9s?=
 =?utf-8?B?MVRmdStTdFV0ZkZkbXV1bU9sYnhqbHFYUlhiTDIrbTY5Rk9xL2pQQXZTVzNz?=
 =?utf-8?B?UUVDYlFnQWlVYmp5enVwNzdmTEg5VmRGeFBmYi81NTRMdWpnaldUUEhsSEps?=
 =?utf-8?B?cnk3VU5MQ2htQlRqRW5vQTlvRy84UXQ1akdZYzAySnVQZFM4UkthYUpUdkRa?=
 =?utf-8?B?Yi9CcjMyV2J4UnFzVDdMSzZ1czJVWTlHSzE4TW80SHp2NUlTb05TbkJwVzlR?=
 =?utf-8?B?N0V4aDJvM0Q1QmYxemlSMlMwaGk5Z2NlZU4wbktaait0SEdRc3N0U1dNSVM0?=
 =?utf-8?B?MlFqOU94TzQ5emRjU2J3NjFQUktJSitmenY5aUQvSGovYjBLNmtabi9YMEw0?=
 =?utf-8?B?MjVqQWpUNHhSUWxZdC9Oa28rNEkzS2lIbW9qNkYzVEEya25TZVRhL0c0cmRI?=
 =?utf-8?B?a3pGNU1sdmJ4Q2xjM2pidE9iNWdqK0FCY2tsRFVhNmNNSS9mL3V5T3NoaWwz?=
 =?utf-8?B?SHZCL3FLa214WkovVlJ6aS92RGxOWFUvbHNvckExWndPVksyUFBhSVpIZDNy?=
 =?utf-8?B?OHhObDAxS3hsZHo0WEdxTHpIcVVpNTM1cGpydDVxT2dPVXI5b2s2eTRDSFpE?=
 =?utf-8?B?RzQvcmFvUHNTSVJyRkh4VlMrMWxYZGltcWJZNG5vL29pMWxqbCs4RXRuMU5G?=
 =?utf-8?B?RCswUzcwNk1FR0daakRGenlveHZKZ3RoVHQ4TzUrWGdoSTBrQVk4TWJFQjRO?=
 =?utf-8?B?MUVwUzJhNWYvYStRajNLK0FGdVR4UWk4Q091eWR6SjJhdXlnSUxManhvRjVT?=
 =?utf-8?B?WGU2RnhBTG9ZQVBpajZGZFVOWWhjVHJzR2RCT1lSVEVRbTlscTVaelQvR2l6?=
 =?utf-8?B?Q053aFUzS1lyVmloVXhiMVRVYndFenRMMjAxTXh4T1VaNVc0LzBRTFB5Y3Yy?=
 =?utf-8?B?NEpMU3JYb1ZQQ3UxenhqbWo1MFNTblBkbXAyUkhQN2J6QStGRlZsTXRVVm43?=
 =?utf-8?B?djd3aXA2ZzJFTVpPU09MMDJHTnZvZjJYTHkvNnJxSFdjYmhYYkRad3BBZEF4?=
 =?utf-8?B?NnhBYU56M01wWnlrQXBIZDJUdzEwRm95dkVGR2g1T0MvMjJXRlRPS011V0hl?=
 =?utf-8?B?Y09uSENYTTVlbEU4UEhlbkdlYlIrdGl1Z1BSaGJZN0RneW1HKzRuZ0ptdTBO?=
 =?utf-8?B?TE9qMmVUeHR1SUJzNDdPZGZ6MVpZQVdKZkZTcFlndzBJTm9veUE2Y1c1b1JJ?=
 =?utf-8?B?c0Z4bGIzcTllWm9PazM5d2dSNjFIYzRLeC9PRHBQcENDSm5EVUFqM2k3cFFD?=
 =?utf-8?B?R3BsTXFwTGp2MlRXdlJlaFhIWnYvc2FlV0xZVitidmpPRkdGVkY1OG5HVGZl?=
 =?utf-8?B?S3NtbUZHcmEwdU8zM210ejZjc2xrUnRnUEt5ejI0azA4UzFlUFBXWFhCL2Zu?=
 =?utf-8?B?T3BrSkpoWEtyU1VqRXVTSjFFRGY1cjJ5QnlaMXBIOWwrSzZsTHVsbXZERlBz?=
 =?utf-8?B?a2ZVNVNxMjN3VnkwYVVseHM1WS94L2Q1SjlmYnMvRXRtam0wblQyVWhIdXVC?=
 =?utf-8?B?NkY4b0kxNGZrTENIL1NOekRiOVBzS2hEcmpTMUt2bUQydGJ1TE10UUxOQklQ?=
 =?utf-8?B?NnpXWVZ3YjRnYThpaXdIV3NrWTdtYXY4MGIvMGhobXE5dnRyVUM5dEpyU0FE?=
 =?utf-8?B?WWVGQ1BHVDZZTVVaNklIVFpUNU9hbDNoaURoc3ZUWTFCZnFDbGl4UC96bXFr?=
 =?utf-8?B?SlVyaGlKSXpjOEVXUUJkWlVucnV4Y1NLVUZxSmdEelNMWU1GN1cva3U2NXdv?=
 =?utf-8?B?dHJHckhOdWZ4KzhjbFBwVTlBRllNWlpva1RCdUN2anQ5Tk0vR21hd1ZETHZC?=
 =?utf-8?B?elNML0EvYW43MlRybjREZm9YaXRvWGllMGJyNkZ6ZExRQm5aZGwyM0tZWG9z?=
 =?utf-8?Q?lbg4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598281e0-a673-4bad-a797-08d9f8310c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 07:32:58.7274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wPam9ZSNDHibBGCmLx9t9+7bKlUxbRhY93o8MOuJecZAJojvPXgwjEfHwV7LAkt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogRnJp
ZGF5LCBGZWJydWFyeSAyNSwgMjAyMiAyOjAzIFBNDQo+IFRvOiBRdWFuLCBFdmFuIDxFdmFuLlF1
YW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBaaGFuZywg
SGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgV2FuZywgWWFuZyhLZXZpbikNCj4gPEtldmluWWFu
Zy5XYW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvcG06IFNlbmQg
bWVzc2FnZSB3aGVuIHJlc3Agc3RhdHVzIGlzIDB4RkMNCj4gDQo+IA0KPiANCj4gT24gMi8yNS8y
MDIyIDExOjI1IEFNLCBRdWFuLCBFdmFuIHdyb3RlOg0KPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9u
bHldDQo+ID4NCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+
IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+ID4+IFNlbnQ6IEZyaWRh
eSwgRmVicnVhcnkgMjUsIDIwMjIgMTo0NyBQTQ0KPiA+PiBUbzogUXVhbiwgRXZhbiA8RXZhbi5R
dWFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+PiBDYzogWmhh
bmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0K
PiA+PiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFdhbmcsIFlhbmcoS2V2aW4pDQo+ID4+
IDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPg0KPiA+PiBTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0v
YW1kL3BtOiBTZW5kIG1lc3NhZ2Ugd2hlbiByZXNwIHN0YXR1cyBpcw0KPiA+PiAweEZDDQo+ID4+
DQo+ID4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHldDQo+ID4+DQo+ID4+PiBUaGF0IGlzIHRoZSBj
YWxsZXIgY2FuIHBlcmZvcm0gc29tZXRoaW5nIGxpa2UgaXNzdWluZyB0aGUgc2FtZQ0KPiA+Pj4g
bWVzc2FnZSBhZ2FpbiB3aXRob3V0IHByZXJlcXVpc2l0ZXMgY2hlY2sgb24gUE1GVyBidXN5DQo+
ID4+DQo+ID4+IFRoaXMgcGF0Y2ggZXhwZWN0cyB0aGlzIG1ldGhvZC4gQ2FsbGVyIG1heSB0cnkg
dG8gcmVzZW5kIG1lc3NhZ2UNCj4gPj4gYWdhaW4uIEFzIHBhcnQgb2YgbWVzc2FnZSBzZW5kaW5n
LCBkcml2ZXIgZmlyc3QgY2hlY2tzIHJlc3BvbnNlDQo+ID4+IHJlZ2lzdGVyLiBDdXJyZW50IGxv
Z2ljIGJsb2NrcyBzZW5kaW5nIGFueSBtZXNzYWdlIGlmIGl0IHNlZXMgMHhGQyBpbg0KPiA+PiBy
ZXNwb25zZSByZWdpc3RlciwgdGhpcyBwYXRjaCBpcyB0byBhZGRyZXNzIHRoYXQuDQo+ID4gW1F1
YW4sIEV2YW5dIFllcywgSSBrbm93LiBCdXQgdGhlIGNhbGxlciBoZXJlIGNvdWxkIGJlIGFub3Ro
ZXIgb25lLiBJIG1lYW4NCj4gdGhlcmUgbWF5IGJlIGFub3RoZXIgY2FsbGVyIHN0ZXBwZWQgaW4u
DQo+ID4NCj4gDQo+IFRoYXQgc2hvdWxkbid0IGNhdXNlIGFuIGlzc3VlIHRvIHRoZSBzZWNvbmQg
Y2FsbGVyIGlmIGl0IGdvdCBtZXNzYWdlIG11dGV4Lg0KPiBUaGUgc2Vjb25kIGNhbGxlciBhbHNv
IHNob3VsZCBiZSBhYmxlIHRvIHNlbmQgbWVzc2FnZSBpZiBQTUZXIGdvdCBmcmVlIGJ5DQo+IHRo
YXQgdGltZS4gVGhlIGZpcnN0IGNhbGxlciBjYW4gcmV0cnkgd2hlbiBpdCBnZXRzIGJhY2sgdGhl
IG1lc3NhZ2UgbXV0ZXguIEZXDQo+IGRvZXNuJ3QgbWFpbnRhaW4gYW55IHN0YXRlIGZvciAweEZD
IHJlc3BvbnNlLiBBbnkgb3RoZXIgbWVzc2FnZSBtYXkgYmUNCj4gc2VudCBhZnRlciB0aGF0LiBJ
ZiBkcml2ZXIga2VlcHMgdGhlIHN0YXRlIGJhc2VkIG9uIHR3byBjYWxsZXJzLCB0aGF0IGlzIGEg
bG9naWMNCj4gcHJvYmxlbSBpbiBkcml2ZXIuIEkgZG9uJ3QgdGhpbmsgd2UgaGF2ZSBhbnkgZmxv
dyBsaWtlIHRoYXQuDQpbUXVhbiwgRXZhbl0gWWVhaCwgYnV0IHRoZXJlIG1heSBiZSBzb21lIGNh
c2UgdGhhdCBtZXNzYWdlcyBpc3N1ZWQgYnkgdGhlIHR3byBjYWxsZXJzIGhhdmUgZGVwZW5kZW5j
ZS4NClRoYXQgbWVhbnMgdGhlIG1lc3NhZ2UgaXNzdWVkIGJ5IHRoZSAybmQgY2FsbGVyIHNob3Vs
ZCBiZSBvbmx5IGFmdGVyIHRoZSAxc3Qgb25lLg0KVGhlIG9uZSBpIGNhbiB0aGluayBvZiBpcyAi
RW5hYmxlQWxsU211RmVhdHVyZXMiIG1lc3NhZ2Ugc2hvdWxkIGJlIGFmdGVyICJTZXRBbGxvd2Vk
RmVhdHVyZXMiIG1lc3NhZ2UuDQpBbHRob3VnaCB0aGF0IHNob3VsZCBub3QgY2F1c2UgYW55IHBy
b2JsZW0sIEknbSBub3Qgc3VyZSB3aGV0aGVyIHRoZXJlIGlzIG90aGVyIHNpbWlsYXIgY2FzZS4N
Cg0KV2hhdCBJIHN1Z2dlc3QgaXMgc29tZXRoaW5nIGxpa2UgYmVsb3cuIFdlIGp1c3QgZG8gaXQg
YWdhaW4gaW4gc211X2Ntbl9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbSgpIG9uIFBNRlcgYnVzeS4N
Cg0KaW50IHNtdV9jbW5fc2VuZF9zbWNfbXNnX3dpdGhfcGFyYW0oc3RydWN0IHNtdV9jb250ZXh0
ICpzbXUsDQoJCQkJICAgIGVudW0gc211X21lc3NhZ2VfdHlwZSBtc2csDQoJCQkJICAgIHVpbnQz
Ml90IHBhcmFtLA0KCQkJCSAgICB1aW50MzJfdCAqcmVhZF9hcmcpDQp7DQouLi4NCi4uLg0KCW11
dGV4X2xvY2soJnNtdS0+bWVzc2FnZV9sb2NrKTsNCglyZWcgPSBfX3NtdV9jbW5fcG9sbF9zdGF0
KHNtdSk7DQoJcmVzID0gX19zbXVfY21uX3JlZzJlcnJubyhzbXUsIHJlZyk7DQoJaWYgKHJlZyA9
PSBTTVVfUkVTUF9OT05FIHx8DQoJICAgIHJlZyA9PSBTTVVfUkVTUF9CVVNZX09USEVSIHx8DQoJ
ICAgIHJlcyA9PSAtRVJFTU9URUlPKSB7DQoJCV9fc211X2Ntbl9yZWdfcHJpbnRfZXJyb3Ioc211
LCByZWcsIGluZGV4LCBwYXJhbSwgbXNnKTsNCgkJZ290byBPdXQ7DQoJfQ0KK3JldHJ5Og0KCV9f
c211X2Ntbl9zZW5kX21zZyhzbXUsICh1aW50MTZfdCkgaW5kZXgsIHBhcmFtKTsNCglyZWcgPSBf
X3NtdV9jbW5fcG9sbF9zdGF0KHNtdSk7DQoJcmVzID0gX19zbXVfY21uX3JlZzJlcnJubyhzbXUs
IHJlZyk7DQorCWlmIChyZWcgPT0gU01VX1JFU1BfQlVTWV9PVEhFUikgew0KKwkJbWRlbGF5KDEp
Ow0KKwkJZ290byByZXRyeTsNCisJfQ0KLi4uDQouLi4NCn0NCg0KQlINCkV2YW4NCj4gDQo+IEJh
c2ljYWxseSwgMHhGQyBpcyBub3QgdmFsaWQgcHJlLWNvbmRpdGlvbiBjaGVjayBmb3Igc2VuZGlu
ZyBhbnkgbWVzc2FnZS4gQXMNCj4gcGVyIFBNRlcgdGVhbSAtIGl0IG9ubHkgbWVhbnMgdGhhdCBQ
TUZXIHdhcyBidXN5IHdoZW4gYSBwcmV2aW91cw0KPiBtZXNzYWdlIHdhcyBzZW50IGFuZCBQTUZX
IHdvbid0IGNoYW5nZSB0aGUgcmVzcG9uc2Ugc3RhdHVzIHdoZW4gaXQNCj4gYmVjb21lcyBmcmVl
Lg0KPiANCj4gVGhhbmtzLA0KPiBMaWpvDQo+IA0KPiA+IEJSDQo+ID4gRXZhbg0KPiA+Pg0KPiA+
PiBUaGFua3MsDQo+ID4+IExpam8NCj4gPj4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPj4gRnJvbTogUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+DQo+ID4+IFNlbnQ6
IEZyaWRheSwgRmVicnVhcnkgMjUsIDIwMjIgMTE6MDcgQU0NCj4gPj4gVG86IExhemFyLCBMaWpv
IDxMaWpvLkxhemFyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+
PiBDYzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IERldWNoZXIsIEFs
ZXhhbmRlcg0KPiA+PiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFdhbmcsIFlhbmcoS2V2
aW4pDQo+ID4+IDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPg0KPiA+PiBTdWJqZWN0OiBSRTogW1BB
VENIXSBkcm0vYW1kL3BtOiBTZW5kIG1lc3NhZ2Ugd2hlbiByZXNwIHN0YXR1cyBpcw0KPiA+PiAw
eEZDDQo+ID4+DQo+ID4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHldDQo+ID4+DQo+ID4+IFRoaXMg
bWF5IGludHJvZHVjZSBzb21lIHByb2JsZW1zIGZvciB0d28gY2FsbGVycyBzY2VuYXJpb3MuIFRo
YXQgaXMNCj4gPj4gdGhlIDJuZCBvbmUgd2lsbCBzdGlsbCBwcm9jZWVkIGV2ZW4gaWYgdGhlIDFz
dCBvbmUgd2FzIGFscmVhZHkgYmxvY2tlZC4NCj4gPj4gTWF5YmUgdGhlIGxvZ2ljcyBoZXJlIHNo
b3VsZCBiZSBwZXJmb3JtZWQgYnkgdGhlIGNhbGxlci4gVGhhdCBpcyB0aGUNCj4gPj4gY2FsbGVy
IGNhbiBwZXJmb3JtIHNvbWV0aGluZyBsaWtlIGlzc3VpbmcgdGhlIHNhbWUgbWVzc2FnZSBhZ2Fp
bg0KPiA+PiB3aXRob3V0IHByZXJlcXVpc2l0ZXMgY2hlY2sgb24gUE1GVyBidXN5Lg0KPiA+PiBP
ciB3ZSBjYW4ganVzdCB1cGRhdGUgdGhlIHNtdV9jbW5fc2VuZF9zbWNfbXNnIEFQSXMgdG8gZ2l2
ZSBpdA0KPiA+PiBhbm90aGVyIHRyeSBvbiBQTUZXIGJ1c3kuDQo+ID4+DQo+ID4+IEJSDQo+ID4+
IEV2YW4NCj4gPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+PiBGcm9tOiBMYXph
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiA+Pj4gU2VudDogRnJpZGF5LCBGZWJydWFy
eSAyNSwgMjAyMiAxMjoyMiBQTQ0KPiA+Pj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+ID4+PiBDYzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IERl
dWNoZXIsIEFsZXhhbmRlcg0KPiA+Pj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBXYW5n
LCBZYW5nKEtldmluKQ0KPiA+Pj4gPEtldmluWWFuZy5XYW5nQGFtZC5jb20+OyBRdWFuLCBFdmFu
IDxFdmFuLlF1YW5AYW1kLmNvbT4NCj4gPj4+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9wbTog
U2VuZCBtZXNzYWdlIHdoZW4gcmVzcCBzdGF0dXMgaXMgMHhGQw0KPiA+Pj4NCj4gPj4+IFdoZW4g
UE1GVyBpcyByZWFsbHkgYnVzeSwgaXQgd2lsbCByZXNwb25kIHdpdGggMHhGQy4gSG93ZXZlciwg
aXQNCj4gPj4+IGRvZXNuJ3QgY2hhbmdlIHRoZSByZXNwb25zZSByZWdpc3RlciBzdGF0ZSB3aGVu
IGl0IGJlY29tZXMgZnJlZS4NCj4gPj4+IERyaXZlciBzaG91bGQgcmV0cnkgYW5kIHByb2NlZWQg
dG8gc2VuZCBtZXNzYWdlIGlmIHRoZSByZXNwb25zZQ0KPiA+Pj4gc3RhdHVzIGlzDQo+ID4+IDB4
RkMuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogTGlqbyBMYXphciA8bGlqby5sYXphckBh
bWQuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211X2Ntbi5jIHwgMiAtLQ0KPiA+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkN
Cj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9z
bXVfY21uLmMNCj4gPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMN
Cj4gPj4+IGluZGV4IDU5MGE2ZWQxMmQ1NC4uOTIxNjFiOWQ4YzFhIDEwMDY0NA0KPiA+Pj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCj4gPj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQo+ID4+PiBAQCAtMjk3LDcgKzI5
Nyw2IEBAIGludCBzbXVfY21uX3NlbmRfbXNnX3dpdGhvdXRfd2FpdGluZyhzdHJ1Y3QNCj4gPj4+
IHNtdV9jb250ZXh0ICpzbXUsDQo+ID4+PiAgIAlyZWcgPSBfX3NtdV9jbW5fcG9sbF9zdGF0KHNt
dSk7DQo+ID4+PiAgIAlyZXMgPSBfX3NtdV9jbW5fcmVnMmVycm5vKHNtdSwgcmVnKTsNCj4gPj4+
ICAgCWlmIChyZWcgPT0gU01VX1JFU1BfTk9ORSB8fA0KPiA+Pj4gLQkgICAgcmVnID09IFNNVV9S
RVNQX0JVU1lfT1RIRVIgfHwNCj4gPj4+ICAgCSAgICByZXMgPT0gLUVSRU1PVEVJTykNCj4gPj4+
ICAgCQlnb3RvIE91dDsNCj4gPj4+ICAgCV9fc211X2Ntbl9zZW5kX21zZyhzbXUsIG1zZ19pbmRl
eCwgcGFyYW0pOyBAQCAtMzkxLDcgKzM5MCw2DQo+ID4+IEBAIGludA0KPiA+Pj4gc211X2Ntbl9z
ZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzdHJ1Y3QNCj4gPj4+IHNtdV9jb250ZXh0ICpzbXUsDQo+
ID4+PiAgIAlyZWcgPSBfX3NtdV9jbW5fcG9sbF9zdGF0KHNtdSk7DQo+ID4+PiAgIAlyZXMgPSBf
X3NtdV9jbW5fcmVnMmVycm5vKHNtdSwgcmVnKTsNCj4gPj4+ICAgCWlmIChyZWcgPT0gU01VX1JF
U1BfTk9ORSB8fA0KPiA+Pj4gLQkgICAgcmVnID09IFNNVV9SRVNQX0JVU1lfT1RIRVIgfHwNCj4g
Pj4+ICAgCSAgICByZXMgPT0gLUVSRU1PVEVJTykgew0KPiA+Pj4gICAJCV9fc211X2Ntbl9yZWdf
cHJpbnRfZXJyb3Ioc211LCByZWcsIGluZGV4LCBwYXJhbSwgbXNnKTsNCj4gPj4+ICAgCQlnb3Rv
IE91dDsNCj4gPj4+IC0tDQo+ID4+PiAyLjI1LjENCg==
