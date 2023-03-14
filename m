Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5A0C6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Mar 2023 06:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6704B10E708;
	Tue, 14 Mar 2023 06:33:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0F8910E708
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Mar 2023 06:33:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IA7jTcd0YPc0JgsQiOdHb9ZtUQhz2UTgLLpVtnjCFdH5m6fUaG8NSi5wv8QEwWUbt991bEmi+fa2BEn6X20CmfOG3u1+wOokAJGgjJSGBl+uqVHc/6+/SGp8ijc2huFV32HkL97yC41sp8WMSDBbsTNl+X6yaoR5MmDBAtV8P7Yb4eJlH1yCwsgvP1wDinvvkcPinXHWv3Pe/6JzPW5TJaN0j0JRTvOJWhWSanNHBBe5XA9cCqRaZlwKRM6pDrHv5n2GyvyzHyXbXEnKrz5Mveg9qJsjfV4AgX/Wvg8fC1gNVxfxcpArsoFtliOX0lBB119Ked+UrJ3Ciq0SLREwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIekUN9BmJxtqqUN8Rqy0X/B2jXMZTLgLEQwbo77/y8=;
 b=ZXEf68ZH9BKswBv5r49gnwmGqzEBo3XN6kLBMisDktcjLWLeSe7kmoVyzgox0mBsXkgcY39fInOKahiY9z4HBWHevO0VrVMkZAEDvmT0n1Wt/hSuhVG11IJYqL/+DNFojOzb7o+DUTo43ToTJ+vwPoXohrwJrozj/akk0hVz8nC3GTskFvodOubjRpPY/UeSBfYZX++ppsTtf+D28TWAeg2NjZyf8161MHWqyBQg9d1hjutCFGTvxQ+DpH+sl2IX8R6qZSPtawDCNmi5qpBsXSsxePDSn3igkj1mNpUGqs2rPHsAEpNUiRJPVJ0y1GXX79dNa26ZzuFpw4Ct6XDUfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIekUN9BmJxtqqUN8Rqy0X/B2jXMZTLgLEQwbo77/y8=;
 b=k1jdP2nX0stZsZ47SIzQ1YGCdGfwC59DhTgzOLWeVmRtC80qh7nDrkgN+WyHvWnA1YuqxMc7kYLF14yQHsmyKsrOHgMxARu4fZ1Cx/lHrVux1LJeMS+Fux9uJ++0y5BnEcxXIzWx21JC8yYFOYH/0b1W8UQjPJpyYSzVG3YJNLg=
Received: from DM6PR12MB3035.namprd12.prod.outlook.com (2603:10b6:5:3a::24) by
 SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 06:33:49 +0000
Received: from DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::ed0a:df34:1fa5:b78b]) by DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::ed0a:df34:1fa5:b78b%7]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 06:33:49 +0000
From: "Wang, YuBiao" <YuBiao.Wang@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Force signal hw_fences that are embedded
 in non-sched jobs
Thread-Topic: [PATCH v2] drm/amdgpu: Force signal hw_fences that are embedded
 in non-sched jobs
Thread-Index: AQHZUi8BTpMglCqjKUWRyb/WrP2lla70PgmAgAWaVQA=
Date: Tue, 14 Mar 2023 06:33:48 +0000
Message-ID: <DM6PR12MB303591B3C5307E4E8FA7075FE5BE9@DM6PR12MB3035.namprd12.prod.outlook.com>
References: <20230309022707.4141252-1-YuBiao.Wang@amd.com>
 <2669032f-5780-6eab-d5a0-c0075109bb2c@amd.com>
