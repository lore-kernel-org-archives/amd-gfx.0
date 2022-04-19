Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B39C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 00:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B3A10E137;
	Tue, 19 Apr 2022 00:05:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 115BA10E128
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 00:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPXhy92j6Aymb4yR2FuA+4GU7/LnLpnswF0ZznPmYBmtAH3oIkNjpoqVNQfJEPS1hIAzkXmabUPmgT9hL4ChNJl8aYc4OcHJrI7BCBO8m/26M102jppXfGwdZZY+gRScA0qHKXlqvkhywyl7wxfs6u7BpiAFx9eObyTZ2Bk1TTMCPzPo8sMVNHQE/8mO8Hd4Cr7EhjZcm9LQOFJnfV/QEXz7IMTdzOfeMXdnEzpLLJ8NOjzr5GNsabQQouy4dK/dnId7d3Y2b3V5zjFd73HIQiiZokMfS60TWKKwK7PQg1bBGisgkMYduVOHDlEPGCLwqtUPo7rJD/+LcjFLCcD9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNlfhKcKayPdRnFFQhwlDt0EhRXt/+TYgPjsMyxSA3o=;
 b=Wu6T9Puk/ojycoIelt594rRT3/v8uWHj0DmTqwyNZanU8Pw7JBfjTGPrVWtjM/qTWJXJqAFpNDyzCf9UwZ/l8e+pudTK31TfgxgcAUqVN4fRcnCPqt+QQbv7E4M+8hZOHl427G8buKlVfarUre9azV7EkdrUQVKf3X4l4vDflsLYTnaRufu4miUlg3K02TdYw8COxN9IK8sryglmjNGBX71kKHDPaIHsA4aZbD4Lr6A12EpYMHyEDjxzkPUm0D9gFF8S5kg0uPpRsam+sM/NbEWO2QpkSt9aUvppNhZIGzAh2Z0TogD/0LuDkjv+YWShOHwyp4qBw4j0ILAHnSXonw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNlfhKcKayPdRnFFQhwlDt0EhRXt/+TYgPjsMyxSA3o=;
 b=ALYkpF5xzEkf7a4kyIrglejxrq8a0Xvn347b1xTelHGqKI50nBV2QAmfw+UNCrC86wG+8nQrmY0aqBAueMH1rq1DuJsAW36oNVenOiMQf76111okA3QA4B4UsAUAgTGlG/ZfuWq5OjAjkPVNrOx7ZwLYVKSvZQ4kVvImFAx9sRQ=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by MWHPR1201MB0269.namprd12.prod.outlook.com (2603:10b6:301:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Tue, 19 Apr
 2022 00:04:58 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8d9:b576:c670:be66]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8d9:b576:c670:be66%7]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 00:04:58 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH v2 2/2] drm/amdkfd: CRIU add support for GWS queues
Thread-Topic: [PATCH v2 2/2] drm/amdkfd: CRIU add support for GWS queues
Thread-Index: AQHYU0OhBUcv95gP0EW39JqnDDYP76z2HbyAgAA4T2A=
Date: Tue, 19 Apr 2022 00:04:58 +0000
Message-ID: <DM6PR12MB5021D813258265387A23C2B895F29@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20220418164437.1875319-1-david.yatsin@amd.com>
 <20220418164437.1875319-2-david.yatsin@amd.com>
 <568532d5-e127-2d39-a455-e4102ab240b2@molgen.mpg.de>
