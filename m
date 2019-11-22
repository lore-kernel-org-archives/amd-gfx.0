Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BD0C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 23:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3084E20704
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 23:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3084E20704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C63356E129;
	Fri, 22 Nov 2019 23:09:14 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700049.outbound.protection.outlook.com [40.107.70.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFC26E147
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 23:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3OtaRpx6wALD7cJGApuR02Ldxyng6VYswVORiADnUoTSyOqyBbEzkD/mYrjas2LVFiLSeC7cvIhroARF0J6kcMdGEePmms9Ro8NPTyYx6TZiBm0Qy+cQO6y+t/nuhsGySgb751ctNm/pKSHLmDwAidj0gUZGKTocnJ5wQjZsEWFmHLwhHMaTHryAfCYWKMdo4E1eAikS6JN8HAFqUrcbA638Lw/MVZ6BNaGaEShpvP0HohY1MQqPXdxMdw7ZIa0Qv/seCib1nGCS+PueVRBPIxsP3VbFpwvM4vz8dIkZL3231xMEvVpf5aSzX52Mtjp+yguAwDrf/PTfFcbMcyQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYspQJr2Ecjh9+hRH9dSOxKHBYf/MvSyi7L52rlJC04=;
 b=gmaPDOPSO/8Jtpbtz90VjOQFqlUGwrVdU9MYHoOrhXkPUS33DjtslxWY3pmj/kIMtSmN8Wz98YabFBJVY6XUyYjmTF5MteQ6lt4vqLTsmgk17Mg+64O5vCzsIv0SdpSqch39fusGkh17Xj1oXoj6rE/AEmH1fox6iylVYRFpi79ii2O3OkF8aG36OmQZMLALN+ZnUeZV+VhG+a22XznWxer14A0aIsBdZ1pc/EaNnQAQmNPIfUNAyoyQIprfyi55z/jQfnBb/Obk2QoZ19JPQ1UgtQxupbMa/ta4dmzlLYwwF5Izla6BfxKII4zIAgA9B5hI2zjHAKgcQ2Ppv+GqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2499.namprd12.prod.outlook.com (52.132.30.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Fri, 22 Nov 2019 23:09:10 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595%2]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 23:09:10 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Apply noretry setting for gfx10 and mmhub9.4
Thread-Topic: [PATCH] drm/amdgpu: Apply noretry setting for gfx10 and mmhub9.4
Thread-Index: AQHVoXKxvLEEdJ3uvk2oRDM5asjqHqeXqkAAgAAUdZA=
Date: Fri, 22 Nov 2019 23:09:10 +0000
Message-ID:
 <BL0PR12MB25807A3E37A18899CA5AA13880490@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <1574454197-13273-1-git-send-email-Oak.Zeng@amd.com>
 <b4dcc63c-e57e-30cb-06f2-11451c37a195@amd.com>
In-Reply-To: <b4dcc63c-e57e-30cb-06f2-11451c37a195@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87dd79b2-0b39-4e03-e8bd-08d76fa0fc01
x-ms-traffictypediagnostic: BL0PR12MB2499:|BL0PR12MB2499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24998E2C286FF178029C310D80490@BL0PR12MB2499.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(13464003)(199004)(189003)(478600001)(66446008)(66476007)(6436002)(66556008)(64756008)(4326008)(2501003)(7696005)(25786009)(6506007)(5660300002)(14454004)(2906002)(76176011)(7736002)(4001150100001)(66946007)(76116006)(55016002)(71200400001)(186003)(86362001)(99286004)(74316002)(6116002)(102836004)(229853002)(53546011)(66066001)(9686003)(71190400001)(305945005)(3846002)(26005)(8936002)(33656002)(256004)(11346002)(316002)(8676002)(446003)(81166006)(110136005)(52536014)(6246003)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2499;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?QTdkQTdkeWRsWUM4bEJhTlNQdkJnV0hEZ09uVGptdkg2eWVKMkFtdmN4RjBy?=
 =?utf-8?B?SDUvalB4UW1ZWUZTbURHUC9kZDRKVWp4VTBRUXhEMDZTTWdBNjRPbWR1SGJJ?=
 =?utf-8?B?NlZ1WUYwSXF0ZDIyY2ZtVFRPSTVFbURDVzBoWWw0RGpVQi85QWowUXQ2N3R3?=
 =?utf-8?B?RCsyMkpOWnlMWFhwWjZkMHozODloVitBRkR6cFFTb2ZrWXpEQlNxUVpFc0My?=
 =?utf-8?B?QW1ZQ0FDZ29aeWh6Slo2dWg2UFBiVS9CbjVpQU1UOWIzOXFiZzN4czBrM2J1?=
 =?utf-8?B?aGdNMVNCazhzeXpqZXQvVUF3dVBwc3gyUmpKSER3QXkydWV6KzJxVCtLZ0Zh?=
 =?utf-8?B?bFJoK3lkb3kvQXVFd1puTTB4T3A2RkpZNk1JU1l2TmNwZlMxaFVzMUhTMzVa?=
 =?utf-8?B?a3V6MWRoS1BhMmdXTGJOd0JDZyswLytZbG9QZlJld0xXZE5TWllpajlhays3?=
 =?utf-8?B?Wmt1ZU15di9wVzg3amFNdEtFRjk3V3JUT1kwRUQ4c0lNMy9LUSs2YUxvQXQr?=
 =?utf-8?B?c3A2cHVKaEJGRkdrVkZKTFJRNzdRbG1PdlBiWEVjUlpXb3FkeFZzclRpMkpV?=
 =?utf-8?B?eVdQRXprT2NoYVRmSmJKWkZEZXdvU1Z5dUdEWUY5dExCbzhTV0hMZDZYQi9N?=
 =?utf-8?B?OHVhcm5HQ3lUYmhCdVRrd0ZtZG9NdlhFRmVpQmM4V1IxTmtRTDZVZmhhK2pH?=
 =?utf-8?B?eFdWTjU5OGJlOUhXWnFGajFBanl0OWRvdnBPSWNRclBxeURXdUhmWGRFdFYv?=
 =?utf-8?B?ZmpWQ2RXTFN4Qm4yaVpGWUp4eEoyRitydGdNTFRXLzA5OHc0Y3FLRWJGcTZo?=
 =?utf-8?B?RS9wTWdONldBeUl6Y2pNekc0ZDVUTElITzZhMGhjUnFPczNDVmJ5bFpET0Fm?=
 =?utf-8?B?OENHNlVBYTZhOWVUWlJFVmxEVWJvV2Y5ZHptQitTcUU2WVFhY0haalloZHJr?=
 =?utf-8?B?ZmJqaFd2VWhOVWxzeWQxaHQwZGxtYTA5aW5CZHNRRTFsR0c1d3Z5endkRjNQ?=
 =?utf-8?B?MWNWSHdqM2tBaytqeWt0YWovMWp5TWFsNDFHMVV3Qmhmb0JjNGUrd2lMb2FS?=
 =?utf-8?B?Wjc3ZW1tS2MreFhsRUtVSUZVMVhwQzlWd0FMS3ROTHZScXRIbDRYSUJtL3Yx?=
 =?utf-8?B?SDhZUXV3RFpVNUFKRWlGejdtT25ETFg5TFFxamtseDBMUjZsZGptTm50MmpU?=
 =?utf-8?B?Qmt5cGRJRzhiVHZaWmlzMUFrTER5OEFhcVgxOGhJemVkVG1CaEoycWhjUmJv?=
 =?utf-8?B?U0lORTZUTmtqUmhnOVBMSnFzbjhEMjd2NUhGVzI4UWprZmxWNnQvcXBuM2Z3?=
 =?utf-8?B?ZGtScnpiaFhrOENWZThTWHVCM092Tm9SbERoL3BXNEVjU24zbXhsdWVtdk5n?=
 =?utf-8?B?MExNZ3YwWnYrTDd1U21nZStwMWhSVDFKQUhqVWZZQWpzYy9sL3Z3enYxWnU3?=
 =?utf-8?B?cnBOQjErNmdJYnh1eEN2ajRJWHltcXpMUHd4anBCNWJEQ3ZmbzR6enJORWh2?=
 =?utf-8?B?U0FMdHdWNGhKL2U3WFVzWG9tSG5BUTJMb2ZLNk9CWEl6TTh3eW1BTTZINmtY?=
 =?utf-8?B?QTg4QTV6aUl0MHdJUjc3ak5xSzFSVllvbHluQVVKL0RQMWNiVU82YkJJUHJk?=
 =?utf-8?B?dVl6UnpQNlROQjdJWUxWTWk3eFlqRDVGd2ErallQMlIyT0hpMFRqKzd0T0oz?=
 =?utf-8?B?L043V2NMMmd0VWRNYzJ4eGhTK3NxSlN4SERtL0YvMkFNWGdUck8vQU0zK2g1?=
 =?utf-8?B?dFRISHRIeTgzQ2NXMlJpQnJJZzNweG56SXRDK1VNOWhxM2NEQklzNDJienhJ?=
 =?utf-8?B?aE1MUXRabE9XYWNSNkdNOCtFMzNXd2g4YkZ2VFphOFQ2ZlhJcWk0b0lIRFBw?=
 =?utf-8?B?UGUrbVJhbHd6UUpuWXdSU09LSVdqZkxpcG56TElzR0Z0NCtlUWxqbXozVVA0?=
 =?utf-8?B?b0Nwb1AvRzlNSUNmRVptYVpISFRxa0Y5dDRkVmFwUWtKejB3ZkRoVGl3dHgw?=
 =?utf-8?B?OWRTc1ZZclhoQTI5bG1ZRnE3WjlBYUdndFJDcTZ6MHlWdkFwSHFvQXRrUzl4?=
 =?utf-8?B?RGNhcmYzVFRsUklqY215YlJyQU9ocGtONDUxRUtqQTZxRllaY1RubTFubHUv?=
 =?utf-8?B?NWZ4MXJOTVlDRUJ4RXZyVDNEL0Z0c2hZRk5TeUFGUFllQXpnVWluZk9qU0lO?=
 =?utf-8?B?WVk1NkVjT2VTaFYzYXYvSndDeG85MkJkdFJlVnFYcFQ2THdyZm1TTXZzZCtL?=
 =?utf-8?B?dlhIOHI0VkJUS29kVExZS1F6dEx1RTh6aVpzampQdHZSTkxGaFVuZ3pmeWRZ?=
 =?utf-8?B?alNuVC90M0ZYaUNBZlJCYmphcXVXTjJjUkZXNmNxeUtxeGFLMW85akxaRzYx?=
 =?utf-8?B?eHkxNWp1bS9sb0JmU0ZyaVhMQ29QTHIvWGZqekxEdkpWUFlncW15ejhHL1dS?=
 =?utf-8?B?OE5BYnk3TTBoT3IzRVE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87dd79b2-0b39-4e03-e8bd-08d76fa0fc01
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 23:09:10.7389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KI8EulXn94CMsSFZRw0vBrRWRxn7KWsXOuJpxBSInVbhbtSzJrTydwrZW2INoowz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2499
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYspQJr2Ecjh9+hRH9dSOxKHBYf/MvSyi7L52rlJC04=;
 b=WpBJDsy8tp3nPJKqY1v9fmmraulybnizRivcNY9g/xdnGPt21xRRz2waNooVnkc63JzRzxVzGjDevJdJh5ubOU0yKwgvzHWr39B9oX2Zc2jvsKhV4VNd++wWizUVyD5vGx/Km5zb23QtpY60uA/pGPt7VlhZ0V/6RkMK4i0Wt54=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Cornwall, Jay" <Jay.Cornwall@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191122230910.JcRLMekRMt0onyAujrIOxbi6iX__B0iRka6ViD7OGUU@z>

SSBkaWRuJ3QgaGF2ZSBuZXcgaW5mb3JtYXRpb24gYWJvdXQgdGhlIHJldHJ5X21vZGUgc2V0dGlu
ZyBmb3IgZ2Z4MTAuIEkganVzdCBzYXcgdGhlIG5vcmV0cnkga2VybmVsIHBhcmFtZXRlciB3YXNu
J3QgYXBwbGllZCB0byBnZngxMCBidXQgSSBkaWRuJ3Qga25vdyBnZngxMCBpcyBleGNsdWRlZCBw
dXJwb3NlbHkuIExldCBtZSBkcm9wIHRoZSBnZngxMCBwYXJ0IGZvciBub3cuDQoNCk9haw0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5L
dWVobGluZ0BhbWQuY29tPiANClNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMjIsIDIwMTkgMzo1MSBQ
TQ0KVG86IFplbmcsIE9hayA8T2FrLlplbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQpDYzogQ29ybndhbGwsIEpheSA8SmF5LkNvcm53YWxsQGFtZC5jb20+DQpTdWJq
ZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBBcHBseSBub3JldHJ5IHNldHRpbmcgZm9yIGdm
eDEwIGFuZCBtbWh1YjkuNA0KDQoNCk9uIDIwMTktMTEtMjIgMzoyMyBwLm0uLCBPYWsgWmVuZyB3
cm90ZToNCj4gQ29uZmlnIHRoZSB0cmFuc2xhdGlvbiByZXRyeSBiZWhhdmlvciBhY2NvcmRpbmcg
dG8gbm9yZXRyeSBrZXJuZWwgDQo+IHBhcmFtZXRlcg0KPg0KPiBDaGFuZ2UtSWQ6IEk1YjkxZWE3
NzcxNTEzN2NmOGNiODRlMjU4Y2NkZmJiMTljN2E0ZWQxDQo+IFNpZ25lZC1vZmYtYnk6IE9hayBa
ZW5nIDxPYWsuWmVuZ0BhbWQuY29tPg0KPiBTdWdnZXN0ZWQtYnk6IEpheSBDb3Jud2FsbCA8SmF5
LkNvcm53YWxsQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92MTBfMC5jICB8IDQgKysrLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21t
aHViX3Y5XzQuYyB8IDUgKysrLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92MTBfMC5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
MTBfMC5jDQo+IGluZGV4IDRkNmRmMzUuLjc0MzU0ODcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92MTBfMC5jDQo+IEBAIC0xNzUxLDcgKzE3NTEsOSBAQCBzdGF0aWMgdm9p
ZCBnZnhfdjEwXzBfY29uc3RhbnRzX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+
ICAgCWZvciAoaSA9IDA7IGkgPCBhZGV2LT52bV9tYW5hZ2VyLmlkX21ncltBTURHUFVfR0ZYSFVC
XzBdLm51bV9pZHM7IGkrKykgew0KPiAgIAkJbnZfZ3JibV9zZWxlY3QoYWRldiwgMCwgMCwgMCwg
aSk7DQo+ICAgCQkvKiBDUCBhbmQgc2hhZGVycyAqLw0KPiAtCQlXUkVHMzJfU09DMTUoR0MsIDAs
IG1tU0hfTUVNX0NPTkZJRywgREVGQVVMVF9TSF9NRU1fQ09ORklHKTsNCj4gKwkJdG1wID0gUkVH
X1NFVF9GSUVMRChERUZBVUxUX1NIX01FTV9DT05GSUcsIFNIX01FTV9DT05GSUcsDQo+ICsJCQkJ
UkVUUllfTU9ERSwgYW1kZ3B1X25vcmV0cnkgPyAyIDogMCk7DQo+ICsJCVdSRUczMl9TT0MxNShH
QywgMCwgbW1TSF9NRU1fQ09ORklHLCB0bXApOw0KSSBkaWRuJ3QgZml4IGdmeF92MTBfMCBvbiBw
dXJwb3NlIGxhc3QgdGltZSBJIHdvcmtlZCBvbiB0aGlzDQooIjc1ZWU2NDg3NWU3NSBkcm0vYW1k
a2ZkOiBDb25zaXN0ZW50bHkgYXBwbHkgbm9yZXRyeSBzZXR0aW5nIiksIGJlY2F1c2UgdGhlIHJl
dHJ5IHdvcmtzIGRpZmZlcmVudGx5IG9uIEdGWHYxMC4gRG8geW91IGhhdmUgbmV3IGluZm9ybWF0
aW9uIGFib3V0IGhvdyB0aGUgUkVUUllfTU9ERSBzZXR0aW5nIHdvcmtzIG9uIEdGWHYxMD8gRG9l
cyBpdCBhZmZlY3QgcGVyZm9ybWFuY2U/DQoNCg0KPiAgIAkJaWYgKGkgIT0gMCkgew0KPiAgIAkJ
CXRtcCA9IFJFR19TRVRfRklFTEQoMCwgU0hfTUVNX0JBU0VTLCBQUklWQVRFX0JBU0UsDQo+ICAg
CQkJCShhZGV2LT5nbWMucHJpdmF0ZV9hcGVydHVyZV9zdGFydCA+PiA0OCkpOyBkaWZmIC0tZ2l0
IA0KPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYyANCj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMNCj4gaW5kZXggNzUzZWVhMi4uODU5
OWJmZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlf
NC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYw0KPiBA
QCAtMzE0LDcgKzMxNCw4IEBAIHN0YXRpYyB2b2lkIG1taHViX3Y5XzRfc2V0dXBfdm1pZF9jb25m
aWcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGludCBodWJpZCkNCj4gICAJCQkJICAgIGFk
ZXYtPnZtX21hbmFnZXIuYmxvY2tfc2l6ZSAtIDkpOw0KPiAgIAkJLyogU2VuZCBuby1yZXRyeSBY
TkFDSyBvbiBmYXVsdCB0byBzdXBwcmVzcyBWTSBmYXVsdCBzdG9ybS4gKi8NCj4gICAJCXRtcCA9
IFJFR19TRVRfRklFTEQodG1wLCBWTUwyVkMwX1ZNX0NPTlRFWFQxX0NOVEwsDQo+IC0JCQkJICAg
IFJFVFJZX1BFUk1JU1NJT05fT1JfSU5WQUxJRF9QQUdFX0ZBVUxULCAwKTsNCj4gKwkJCQkgICAg
UkVUUllfUEVSTUlTU0lPTl9PUl9JTlZBTElEX1BBR0VfRkFVTFQsDQo+ICsJCQkJICAgICFhbWRn
cHVfbm9yZXRyeSk7DQoNClJpZ2h0LCB0aGlzIHdhcyBtaXNzZWQgaW4gbXkgcHJldmlvdXMgY29t
bWl0IGJlY2F1c2UgbW1odWJfdjlfNCB3YXMgYWRkZWQgbGF0ZXIuDQoNClJlZ2FyZHMsDQogwqAg
RmVsaXgNCg0KDQo+ICAgCQlXUkVHMzJfU09DMTVfT0ZGU0VUKE1NSFVCLCAwLCBtbVZNTDJWQzBf
Vk1fQ09OVEVYVDFfQ05UTCwNCj4gICAJCQkJICAgIGh1YmlkICogTU1IVUJfSU5TVEFOQ0VfUkVH
SVNURVJfT0ZGU0VUICsgaSwNCj4gICAJCQkJICAgIHRtcCk7DQo+IEBAIC05MDUsNCArOTA2LDQg
QEAgc3RhdGljIHZvaWQgbW1odWJfdjlfNF9xdWVyeV9yYXNfZXJyb3JfY291bnQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgY29uc3Qgc3RydWN0IGFtZGdwdV9tbWh1Yl9mdW5jcyBt
bWh1Yl92OV80X2Z1bmNzID0gew0KPiAgIAkucmFzX2xhdGVfaW5pdCA9IGFtZGdwdV9tbWh1Yl9y
YXNfbGF0ZV9pbml0LA0KPiAgIAkucXVlcnlfcmFzX2Vycm9yX2NvdW50ID0gbW1odWJfdjlfNF9x
dWVyeV9yYXNfZXJyb3JfY291bnQsIC19OyBcIE5vIA0KPiBuZXdsaW5lIGF0IGVuZCBvZiBmaWxl
DQo+ICt9Ow0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