In-Reply-To: <2669032f-5780-6eab-d5a0-c0075109bb2c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3035:EE_|SA1PR12MB8119:EE_
x-ms-office365-filtering-correlation-id: 436bfa0b-e448-4c8a-b825-08db245611d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZnjlhhbPm4kpHcJTFAxmMyCullHt/TvS6jzWQlYGHUHR18tSUIU/tyQOmoWnET9dLE8wyOGTr6pbfKhB6uQiPO9QzCWrj1wKfd+hfnQyag29mFp6oOalQ2E/Fn4hqRmgao/9w+1240qr22t4sbkHBcgyY7kmgLahbYwBZeoyFs07Zc9F1RXSkMyOwjhiVZ9ZY4ubwpih6i3ZBqmUBg0fY/5QWQaw2UGfsfRrPiH6viMUfiCOAxUKi0AjNQLXum/9IA5ME3xX+rrIK6oz7eWedek1bhdshc5OFAEi82yE0WNmxntc+ddqT9H58IMuxzFZ9B2wJ9r2YDrXkMhzIGQdWscEvnesVyrVij73aVxuhzMWihoq0IheMnGrt54xFWDMf06AjKWFPutQE/YquVsX+g8pIIFj8hbm/idyMDTezSaFUEC5LnyyE+ae47f45kxypzlNJ4fyBgtVxcBL0kA8QlJrz2o+30vT1min9Kix30zjtuGcmJPEANiO2BrQ12ZbAbtsmmuFmAoApKowlP9ELwaLYWz/XGWx2mVCNw6LzUz0RP5sDMMKvDB7f3B6LmMh6G+7t4V+uLTTK3qFElGWdDyTJP0IME9gzE2uQtOEfA3ZLsT43mnh3wUGeSkkmuxupq/oE5wDZYHJ9W1Ny8qz+sTzZNEo9r2DUs23qBZQnXEPp9vtURg3Bjc0NovzbmpM9eFPQpX0fXSEhrJ/xSqWzg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199018)(8936002)(2906002)(41300700001)(6862004)(66556008)(5660300002)(66946007)(66476007)(66446008)(64756008)(8676002)(4326008)(76116006)(52536014)(478600001)(83380400001)(54906003)(6636002)(316002)(7696005)(6506007)(71200400001)(53546011)(26005)(186003)(9686003)(55016003)(122000001)(33656002)(86362001)(38100700002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzNJYmR0UTc3OGZlbXVEVXpEeWFjYVJiQjQ3ZW13NzNPVTJ2V0lQaFpVSThP?=
 =?utf-8?B?S2xvcDRvNm5VbytrL1NqUTN5enNVdlpDR2lmcHZOb2tWQ3RNVWNmMFFKZE1S?=
 =?utf-8?B?VVdOU2Z0enovYlA2R2VtN0pQTnR5RmxrcFJRcXJkNmgrbUpiWVNDUjdTN0Rm?=
 =?utf-8?B?bks5YjVWd3pOQm1tcDBhQlJlRXh1aTdpRkdteDU5bWFTV1NMbmJUb2hOekc2?=
 =?utf-8?B?ZlM5bWZHb2p2ZlkxNElBR25oTnB4UjRnYm53UFNLTVMwTjl0ZmJYU2REZ3BJ?=
 =?utf-8?B?NkNJc3ZOSmpPYytDZVlzU21RZWFqTnlsRUJFMVVPOFI0NEFOTXptVmNpQi9C?=
 =?utf-8?B?REV3ODV1VXZxZVpxZERTRWRzVExiN2xJeEJuY3NBcmZqenRoN0VIVUNKNXdY?=
 =?utf-8?B?V01vRW1ITUtIQk5BSmJrNGpaQjFWeXkzYWdHSmhKN2VMaCtGYXc5bU5GR3BG?=
 =?utf-8?B?OENrVnZCUExxUktPVWhJdTVmbWJrbVpUa3ppSFFDSnYzTUM4OVdHb0F5RzZG?=
 =?utf-8?B?N2ZmRyt6cHRRNzdlWElIampNNFVWUFlRSTZkVmJiZDJ5TWYzaEJ2VEJuVXFv?=
 =?utf-8?B?WmpzdDJxWUZselBOUHRQK3NPZXNiUDFST0RRYVZUWDRDVGdNR0Nzd1FWNXA4?=
 =?utf-8?B?MURNUDZmWFRVVU9MY3dwak1QNzBiM0RaeldkbTh3RVdHekUxaVRFRjI2RmJ6?=
 =?utf-8?B?RERtR0IweUdEQm9rcCtsZzRlT21IRlJFWnAyUXJYVXFPa2lBVjRtRUwrbDNS?=
 =?utf-8?B?ZC9FMUREYkJxYXg1SlRUZXlXcWVidGtUQTZpZkZ1OVhqdUpsS3JzTERrUFNL?=
 =?utf-8?B?U1Ryemk2ZjRtRzFOV1dQWnBtYVF5ZER3RVhmWXZRWFRJRmF0eUNPbk1aSE45?=
 =?utf-8?B?ZkdCME5IRjFiUWVsVU9HUzkxcEhMWjJFd1VUNVc5M2lnY3E4S0w2Q3ZaV0w0?=
 =?utf-8?B?RjR3cnhocmdER2ZyeGdrNThwenAvUGVWMW45aStPdGFyWHZWczRPYThxOHR2?=
 =?utf-8?B?b21lMUZVa3NXYkhNOFl4U2pkTE5uYXNpeldySHF0R3RTMUpuTmVjVGpvaUF0?=
 =?utf-8?B?ZlBRaDF6UnBQbDU3RXhCc0hQZjhNck9mRytZRnlVNXh0OWxvcDRhZVJ6S0dF?=
 =?utf-8?B?RkxXRDZNVUpVWHBZekJYbThCME5KeVJZaFZRSUMwT25XS3YzQTBESzdUWGpn?=
 =?utf-8?B?WjV0RUpPTzZwMDlhUENwTkVUcGR0V3ArVDd4MzUzVlFqeE5ub3BRMFBZQ1dq?=
 =?utf-8?B?Z2wwYU9abkE0U29WSGRqbStqMlpyY3l6NTJYOGI2NVVtUXRJdEdZV1JNa1Ro?=
 =?utf-8?B?aGJhcGJjZmlxTzBJMnlhbmttcWc3NGlIVWx3QWcyS2d0bDZFRmQwajJZYlVv?=
 =?utf-8?B?OVhKTjZEcFF3SlNVSGtjdndrZU5tdWdIR0dSYVZyeTkzd1Z1UnRZMzR2UTlH?=
 =?utf-8?B?RWdURnlLb1JLZGZEZFJkUzdJV0VJZ2JKWjQ5RDJ3ejJZaTZLR0x0K1RYMm5v?=
 =?utf-8?B?aHU5MzJJTTBqVjVJS1ovVEdlNGhpRUE3OUQ1NWF2a1JBS1J1UEhKZ3BVTTJX?=
 =?utf-8?B?RElCZnYxdFRLczVSbWwrWjduK1V6cUo4UTA2QUlNY05NbW9WUy96ZUF6M3ho?=
 =?utf-8?B?WG90REZFc1JZRDJNdWFhZTI3K0laYnpJZjhxZTZZb1JCd3JNdHJLbGQrUFY0?=
 =?utf-8?B?SmtWSXRtRWM0TkN6NGJjam5nYXFIeUlaai8rL2w1WVM5eDExWDhRWVhtRERC?=
 =?utf-8?B?eFNRTnE2MmZLQ01nZlJvYUFKMytyQ3J5MFRqU1RlMXJPZkFQRWYxeWptK1ZF?=
 =?utf-8?B?dGJRbnRtWVpsc3dibVE4OE42M29QdGdpZ21kMkVhOEJTTGd6b1dMWlY2bmFZ?=
 =?utf-8?B?VERwVWlJOFoveUNoQS9ZaEQ1UW5XcnlLU2NBSHBNenpDTi9qVDIrR01oNEd6?=
 =?utf-8?B?ejRydmRzYjFFY21ub0pUSVVheXZSK0M3UVk4ek9ES0szYW1LQjhibDQ4NDIr?=
 =?utf-8?B?QWt3cGFrQjlQb3Axa2llOTB5OWI5alI3SG5hWkdyelhKRkNrV0dsOG5XNkhi?=
 =?utf-8?B?ejEyVU5sb1dZblpaY2kwdlVYcTZNMDZLNkZHSmdvK0hId05VNnFuM1VraHRM?=
 =?utf-8?Q?y1EWrWQ0mtsXLTZ7MMS+Lrkh7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436bfa0b-e448-4c8a-b825-08db245611d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 06:33:48.7619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8+j1kzmldY0zJ23xCnNEuqhS6iIafonzW38hxNV/mC3BhLu1VFT0DR5nHBiKDh3hos0Bpo+TyY1CPfQU7jXLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119
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
Cc: "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, 
 Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgTHViZW4sDQoNCkknZCBoYXZlIHRvIHBpbmcgeW91IGJlY2F1c2Ugd2UndmUgZ290IGEgUDEg
dGlja2V0IGN1cnJlbnRseSBvbiB0aGlzIGlzc3VlLiBXb3VsZCB5b3UgcGxlYXNlIGdpdmUgYSB2
YWd1ZSB0aW1lIHdoZW4gd291bGQgeW91IGNvbmZpcm0gd2hldGhlciB0aGlzIHBhdGNoIGlzIHNh
ZmU/IFRoYW5rIHlvdSBhIGxvdCBmb3IgaGVscGluZyBkb3VibGUgY2hlY2sgdGhpcy4NCg0KUmVn
YXJkcyAmIFRoYW5rcywNCll1YmlhbyANCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IFR1aWtvdiwgTHViZW4gPEx1YmVuLlR1aWtvdkBhbWQuY29tPiANClNlbnQ6IFNhdHVyZGF5
LCBNYXJjaCAxMSwgMjAyMyAxMjo1NiBBTQ0KVG86IFdhbmcsIFl1QmlhbyA8WXVCaWFvLldhbmdA
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogUXVhbiwgRXZhbiA8
RXZhbi5RdWFuQGFtZC5jb20+OyBDaGVuLCBIb3JhY2UgPEhvcmFjZS5DaGVuQGFtZC5jb20+OyBL
b2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT47IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT47IFh1LCBGZWlm
ZWkgPEZlaWZlaS5YdUBhbWQuY29tPjsgV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5n
QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBGb3JjZSBzaWdu
YWwgaHdfZmVuY2VzIHRoYXQgYXJlIGVtYmVkZGVkIGluIG5vbi1zY2hlZCBqb2JzDQoNCk9uIDIw
MjMtMDMtMDggMjE6MjcsIFl1QmlhbyBXYW5nIHdyb3RlOg0KPiB2MjogQWRkIGNvbW1lbnRzIHRv
IGNsYXJpZnkgaW4gdGhlIGNvZGUuDQo+IA0KPiBbV2h5XQ0KPiBGb3IgZW5naW5lcyBub3Qgc3Vw
cG9ydGluZyBzb2Z0IHJlc2V0LCBpLmUuIFZDTiwgdGhlcmUgd2lsbCBiZSBhIA0KPiBmYWlsZWQg
aWIgdGVzdCBiZWZvcmUgbW9kZSAxIHJlc2V0IGR1cmluZyBhc2ljIHJlc2V0LiBUaGUgZmVuY2Vz
IGluIA0KPiB0aGlzIGNhc2UgYXJlIG5ldmVyIHNpZ25hbGVkIGFuZCBuZXh0IHRpbWUgd2hlbiB3
ZSB0cnkgdG8gZnJlZSB0aGUgDQo+IHNhX2JvLCBrZXJuZWwgd2lsbCBoYW5nLg0KPiANCj4gW0hv
d10NCj4gRHVyaW5nIHByZV9hc2ljX3Jlc2V0LCBkcml2ZXIgd2lsbCBjbGVhciBqb2IgZmVuY2Vz
IGFuZCBhZnRlcndhcmRzIHRoZSANCj4gZmVuY2VzJyByZWZjb3VudCB3aWxsIGJlIHJlZHVjZWQg
dG8gMS4gRm9yIGRybV9zY2hlZF9qb2JzIGl0IHdpbGwgYmUgDQo+IHJlbGVhc2VkIGluIGpvYl9m
cmVlX2NiLCBhbmQgZm9yIG5vbi1zY2hlZCBqb2JzIGxpa2UgaWJfdGVzdCwgaXQncyANCj4gbWVh
bnQgdG8gYmUgcmVsZWFzZWQgaW4gc2FfYm9fZnJlZSBidXQgb25seSB3aGVuIHRoZSBmZW5jZXMg
YXJlIA0KPiBzaWduYWxlZC4gU28gd2UgaGF2ZSB0byBmb3JjZSBzaWduYWwgdGhlIG5vbl9zY2hl
ZCBiYWQgam9iJ3MgZmVuY2UgDQo+IGR1cmluZyBwcmVfYXNpY19yZXNldCBvciB0aGUgY2xlYXIg
aXMgbm90IGNvbXBsZXRlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWXVCaWFvIFdhbmcgPFl1Qmlh
by5XYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2ZlbmNlLmMgfCA4ICsrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2ZlbmNlLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMN
Cj4gaW5kZXggZmFmZjRhM2Y5NmU2Li5hZDdjNWI3MGMzNWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jDQo+IEBAIC02NzMsNiArNjczLDcgQEAgdm9p
ZCBhbWRncHVfZmVuY2VfZHJpdmVyX2NsZWFyX2pvYl9mZW5jZXMoc3RydWN0IA0KPiBhbWRncHVf
cmluZyAqcmluZykgIHsNCj4gIAlpbnQgaTsNCj4gIAlzdHJ1Y3QgZG1hX2ZlbmNlICpvbGQsICoq
cHRyOw0KPiArCXN0cnVjdCBhbWRncHVfam9iICpqb2I7DQo+ICANCj4gIAlmb3IgKGkgPSAwOyBp
IDw9IHJpbmctPmZlbmNlX2Rydi5udW1fZmVuY2VzX21hc2s7IGkrKykgew0KPiAgCQlwdHIgPSAm
cmluZy0+ZmVuY2VfZHJ2LmZlbmNlc1tpXTsNCj4gQEAgLTY4MCw2ICs2ODEsMTMgQEAgdm9pZCBh
bWRncHVfZmVuY2VfZHJpdmVyX2NsZWFyX2pvYl9mZW5jZXMoc3RydWN0IGFtZGdwdV9yaW5nICpy
aW5nKQ0KPiAgCQlpZiAob2xkICYmIG9sZC0+b3BzID09ICZhbWRncHVfam9iX2ZlbmNlX29wcykg
ew0KPiAgCQkJUkNVX0lOSVRfUE9JTlRFUigqcHRyLCBOVUxMKTsNCj4gIAkJCWRtYV9mZW5jZV9w
dXQob2xkKTsNCj4gKwkJCS8qIEZvciBub24tc2NoZWQgYmFkIGpvYiwgaS5lLiBmYWlsZWQgaWIg
dGVzdCwgd2UgbmVlZCB0byBmb3JjZQ0KPiArCQkJICogc2lnbmFsIGl0IHJpZ2h0IGhlcmUgb3Ig
d2Ugd29uJ3QgYmUgYWJsZSB0byB0cmFjayB0aGVtIGluIGZlbmNlIGRydg0KPiArCQkJICogYW5k
IHRoZXkgd2lsbCByZW1haW4gdW5zaWduYWxlZCBkdXJpbmcgc2FfYm8gZnJlZS4NCj4gKwkJCSAq
Lw0KPiArCQkJam9iID0gY29udGFpbmVyX29mKG9sZCwgc3RydWN0IGFtZGdwdV9qb2IsIGh3X2Zl
bmNlKTsNCj4gKwkJCWlmICgham9iLT5iYXNlLnNfZmVuY2UgJiYgIWRtYV9mZW5jZV9pc19zaWdu
YWxlZChvbGQpKQ0KPiArCQkJCWRtYV9mZW5jZV9zaWduYWwob2xkKTsNCg0KQ29uY2VwdHVhbGx5
LCBJIGRvbid0IG1pbmQgdGhpcyBwYXRjaCBmb3Igd2hhdCBpdCBkb2VzLiBUaGUgb25seSB0aGlu
ZyB3aGljaCB3b3JyaWVzIG1lIGlzIHRoaXMgY2hlY2sgaGVyZSwgIWpvYi0+YmFzZS5zX2ZlbmNl
LCB3aGljaCBpcyB1c2VkIGhlcmUgdG8gcXVhbGlmeSB0aGF0IHdlIGNhbiBzaWduYWwgdGhlIGZl
bmNlIChhbmQgb2YgY291cnNlIHRoYXQgdGhlIGZlbmNlIGlzIG5vdCB5ZXQgc2lnbmFsbGVkLikg
V2UgbmVlZCB0byBhdWRpdCB0aGlzIGNoZWNrIHRvIG1ha2Ugc3VyZSB0aGF0IGl0IGlzIG5vdCBv
dmVybG9hZGVkIHRvIG1lYW4gb3RoZXIgdGhpbmdzLiBJJ2xsIHRha2UgYSBsb29rLg0KDQo+ICAJ
CX0NCj4gIAl9DQo+ICB9DQoNCi0tDQpSZWdhcmRzLA0KTHViZW4NCg0K
