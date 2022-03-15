Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23ECC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 07:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3040310E429;
	Tue, 15 Mar 2022 07:52:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49D9B10E429
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 07:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDtJ2gCnbPimeW6jUk/oMhmY4e8jEieyqylcwddDJv9/SpBMK6mBJzJtBPabsGSTtKwrDlOoczCtJG/LmaBBGP/N/MDjJlKVxnyt9jDjabwO07vtzjdO8sDiemUk2Q1somIeKoQ2PvKZ2YrzXgX/MRNgqnkxhvF1IqJh319jipNxvYNz5Y4o+ykZ5y+6HwisblHoJWLsWKCU9Dqqszqp6K8NO9vExSkZ4v91FW13TVcaK8QpFf3PNuK/CszjuEhf1P7mNVKtmGPOfxQwSe7C+lEPD+cO68pIhrA0RdEGY4p4ZsR/XsleDy5PMS3ngu3GvLoPFVlXCxk0TihfU0RALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FA+eyt1sy6p2Rwh1w5YyEizm0uV2KEi4YR9twAvgMhk=;
 b=F4Ngb5hiRF790QSieN+BIVfq/ttXkiI9hhtdXoruY/kbdv7y2dNnLS1enrBYuo+cM6aUA9qZvXbkuYtcn39JAJrZejY8FSpDFgYa5NEDH5ctiGPS1EF9OdB1EM03Jva5003mRQQqvCtR8WobeGA9/AaN6efTucTQlROCI7dpnrJyc0vN7lq6OJYIFaxu5yLu64jhVIFvzXUwgdnfyK0gYUJmICysRC/iZfJ18HinBCJ8AXrVM1eR2Ww7NRl7elKO547mutGp5xCKqVPVPsIqqmA0epgxOPOMQJ3PHChAmrKX3xqrjevJKiY67AOVuH3AjDF7sWw/ugfYdbT2b3WBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FA+eyt1sy6p2Rwh1w5YyEizm0uV2KEi4YR9twAvgMhk=;
 b=HHE+evBZAPzcNegLNjJwkcOPzaxkVnPpR1mElTEXnsJm64wfDncdyFdHyVBe1iIyJ0xhudEFewU5IhtJknlEKxIuWAgj5Z8s9yZXB483K1bTuytJ7z6v44tJ4xLJJqWO7+U9SuEq38ldXeObczQDr7DG9ZDiVGkg9FLxFVGWEZA=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB3097.namprd12.prod.outlook.com (2603:10b6:5:11d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 07:52:53 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 07:52:52 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
 utcl2
Thread-Topic: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
 utcl2
Thread-Index: AQHYN3Gnmh0rVuZ5PUyC0L/FY4MrH6y+o2OAgAFuEQA=
Date: Tue, 15 Mar 2022 07:52:52 +0000
Message-ID: <DM5PR12MB1770C04DED1C0A8C7EB6DA9CB0109@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220314070326.21828-1-tao.zhou1@amd.com>
 <20220314070326.21828-3-tao.zhou1@amd.com>
 <0480be6a-3bf1-d120-8923-06819d7479bd@amd.com>
In-Reply-To: <0480be6a-3bf1-d120-8923-06819d7479bd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-15T07:42:07Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7ef94c6e-868f-4c49-974b-4844a66b0715;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-15T07:52:49Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: f2842f44-0148-471f-ba28-6b8d98bf9cd9
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4c7fb8a-52a0-4ce5-b39a-08da0658cf0e
x-ms-traffictypediagnostic: DM6PR12MB3097:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3097501F4399C3A58C5EA441B0109@DM6PR12MB3097.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKajo87Ri4n6dLTErWEX5BBz5MMElnrooyzuUpYMx53BwIyB0Kh4g9J4j7zpFDVzcsAXVS+P2frIyO0gnlfO50Fvz+n1TSJW6JYPTKRaowfj1B1uwPBQ/wo1GVfo55Ga/hF3wb2QSf2/iLb7Ty56eIyhTD45Ezj78taUBvv5tffE8bVmqbyj99CtoSBwLImiB3M3LPMzOIaTw0pJvpHcXWz4qNc6+eI0Lfe4YtKCSP0gPJv3SPfx0Ht6SVpmfIHCzRO4OLpQGdr7CDkGq8r7xuMHnW37wwm2pykEhdhbDN2/DLGxzeCvjmK9xQGyiOe9WKWJW7cspcsF2jdPPFUuI5ujNywjnUeGtu19TEotuODTAH3fOIl8enysR10pSJDQziJo1kuxDsJkv9GiFLhybLna1r968BqJmc5mfK1fxNlreltDaHQKEZeNRxWs2r552tyh5htr034ULAb8umO+FKfAiG5cPcRYiCs4mJ/esKGjcXzWqW0sNxUSzFY9xfelksP3H7oLQqtQFBDfbeCBXwAeJ4haC9Q0rRlBnGi5+hijiyuYHXQhDkhInqY7SNEhKq/oaR6aP7Ai7c0IOAepvH2CZU7a11iW94pBHzN8K5c0XkL+2RN2qGKMVM2dcq7X2mXg17cbd+mpQ0tr9yXBxLz2uj0nknbhs0iLAKIphJn43x3UgH/AsINw11fctgdbD75YRUH/B3P1QMJzigk/zw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(52536014)(2906002)(5660300002)(8936002)(26005)(38100700002)(186003)(86362001)(122000001)(83380400001)(110136005)(316002)(6506007)(6636002)(66446008)(53546011)(508600001)(71200400001)(9686003)(7696005)(64756008)(66476007)(66556008)(55016003)(76116006)(66946007)(33656002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUl4cWgrb0I0N05zVG9EWnI0TVhla1hXallwK2NJc3pjS3VJVFZBRFY1UTJL?=
 =?utf-8?B?VXlrakkrb0RtVWdHeGp3RUJJYmNmTE5ZWVI1N0ZJRlFJZk5ENlJSYmcweUVm?=
 =?utf-8?B?R2JXTE8xdmxXL1lFa2hIMG1QYVVOKzZLemRNZ0tsRjZMUUNKYUxPTkQ2Q2NZ?=
 =?utf-8?B?ZzFYTnNJSG9XMlM3bTkvc0ZKUWRpWWJHelJnZEdlaDZKemFiRGttVElJTlFw?=
 =?utf-8?B?N1VnYXFvQXQ1Yi9VcGFXc2FZUklyZzE4UVpGb2VyYW16VlhCcis1alpGemRj?=
 =?utf-8?B?NXNudzdxYnFHdTVzSXZtWHVtSTZSd0tCdVJjMlVXbE1lOW5aY1pyMUVveWVi?=
 =?utf-8?B?S2dsc05tWEk1citpSkZ5TGk4U012MXR4bUZyS01IREtyQkt2RW5FbEhWSE02?=
 =?utf-8?B?WkNmUTVCVURtY3docnFFNFU2V0RxZzRoa29nM0UyL3NCWTZNWUhRVU5ZVVp4?=
 =?utf-8?B?UUIyWVV1c3Z4Z21KUHcrZTd4RUhJd0J3SmpHS1p4VTQ5N0hRMk5pTmhocTZQ?=
 =?utf-8?B?R0xKNGc0cnc1TXMxaEk2dUFRZzBPa2RQbDVkODJUSlNTZzNkU0E5Y3oxMHZ0?=
 =?utf-8?B?UjRZWVF4RnRRTisyT0Q2S2I1SGUyTHFyZUtJSTNrSCtaQUF5R04xd0dnQXdO?=
 =?utf-8?B?djhQSUt1VHc0VkJDNU1KbnN6RlRWZ0puMzZmdkNzaThZbE4yRFpkMFVvQ0pn?=
 =?utf-8?B?Zmp4TkR4NStkV25Lclc1VFhYN1RJVG8vd2laakVxVFZyMUZsV1AxNXAxcHVM?=
 =?utf-8?B?cERsZmRVMG1RMGI0dng3SDJoSzY2dUQyV0Q0Ylg5NHlrV2hrdWxHZXNsYWtz?=
 =?utf-8?B?dWVNN0V5dlZnMXRndzhYcndHL2ZDUWdNSjlWaFVMWFZGdDV4ME0zVjhkSnhw?=
 =?utf-8?B?Q3dQaGFCMlJTcVM3Y0w4bzJoQm5CNWdpREViaCtGOUJVSS9WQWFaRW1ROFYz?=
 =?utf-8?B?elNiUndYNTNKL1pSbHFQTnNwbEZCNktDUXRMRXM0am85bjFJbytoNEQ0OEFJ?=
 =?utf-8?B?S0w4Q3o5SUd5WVVLNUZlUkExbzRtMStjZ095MEZ6QU0rYUgvWVBJRUdtUVpu?=
 =?utf-8?B?eG9BNTVJZjJhZDQrVGphRVZwLythbi9tbFpZcWNPOVl0blNPSUIwck14TjBJ?=
 =?utf-8?B?bXNwYkNIelZCRnloUXlvZkVaY1pZaVk4Q0dNQlFOc0t1bGoxUEtsUmxUYnRN?=
 =?utf-8?B?MEY0S0ltTitvRDIwWjVINjk4bGdDRUNOS2xZOUtNdHhIK3FwNWJDbjB6NzlS?=
 =?utf-8?B?VGxHQTBpSmlSQ1lvaUhmSEtLcTFHY2pDKzZKeStRTVBMODFWZWYrS2ZYQ2xD?=
 =?utf-8?B?Uy9MdklmOERFQUlUM0xiazRZcDJjZVdFRlBTNUZzWXFVUUErR3JGLys3K1A2?=
 =?utf-8?B?c01jZEowZjJxVm5JVXAwMWIzeDRPRDhpdkhwdmIvVEQ2UkQzd1o0MDluWmx4?=
 =?utf-8?B?bDdFaG1NTnJheXpHNjQ1SXdKRkZSVU1tNVR6M2poM0lUQXJzK0FUQk5RNjRm?=
 =?utf-8?B?WHU4ZUY4aUJDczdOa0NhYVErK1Z6OFlBUTdBblhQNlAxWmpRWnpxNUcxY1RD?=
 =?utf-8?B?M2NZVldNSjNnVXZ3YklsdTdkSkZpbFZsMEVtNjV6TVMrVy9CRjBQVEQvbFJj?=
 =?utf-8?B?Y24zckYzdXMzMWxvWHVxOU12RG14M3B2R1VGQXBLZnZ3Q2xibG0zWmJsRXlh?=
 =?utf-8?B?TUlBSFZHL2tnbjJjbFJaVEhJOFlyNEdOeXZsWDNQczFMMHlZUHUwZFQ0RDRh?=
 =?utf-8?B?SmRSN2YwbjlxN20xZzEvWTNpN0gxeCtBR3pUbGxJRndLOGEyOVFxQ1AzY3E4?=
 =?utf-8?B?cDVqc09yaG84T2lDMTVVSTVJeGw5dmpWendiL3VCTE1xU1cxeGdHRW0zWk9n?=
 =?utf-8?B?dDUvY2c5OWJHKytGSlgzZEZSNzJWWnVMZi9EdUx0elJPQUc4SlIzRWFXTWlQ?=
 =?utf-8?Q?YCJ2borDx2veC44AQEITAUqv85sTPja8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c7fb8a-52a0-4ce5-b39a-08da0658cf0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 07:52:52.5520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X8QP/oNyudDMsS+cEpwqicrJO9qX1nHyH6wobsNCuYLcjwHX4JEDEwCjIRlMCdpd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3097
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBNYXJjaCAxNCwgMjAyMiA1OjUyIFBNDQo+IFRvOiBaaG91MSwgVGFvIDxUYW8uWmhvdTFA
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywNCj4gSGF3a2lu
ZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgWWFuZywgU3RhbmxleQ0KPiA8U3RhbmxleS5ZYW5n
QGFtZC5jb20+OyBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMy8zXSBkcm0vYW1ka2ZkOiBhZGQgUkFTIHBvaXNvbiBjb25zdW1wdGlvbiBz
dXBwb3J0IGZvcg0KPiB1dGNsMg0KPiANCj4gDQo+IA0KPiBPbiAzLzE0LzIwMjIgMTI6MzMgUE0s
IFRhbyBaaG91IHdyb3RlOg0KPiA+IERvIFJBUyBwYWdlIHJldGlyZW1lbnQgYW5kIHVzZSBncHUg
cmVzZXQgYXMgZmFsbGJhY2sgaW4gdXRjbDIgZmF1bHQNCj4gPiBoYW5kbGVyLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
ICAgLi4uL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfaW50X3Byb2Nlc3NfdjkuYyAgIHwgMjMgKysr
KysrKysrKysrKysrKy0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2ludF9wcm9jZXNzX3Y5LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9pbnRfcHJvY2Vzc192OS5jDQo+ID4gaW5kZXggZjdkZWYwYmYwNzMwLi4zOTkx
ZjcxZDg2NWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2ludF9wcm9jZXNzX3Y5LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfaW50X3Byb2Nlc3NfdjkuYw0KPiA+IEBAIC05MywxMSArOTMsMTIgQEAgZW51bSBTUV9JTlRF
UlJVUFRfRVJST1JfVFlQRSB7DQo+ID4gICBzdGF0aWMgdm9pZCBldmVudF9pbnRlcnJ1cHRfcG9p
c29uX2NvbnN1bXB0aW9uKHN0cnVjdCBrZmRfZGV2ICpkZXYsDQo+ID4gICAJCQkJY29uc3QgdWlu
dDMyX3QgKmloX3JpbmdfZW50cnkpDQo+ID4gICB7DQo+ID4gLQl1aW50MTZfdCBzb3VyY2VfaWQs
IHBhc2lkOw0KPiA+ICsJdWludDE2X3Qgc291cmNlX2lkLCBjbGllbnRfaWQsIHBhc2lkOw0KPiA+
ICAgCWludCByZXQgPSAtRUlOVkFMOw0KPiA+ICAgCXN0cnVjdCBrZmRfcHJvY2VzcyAqcDsNCj4g
Pg0KPiA+ICAgCXNvdXJjZV9pZCA9IFNPQzE1X1NPVVJDRV9JRF9GUk9NX0lIX0VOVFJZKGloX3Jp
bmdfZW50cnkpOw0KPiA+ICsJY2xpZW50X2lkID0gU09DMTVfQ0xJRU5UX0lEX0ZST01fSUhfRU5U
UlkoaWhfcmluZ19lbnRyeSk7DQo+ID4gICAJcGFzaWQgPSBTT0MxNV9QQVNJRF9GUk9NX0lIX0VO
VFJZKGloX3JpbmdfZW50cnkpOw0KPiA+DQo+ID4gICAJcCA9IGtmZF9sb29rdXBfcHJvY2Vzc19i
eV9wYXNpZChwYXNpZCk7DQo+ID4gQEAgLTExMCw2ICsxMTEsNyBAQCBzdGF0aWMgdm9pZA0KPiBl
dmVudF9pbnRlcnJ1cHRfcG9pc29uX2NvbnN1bXB0aW9uKHN0cnVjdCBrZmRfZGV2ICpkZXYsDQo+
ID4gICAJCXJldHVybjsNCj4gPiAgIAl9DQo+ID4NCj4gPiArCXByX2RlYnVnKCJSQVMgcG9pc29u
IGNvbnN1bXB0aW9uIGhhbmRsaW5nXG4iKTsNCj4gDQo+IGRldiBpcyBhdmFpbGFibGUgdGhyb3Vn
aCBrZmRfZGV2Lg0KDQpbVGFvXSBub3Qgc3VyZSBvZiB5b3VyIG1lYW5pbmcgaGVyZS4NCg0KPiAN
Cj4gPiAgIAlhdG9taWNfc2V0KCZwLT5wb2lzb24sIDEpOw0KPiA+ICAgCWtmZF91bnJlZl9wcm9j
ZXNzKHApOw0KPiA+DQo+ID4gQEAgLTExOSwxMCArMTIxLDE0IEBAIHN0YXRpYyB2b2lkDQo+IGV2
ZW50X2ludGVycnVwdF9wb2lzb25fY29uc3VtcHRpb24oc3RydWN0IGtmZF9kZXYgKmRldiwNCj4g
PiAgIAkJYnJlYWs7DQo+ID4gICAJY2FzZSBTT0MxNV9JTlRTUkNfU0RNQV9FQ0M6DQo+ID4gICAJ
ZGVmYXVsdDoNCj4gPiArCQlpZiAoY2xpZW50X2lkID09IFNPQzE1X0lIX0NMSUVOVElEX1VUQ0wy
KQ0KPiA+ICsJCQlyZXQgPSBrZmRfZHFtX2V2aWN0X3Bhc2lkKGRldi0+ZHFtLCBwYXNpZCk7DQo+
IA0KPiBTaW5jZSB0aGlzIGRvZXNuJ3QgbG9naWNhbGx5IGJlbG9uZyB0byB0aGUgc3dpdGNoIGNv
bmRpdGlvbiwgYmV0dGVyIHRvIGtlZXAgaXQNCj4gb3V0c2lkZSBvZiBzd2l0Y2guDQoNCltUYW9d
IHdpbGwgYWRkIHNvdXJjZSBpZCBkZWZpbml0aW9uIGZvciBpdC4NCg0KPiANCj4gPiAgIAkJYnJl
YWs7DQo+ID4gICAJfQ0KPiA+DQo+ID4gLQlrZmRfc2lnbmFsX3BvaXNvbl9jb25zdW1lZF9ldmVu
dChkZXYsIHBhc2lkKTsNCj4gPiArCS8qIHV0Y2wyIHBhZ2UgZmF1bHQgaGFzIGl0cyBvd24gdm0g
ZmF1bHQgZXZlbnQgKi8NCj4gPiArCWlmIChjbGllbnRfaWQgIT0gU09DMTVfSUhfQ0xJRU5USURf
VVRDTDIpDQo+ID4gKwkJa2ZkX3NpZ25hbF9wb2lzb25fY29uc3VtZWRfZXZlbnQoZGV2LCBwYXNp
ZCk7DQo+ID4NCj4gPiAgIAkvKiByZXNldHRpbmcgcXVldWUgcGFzc2VzLCBkbyBwYWdlIHJldGly
ZW1lbnQgd2l0aG91dCBncHUgcmVzZXQNCj4gPiAgIAkgKiByZXNldHRpbmcgcXVldWUgZmFpbHMs
IGZhbGxiYWNrIHRvIGdwdSByZXNldCBzb2x1dGlvbiBAQCAtMzE0LDcNCj4gPiArMzIwLDE4IEBA
IHN0YXRpYyB2b2lkIGV2ZW50X2ludGVycnVwdF93cV92OShzdHJ1Y3Qga2ZkX2RldiAqZGV2LA0K
PiA+ICAgCQlpbmZvLnByb3Rfd3JpdGUgPSByaW5nX2lkICYgMHgyMDsNCj4gPg0KPiA+ICAgCQlr
ZmRfc21pX2V2ZW50X3VwZGF0ZV92bWZhdWx0KGRldiwgcGFzaWQpOw0KPiA+IC0JCWtmZF9kcW1f
ZXZpY3RfcGFzaWQoZGV2LT5kcW0sIHBhc2lkKTsNCj4gPiArDQo+ID4gKwkJaWYgKGNsaWVudF9p
ZCA9PSBTT0MxNV9JSF9DTElFTlRJRF9VVENMMiAmJg0KPiA+ICsJCSAgICBkZXYtPmtmZDJrZ2Qt
PmlzX3Jhc191dGNsMl9wb2lzb24gJiYNCj4gPiArCQkgICAgZGV2LT5rZmQya2dkLT5pc19yYXNf
dXRjbDJfcG9pc29uKGRldi0+YWRldiwgY2xpZW50X2lkKSkgew0KPiA+ICsJCQlldmVudF9pbnRl
cnJ1cHRfcG9pc29uX2NvbnN1bXB0aW9uKGRldiwNCj4gaWhfcmluZ19lbnRyeSk7DQo+ID4gKw0K
PiBJcyBpdCBleHBlY3RlZCB0aGF0IG5vIG90aGVyIGludGVycnVwdCB3b3VsZCBjb21lIHVudGls
IHRoaXMgRkVEIGVycm9yIGlzIGNsZWFyZWQ/DQo+IE90aGVyd2lzZSBzdWJzZXF1ZW50IG9uZXMg
Y291bGQgYWxzbyBiZSB0cmVhdGVkIGFzIHBvaXNvbi4NCg0KW1Rhb10gT0ssIEknbGwgY2xlYXIg
aXQgYWZ0ZXIgY2hlY2tpbmcgRkVEIHN0YXR1cy4NCg0KPiANCj4gQmFzaWNhbGx5LCB3aGV0aGVy
IHRvIGRvIHRoaXMgb3Igbm90Pw0KPiAJMSkgQ2xlYXIgRkVEDQo+IAkyKSBIYW5kbGUgcG9pc29u
IGNvbnN1bXB0aW9uDQoNCltUYW9dIEkgdGhpbmsgd2UgbmVlZCB0byBjbGVhciBzdGF0dXMgcmVn
aXN0ZXIsIG90aGVyd2lzZSB0aGUgZXJyb3Igc3RhdHVzIGlzIGFsd2F5cyB0aGVyZS4NCg0KPiAN
Cj4gDQo+IFRoYW5rcywNCj4gTGlqbw0KPiANCj4gPiArCQkJaWYgKGRldi0+a2ZkMmtnZC0+dXRj
bDJfZmF1bHRfY2xlYXIpDQo+ID4gKwkJCQlkZXYtPmtmZDJrZ2QtPnV0Y2wyX2ZhdWx0X2NsZWFy
KGRldi0+YWRldik7DQo+ID4gKwkJfQ0KPiA+ICsJCWVsc2UNCj4gPiArCQkJa2ZkX2RxbV9ldmlj
dF9wYXNpZChkZXYtPmRxbSwgcGFzaWQpOw0KPiA+ICsNCj4gPiAgIAkJa2ZkX3NpZ25hbF92bV9m
YXVsdF9ldmVudChkZXYsIHBhc2lkLCAmaW5mbyk7DQo+ID4gICAJfQ0KPiA+ICAgfQ0KPiA+DQo=