In-Reply-To: <568532d5-e127-2d39-a455-e4102ab240b2@molgen.mpg.de>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68c64326-18a5-434f-5402-08da21983de1
x-ms-traffictypediagnostic: MWHPR1201MB0269:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB0269D3CAF3020648553694CB95F29@MWHPR1201MB0269.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AMmdDM86PcqTEnLuRhBrrR+S+cG/RpRvIfXqWmsBZ1kf+sdvRNRW927Kq35BCxeEErAa8d8l2U2C6HE8T3cFw8MjV8LwqjoMJwRx8huG4/O9DQKp7L5CKDgqWyzOIm5U5C8f+p38asPDlDu1Bs+J6RvX04GcjufAlWbbYvfYyZeDT0vHcIo6IE3VirJX7/KwBIv8igAlVkY/ZGtvXfFFEU74n3s/I/Lfp1s2TQjqM3Lt1KcsXfdcunC+p6O7Cguclh1Fdu4Hywcr57ZZsJPv0POcwdrqc50qc2pB2bDE6abAzypr7hhFceZ3FKKmcUQBDduSKhZiQxSxwIOi0a13U/zckS+KQLV0XiRLvAX66TNHH46Hy0nQdhnZzHDcMGLKHVEeu0HwVQ+3o8onbW2Sqj5TePBgAZybxKxPKq18gijuIsa4He/pxNxvnqkfQb22lEMij3F/lOL5kBUNgSBQcgArqIIA7wcelPl/dvc5OJUQL78weTmWPCJLPINFx5NGzMsJi2tcTSvtMzAIQqX/ddgCaVEgFKWXDcOiEYaYk3xC5WvZfhqMSWCQlSb4Xf9Jbup/JrlkhyFgggZMnbDZ7XMTqPmshrbwvEoI8/xclB9FUHkQrmfBP0NTHZQazfBISOIO40rLcSQOxobhCd2JTdmP6hl+6NMSmk98e0LaMOSP//XC5v6/RbqFSwUDfcgVNNjHbhIiLAcxjWEX6E61ikNbP+AyvWWIcJnViY+Lldk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(55016003)(7696005)(86362001)(122000001)(52536014)(53546011)(8936002)(6916009)(316002)(54906003)(508600001)(66476007)(38070700005)(66946007)(76116006)(66556008)(71200400001)(66446008)(64756008)(38100700002)(6506007)(33656002)(186003)(4326008)(8676002)(5660300002)(9686003)(26005)(83380400001)(2906002)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFR4TlE5dTFBeWY0S01nRUFBb2p1cEtuaFBzYi9TZjZSc1BJWWs0MjgvcGVT?=
 =?utf-8?B?SERoanYxVVhIblRZOG9YZWhPL1lJdjZ3UlB2NnBaeWhDQkg0STBVczVyNThv?=
 =?utf-8?B?b3JxekJGUVd6ZFNaYUk2VkxnK2VKa1oxYkMzNWptZVp5dVdPTWozeXVOUXNr?=
 =?utf-8?B?Y3Q0U0J1Nk9KMXhKNzFVZmlpdFE5aCtVdFNPUnBTMVdLOGl0M1RLQnhjaG0w?=
 =?utf-8?B?MXNlRENBNjV2THR6NUF6US9iQWhEK3BkMnVlOHp1MzhBSGd2dk9uTDFOMDRr?=
 =?utf-8?B?anpWdS9OSUpzSk9DeS84SEdoU2hYdTdJdTdrVFBpWGc2NllzVUs4RkgrcXBN?=
 =?utf-8?B?S3Z6QWxNRlNJSjFMMlpDY0JoR0d0MFBlNmh0MEdEd3JjU09acDFrMUQzdGVX?=
 =?utf-8?B?QWJHQkh6OVdrNEQyb3k4YVJFQ2Mrd3VpUXRsLzhCNUJneFdodU5Yc01TMHM0?=
 =?utf-8?B?QzFISzhmK2JrK1FaNnA0Zm5sS2RDdkZLRUwxM0NXeks2VUgxT004YXV3MlJk?=
 =?utf-8?B?MjR6SkR1ZXRBZTZYUERzc0dUTjBVTkxBT2ZJSStWSEdibFk2aWdjOUtWZ3Nh?=
 =?utf-8?B?cnBEUWVGcTFyY0RzZ2F6UitoVHBrNDhIMXA2MFBDSXZmUmRDOG53RHhtU054?=
 =?utf-8?B?UVJZV3VsTkxnd1NHMHJxSUtzcFU4cktoOXdDdjRsU0trTmxVM05mL092bnZE?=
 =?utf-8?B?enNLZm9pS3EvZGxRTmdnVlErZlRnd1dxLzZZb1h5NDZGMnM4bkthMENzN09k?=
 =?utf-8?B?bHpveGkrMFNoQ0duV2d5cVZmWCs4ZWlFU2k4aGJCcnJNQXVQck1RVlluZUVm?=
 =?utf-8?B?bjkrN1JwNkF2WkQ2R2gzNUNNUW1ISTZmZElETmxHYitUbmdxUlZhZjF0UUMv?=
 =?utf-8?B?a0h3U0lrVCtkb0xIUVFCVHVRSXB2Rm55S1IyZkNDSEtrM3Q5NnUyRnNISEdS?=
 =?utf-8?B?SGh0enUvS1FjbTdNWmt5S1Vrd1kvTTRkRGVLT2tWbUhEdS9iTUQzbXhzTm1K?=
 =?utf-8?B?Q0x4UUZHU093aXovMXJyRitGa2tjM1VpWTVQVkQ4V1B4b3hSZ1UxY2dIdzk1?=
 =?utf-8?B?UW9jakJIVWpVQllxUk9GVHB6dFpVWlJkb2Zsb2s1NU5QSmhMQ3JaNVJZa0c0?=
 =?utf-8?B?ZlZtMnJDeWE1TnlHSnkwTEU4ZzUxSVNkQjZQSFplOGdYY09BWGFFcmdrWUtN?=
 =?utf-8?B?cG1GTWc3QnJybFIyUXhwYVRwOUt5SkRLdUFpYkYySzNzZUpoRi9mRzA1M2g1?=
 =?utf-8?B?Mm1sTmp1QVF4Q0RqVHQxd1Q2SWlkQWxGR0d1VCtQeGdxM2FyRlJWM2ZpZUxi?=
 =?utf-8?B?U1h0dDJSbmhkdFVYa2RFcGxpUlpwUDBuZUJMRSs2QndpQVhBK215N1kwSHpN?=
 =?utf-8?B?RmVpSy9YbEFOWFhUZGVBMkpjUnpRNTB6Vit4OVJXYXdyUDFSZC84T1pQdXBh?=
 =?utf-8?B?RGhvRlQvbXRFdkhyRTRvaU1RaktkT1ovd3NDNlkrZ0JnaHNHK2ZoSEU4Nldt?=
 =?utf-8?B?QXIvQUovQlBvVVpKSkNNeUhwVWpSRnBORUIrcjNxR2t6T3R3RndaeTB0aGtn?=
 =?utf-8?B?UStNUUF3SnVFV2RYWU40Qzgvc2x6Tys4d2RaUGtmWmlKRzNETnlWWDlKa2Fp?=
 =?utf-8?B?WDV4QTJhLy9YaHc5T3NwQTFhR2wvTFpDdk5pMGtZMnRHTDMxZEpPYzl0SnN4?=
 =?utf-8?B?S0RPL1pkblVFRXIwdFlIZ21pOGZ6aFdxRTMxN216REpWYlVvZENWVHVaVmlX?=
 =?utf-8?B?dFZpMzhkNUxlbHQvVlZkTzlUaHV6NkxScE5sL0xmSHpHMGI4eXZ5bzBLT0xI?=
 =?utf-8?B?QWZJZVgvdzZoL2tYdk12b3lhSTM2M0lzbGhndWI1MVNTQUFET1Z6WFFXODBD?=
 =?utf-8?B?cFQvOVkrVHdwM21IZkp5QzlJNFhqcVNBeDUvTGlZNmJqS0JyZThzZ0JWaHZ2?=
 =?utf-8?B?QkVDeHVYQUZyeDI0RVVvTnU3SitzSjVFcVhvdE91V21pbGw1ZVdmVFRKNDhP?=
 =?utf-8?B?cEwyMnUzS00zakVUZVc1Rkx6dXlQeFgrVWFWV2R3bnhyUE1ERDhkRDFrM0to?=
 =?utf-8?B?bVpMSjdBaGFuZ1FSV0xlbDZqY2FlbnkxQVRXQ2tKVXRRUGExQnJOV1oxTWxW?=
 =?utf-8?B?TS85WFg3YVI3cWRIZFdBejRaTFBxK0ZhVU9pRW1zSVJaTy9XSzZ3UUQ5Q0Rw?=
 =?utf-8?B?SUFRUThqREFPYkc1bGc5enJ6K0wyWm9MNWFneUgzcXFGaUVheXM1MVNkMmJO?=
 =?utf-8?B?MmZQRTZyV0VsZ2xOeEJMUFc1SWZhMWxUcDlWcDRnbHR6KytPcWdheml5ZkNX?=
 =?utf-8?B?NXFtb2lSelZPS0NkZTJXdkVVcUJLeGRiMmNNUUR6QXRWaytqZnR2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c64326-18a5-434f-5402-08da21983de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 00:04:58.1862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w81dZ3VbHx6wLs3mOUCFFVHQsFIcO+rMsEJcSUh3HJlUlMs8ENlvVSL2Q+U8lqrS538el6bvWkrHfAvWE8Fpag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0269
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBNZW56ZWwgPHBt
ZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU2VudDogTW9uZGF5LCBBcHJpbCAxOCwgMjAyMiA0OjIz
IFBNDQo+IFRvOiBZYXQgU2luLCBEYXZpZCA8RGF2aWQuWWF0U2luQGFtZC5jb20+DQo+IENjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS3VlaGxpbmcsIEZlbGl4DQo+IDxGZWxpeC5L
dWVobGluZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvMl0gZHJtL2FtZGtm
ZDogQ1JJVSBhZGQgc3VwcG9ydCBmb3IgR1dTIHF1ZXVlcw0KPiANCj4gRGVhciBEYXZpZCwNCj4g
DQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guDQo+IA0KPiBBbSAxOC4wNC4yMiB1bSAx
ODo0NCBzY2hyaWViIERhdmlkIFlhdCBTaW46DQo+IA0KPiBJbiB0aGUgY29tbWl0IG1lc3NhZ2Ug
c3VtbWFyeSwgeW91IGNvdWxkIHJlb3JkZXIgc29tZSB3b3JkczoNCj4gDQo+IEFkZCBDUklVIHN1
cHBvcnQgZm9yIEdXUyBxdWV1ZXMNCj4gDQo+ID4gQWRkaW5nIHN1cHBvcnQgdG8gY2hlY2twb2lu
dC9yZXN0b3JlIEdXUyhHbG9iYWwgV2F2ZSBTeW5jKSBxdWV1ZXMuDQo+IA0KPiBzL0FkZGluZy9B
ZGQvDQo+IA0KPiBQbGVhc2UgYWRkIGEgc3BhY2UgYmVmb3JlIHRoZSAoLg0KQUNLDQo+IA0KPiBI
b3cgY2FuIHRoaXMgYmUgdGVzdGVkPw0KV2UgaGF2ZSBzb21lIGludGVybmFsIHRlc3RzIHRoYXQg
Y2FuIHdlIGJlIHVzZWQgdG8gc3BlY2lmaWNhbGx5IHRlc3QgdGhpcyBmZWF0dXJlLg0KPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBZYXQgU2luIDxkYXZpZC55YXRzaW5AYW1kLmNvbT4NCj4g
PiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmggICAgICAg
ICAgICAgICAgICB8ICAyICstDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLmMgfCAxMA0KPiArKysrKysrLS0tDQo+ID4gICAyIGZpbGVz
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oDQo+ID4gaW5kZXggZjM2MDYyYmU5Y2E4
Li4xOTJkYmVmMDRjNDMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3ByaXYuaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9w
cml2LmgNCj4gPiBAQCAtMTEwMiw3ICsxMTAyLDcgQEAgc3RydWN0IGtmZF9jcml1X3F1ZXVlX3By
aXZfZGF0YSB7DQo+ID4gICAJdWludDMyX3QgcHJpb3JpdHk7DQo+ID4gICAJdWludDMyX3QgcV9w
ZXJjZW50Ow0KPiA+ICAgCXVpbnQzMl90IGRvb3JiZWxsX2lkOw0KPiA+IC0JdWludDMyX3QgaXNf
Z3dzOw0KPiA+ICsJdWludDMyX3QgZ3dzOw0KPiANCj4gV2h5IGlzIHRoZSBuZXcgbmFtZSBiZXR0
ZXI/DQpUaGUgb2xkIHZhcmlhYmxlIChpc19nd3MpIHdhcyBvYnRhaW5lZCBmcm9tIHRoZSBxdWV1
ZV9wcm9wZXJ0aWVzIHN0cnVjdHVyZSBkdXJpbmcgY2hlY2twb2ludCBhbmQgaXMgb25seSB1c2Vk
IHRlbXBvcmFyaWx5IGR1cmluZyBxdWV1ZSBjcmVhdGlvbiwgc28gdGhpcyB2YXJpYWJsZSBjYW5u
b3QgYmUgdXNlZCB0byBkZXRlcm1pbmUgd2hldGhlciBhIHF1ZXVlIGFzIGd3cyBlbmFibGVkLiBU
aGUgbmV3IHZhcmlhYmxlIChnd3MpIGlzIG9idGFpbmVkIGZyb20gdGhlIHF1ZXVlIHN0cnVjdHVy
ZS4gVGhlIG5hbWUgaXMgY2hhbmdlZCB0byBiZXR0ZXIgcmVmbGVjdCB0aGlzLg0KPiANCj4gPiAg
IAl1aW50MzJfdCBzZG1hX2lkOw0KPiA+ICAgCXVpbnQzMl90IGVvcF9yaW5nX2J1ZmZlcl9zaXpl
Ow0KPiA+ICAgCXVpbnQzMl90IGN0eF9zYXZlX3Jlc3RvcmVfYXJlYV9zaXplOyBkaWZmIC0tZ2l0
DQo+ID4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5h
Z2VyLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVl
X21hbmFnZXIuYw0KPiA+IGluZGV4IDZlY2E5NTA5ZjJlMy4uNGY1OGU2NzFkMzliIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21h
bmFnZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNz
X3F1ZXVlX21hbmFnZXIuYw0KPiA+IEBAIC02MzYsNiArNjM2LDggQEAgc3RhdGljIGludCBjcml1
X2NoZWNrcG9pbnRfcXVldWUoc3RydWN0DQo+IGtmZF9wcm9jZXNzX2RldmljZSAqcGRkLA0KPiA+
ICAgCXFfZGF0YS0+Y3R4X3NhdmVfcmVzdG9yZV9hcmVhX3NpemUgPQ0KPiA+ICAgCQlxLT5wcm9w
ZXJ0aWVzLmN0eF9zYXZlX3Jlc3RvcmVfYXJlYV9zaXplOw0KPiA+DQo+ID4gKwlxX2RhdGEtPmd3
cyA9ICEhcS0+Z3dzOw0KPiA+ICsNCj4gPiAgIAlyZXQgPSBwcW1fY2hlY2twb2ludF9tcWQoJnBk
ZC0+cHJvY2Vzcy0+cHFtLCBxLQ0KPiA+cHJvcGVydGllcy5xdWV1ZV9pZCwgbXFkLCBjdGxfc3Rh
Y2spOw0KPiA+ICAgCWlmIChyZXQpIHsNCj4gPiAgIAkJcHJfZXJyKCJGYWlsZWQgY2hlY2twb2lu
dCBxdWV1ZV9tcWQgKCVkKVxuIiwgcmV0KTsgQEAgLQ0KPiA3NDMsNw0KPiA+ICs3NDUsNiBAQCBz
dGF0aWMgdm9pZCBzZXRfcXVldWVfcHJvcGVydGllc19mcm9tX2NyaXUoc3RydWN0DQo+IHF1ZXVl
X3Byb3BlcnRpZXMgKnFwLA0KPiA+ICAgCQkJCQkgIHN0cnVjdCBrZmRfY3JpdV9xdWV1ZV9wcml2
X2RhdGENCj4gKnFfZGF0YSkNCj4gPiAgIHsNCj4gPiAgIAlxcC0+aXNfaW50ZXJvcCA9IGZhbHNl
Ow0KPiA+IC0JcXAtPmlzX2d3cyA9IHFfZGF0YS0+aXNfZ3dzOw0KPiA+ICAgCXFwLT5xdWV1ZV9w
ZXJjZW50ID0gcV9kYXRhLT5xX3BlcmNlbnQ7DQo+ID4gICAJcXAtPnByaW9yaXR5ID0gcV9kYXRh
LT5wcmlvcml0eTsNCj4gPiAgIAlxcC0+cXVldWVfYWRkcmVzcyA9IHFfZGF0YS0+cV9hZGRyZXNz
OyBAQCAtODI2LDEyICs4MjcsMTUgQEANCj4gaW50DQo+ID4ga2ZkX2NyaXVfcmVzdG9yZV9xdWV1
ZShzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsDQo+ID4gICAJCQkJTlVMTCk7DQo+ID4gICAJaWYgKHJl
dCkgew0KPiA+ICAgCQlwcl9lcnIoIkZhaWxlZCB0byBjcmVhdGUgbmV3IHF1ZXVlIGVycjolZFxu
IiwgcmV0KTsNCj4gPiAtCQlyZXQgPSAtRUlOVkFMOw0KPiA+ICsJCWdvdG8gZXhpdDsNCj4gPiAg
IAl9DQo+ID4NCj4gPiArCWlmIChxX2RhdGEtPmd3cykNCj4gPiArCQlyZXQgPSBwcW1fc2V0X2d3
cygmcC0+cHFtLCBxX2RhdGEtPnFfaWQsIHBkZC0+ZGV2LT5nd3MpOw0KPiA+ICsNCj4gPiAgIGV4
aXQ6DQo+ID4gICAJaWYgKHJldCkNCj4gPiAtCQlwcl9lcnIoIkZhaWxlZCB0byBjcmVhdGUgcXVl
dWUgKCVkKVxuIiwgcmV0KTsNCj4gPiArCQlwcl9lcnIoIkZhaWxlZCB0byByZXN0b3JlIHF1ZXVl
ICglZClcbiIsIHJldCk7DQo+IA0KPiBNYXliZSBzZXBhcmF0ZSB0aGlzIG91dCwgc28gaXQgY2Fu
IGJlIGFwcGxpZWQgdG8gc3RhYmxlIHNlcmllcy4NCj4gDQo+ID4gICAJZWxzZQ0KPiA+ICAgCQlw
cl9kZWJ1ZygiUXVldWUgaWQgJWQgd2FzIHJlc3RvcmVkIHN1Y2Nlc3NmdWxseVxuIiwNCj4gcXVl
dWVfaWQpOw0KPiA+DQo+IA0KPiANCj4gS2luZCByZWdhcmRzLA0KPiANCj4gUGF1bA0K
