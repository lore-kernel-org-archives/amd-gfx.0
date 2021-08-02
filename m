Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2ECC4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 08:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279AA60C3F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 08:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 279AA60C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05B26E069;
	Mon,  2 Aug 2021 08:23:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C3136E069
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 08:23:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLHGOrThxnGYM/m9/MaIKj+47qz4+SKkbbidahKaqxnaePAGUh0dqQvqY5by+CVBdj6yjGPuVDRBZL3cC35mQTijkT3Mv3QKKVb0u7bbxSrL7S0B9bwRWeYZnwMpuKfMPUF4cR08u1sHP6jrJG7YM6FL+DjqGIUHGRTCBxARzRr1DWdee1F2uymqnBXhjVP5rkCLb7CgATr+fvG+mrXilMq7kXsG2detmTvhn3D0USa4y81N6t7LK3RfZrSGWqe0jORDzEsvPsyVuLJVsm5Q4XnZ0vKQiS/9i8/iS6P5eMuC7NSVIGU2eSwdPp21dpttYcrAj4Yawqu54G4w4WXnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOORppbvk2gQtiV/nKKyHAn6y661Trc08hvAbnOA+6Q=;
 b=IGC3ZUvkLJm4T0uLjfa2JZoVT74b6nWJ+DtjeqkhjZ/UZFHdjySUpuN53nZ8x5AMvwX/ZlRZ6QBOb6gpLnojwzjr0XYiCfTLyYCJFDtLDbli3PvPU0Ik3sq0NVrHlJi2eCCebaSF141pjkPOUVWAUERGH+KiPym0kBMfib+KM+d31vXxI+VdZFdt9WyEBrR285aQbtIc87QXWWUJFWJwA+y6OgwPg8mFOf61NzbnLlTSJntjR0IxcMBi69N2dkT0gv4OYL0dU3mfvcK3AF8wgs8M4VqZrVG1s0xljCVO4oVphfxD5uot2Cef9JK/OjZ0Qt2+rktykMTAKz32JNkdwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOORppbvk2gQtiV/nKKyHAn6y661Trc08hvAbnOA+6Q=;
 b=n02eCtjoyGiRcvsj029rhElNHd1IxtkQB6RN1PHoBUV3J2kOMoFmKgstyrLkkw7RiywLKq7sfT8jfWvCcvSXWs4lZvzu4ELaBx5YKukFWa6jy9a5SD5AE1LwxS3kvxfG7UoEZeOBC8gAzyr2F6NiwmHOVL+1W1LqR22z0EEDGjg=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Mon, 2 Aug 2021 08:23:31 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 08:23:31 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Gao, Likun"
 <Likun.Gao@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test (v2)
Thread-Topic: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test (v2)
Thread-Index: AQHXh12IB96Cm6kAd0+4i+qoX2BuqKtfyE6AgAAXjgA=
Date: Mon, 2 Aug 2021 08:23:31 +0000
Message-ID: <DM5PR12MB2469A94D544647D893DA0FAAF1EF9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210802051602.23822-1-guchun.chen@amd.com>
 <b7218d98-9eb1-2d41-157a-bc417ef496ab@gmail.com>
In-Reply-To: <b7218d98-9eb1-2d41-157a-bc417ef496ab@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-02T08:23:28Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9999e427-7739-4dfa-884b-e9d20734148e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a57a4ca-0b6b-4331-5e35-08d9558ed05c
x-ms-traffictypediagnostic: DM6PR12MB4075:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4075669DB391B815DA8E8866F1EF9@DM6PR12MB4075.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lf/S1SUeYGoNXzPQSta8ZzNomvzxWCeidcW2tGDWZKASqjSJ4/kRvT7i2VCNcb69Chn41Fm8Kiqgn6ccEto6Tg0VGeos+x/42WX/uwVSMgggQgTxQ2A5mw7pD2/jPm55o4b8b7RkAnENFmINbfPFXXvAp94+CKtrc55kf3UeglbjKAj8crCYGoImV+rEP5yR+fD4R6S8LgR9IUarlGHYVHMWTOl5wuRKEXmUulhcFQKfcb4jEk3dbvpvUOEKtPP1Of/uTsXgLp8LeqbsIOsyI9t/LWt4CxNU8+2SIc+o9xF+egof4yn1RZ4QtLiJQKPED4/Ib0FxJTAwgwHvAZu/dEsOJtIn2PKrRckU8ozBC38c7usRbWIpqa7LRhXhE91v3AuxRQTcJ5GhVDAFcgXAx/BfijgpHfyZk/xbh/WG+bR7KFQiOsdyxzUoWQC0tF+GSXb0clt/tIcOw4C77SGBjvLghioRzRwy5801lVMoOQ2cK4WvvdN5yI+AwSm7yguwyFcAZdxtQlnA6Y13tyHjkzsP7Ch0HRQTl6ztY/D65m0DYR2VNtOZLC2CsF3rFBLR7ndHEn438+4tLyQI+23fxzpdxu49jhoTYhoMu3W5n2v3uxnr0coi2SxpmRlfiACsbi01hvU209HCpNozG0C/QVlZjI6bA51ID05aNnkiQlx9UjQab5YJxY3CPWc9rbOmZONL7hvkI+9y43wF6znWSSQUqQzlr7hQzhlBfeaFTnU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(921005)(76116006)(9686003)(86362001)(478600001)(122000001)(33656002)(2906002)(186003)(38070700005)(6636002)(26005)(52536014)(7696005)(110136005)(66574015)(66476007)(66556008)(8936002)(8676002)(83380400001)(66446008)(64756008)(66946007)(316002)(38100700002)(55016002)(71200400001)(5660300002)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXdScWs3bjUzUEFKNVh4RXluenZZRU0vYzRpMFdnRTRxSmVCaGdBdHpaRHdv?=
 =?utf-8?B?d3NJK1JVUkdwWExRd0RzV3dEWk1ZVC9wWmx1ZGF4Ym5xNkZKMGxZeEZWeDR2?=
 =?utf-8?B?T1hpWjJpcXpFUkRHMkp0a3dvaVhOMEdFcitNTTU0RmVqZFVwL1hKbjBaRVdi?=
 =?utf-8?B?ZEM0amtvVXAzT3gxdUk4V0tHWGtWRjVGaXROYmpPa1dWdlNZVzF6anQybFdZ?=
 =?utf-8?B?QW5MTzhwaW00THdlbTVnMlN2d2tKSFlkZXpvMm1INWZ3am9OQ1lhQTVHdFg3?=
 =?utf-8?B?dHJlWmp6dGJ6dURtSzMxZWVqUktUd3V4QW9ESUYxcjZ4cUNvVmZjWHVYbjJP?=
 =?utf-8?B?WWYxd3JsNElnQ2FLbEVmaWhLUnNIcmt5YmxaUUI3UGo0VDNPRGE5aUxmMnNt?=
 =?utf-8?B?RmFKdFI2UG5Ja2duUW53T1lGNnpLMmkyQ2psWW1TWVc1N2pmZC9XTzBTaTA3?=
 =?utf-8?B?Y1Q3WE9Pazd1aVQzN0x1MWxtOE42Q2pCMkpoZXJQS05ZQVVDRE0rSHpnZHNi?=
 =?utf-8?B?NVBjakplc244d3RFZjRiTUR4enRwWDdhbW01cHpNNlJhSm1tTUh3VW1ZRmQx?=
 =?utf-8?B?TzNVN1ZieU5DYU5LNGdCYjlHd2tGYUlTTUoyTzdsekhna0s1QXNSTGtHcEJC?=
 =?utf-8?B?R1cxRlNQcFdja0VZaTJZMERGSmRxSlZSZlAvZldjZElEYjB4RmdXSjJXS1Ar?=
 =?utf-8?B?NzhEdnBrck55Uzdmd0hzR2Ewd084dG9GQm9ycHZFS0FBWm1hYzR6YzhVUVVU?=
 =?utf-8?B?NGFLTkZBZUZyUEg5MjVpaDcrY0pIYXQzUHpuS0twZncwdjF0ZFVlSnlnRDVq?=
 =?utf-8?B?WklCYzVnMW1zQnpiU3JNTzllNTFKWk96eS9FY1VvMWhzNVNtbnVyeGxiRVNC?=
 =?utf-8?B?TjBlYWxCaWFNMHlMdlZGSWxSbVlNdWpqakx6akF2RXl2UnMwMEVOWHc4RE5Y?=
 =?utf-8?B?UkRPM2lRckd1VXl6M0QvS1VMWVVDSVlPTjZHNUZyNWowZmhFdTdPdWdpa3VM?=
 =?utf-8?B?TkZkVHovdHdwV09rOTIzenZmUkhZaDJ3dU96eXlWbXFPMHlxR3FVQUl4aXdX?=
 =?utf-8?B?Q0EzekRyNGg5MlgySExZMlIwRkZWUXhyOU5rSlBZcVYxTzhLUDczb0lDL0hn?=
 =?utf-8?B?YkVFblVuMWtick41R2g4WmpYOVZBTDJWcnlBQmIyQ0RRYlRJZHlhM0NZdTBU?=
 =?utf-8?B?Y2xOdGVLVmh0c3Q3cW9velZvQXE1QUptMHJZMnZsNmJqMndFQndzMmlNR3Yr?=
 =?utf-8?B?c2RxMlptbVFINzF6TXBudzB2T3JGZFhlbXhFRzhJek9kOU1yR1laamhWTHdH?=
 =?utf-8?B?cVhCQmpjdVVVQUZGS3JLemdibHFlVUNYNlBRU0lHMDhsRVFrZWFLQXdpRUwx?=
 =?utf-8?B?N0p0bkRjQmtJWUN4SEQ2RnpQOVdxRFBHVDNacFRKbExpcWxvYlF1M3duaG8v?=
 =?utf-8?B?eVQzemFjalRpRnZGbFJOVjVMWGpTY2pDNmtDRmc4eUxDYW5SZlZWSTZtUU56?=
 =?utf-8?B?UnU0ZlZrK3BxV0NubjdyNjJQUmE3c3ZUSlJ0dDI2SW80dmYvZCszLzJ2OFV3?=
 =?utf-8?B?Z3ZHRFRyRzk3ZjNlNDdMTFN5UUc0MDJxaTFtaU5Qa2l3YkJ3Q3MvRlpuVTVi?=
 =?utf-8?B?TVhmYlUvM1VGcjBrYmNSZm83aVg0Q3VpbnY1c0M0VHVBRFA4ZXU1dXhlVGox?=
 =?utf-8?B?UXFzV3hWbG5rTlhraVI1WjR5bnN5WC96QUd1aVZ0NlZJbng5LzlNWnViV24z?=
 =?utf-8?Q?6FWCzVXpBzRlwlur/GMuc31dB9cskFJxw0wa5Wc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a57a4ca-0b6b-4331-5e35-08d9558ed05c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 08:23:31.7658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9tF6RMSDPdMy311uhECmjpiCyCvz25zlieRsvXJSIdsUcE8a0nJHOPMNFUHnUJksYlju/4ywbi1sJtwZr99oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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

W1B1YmxpY10NCg0KVGhhbmsgeW91LCBDaHJpc3RpYW4uDQoNClJlZ2FyZGluZyBmZW5jZV9kcnYu
aW5pdGlhbGl6ZWQsIGl0IGxvb2tzIHRvIGEgYml0IHJlZHVuZGFudCwgYW55d2F5IGxldCBtZSBs
b29rIGludG8gdGhpcyBtb3JlLg0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVy
a2VuQGdtYWlsLmNvbT4gDQpTZW50OiBNb25kYXksIEF1Z3VzdCAyLCAyMDIxIDI6NTYgUE0NClRv
OiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsgR2FvLCBMaWt1biA8TGlrdW4uR2FvQGFtZC5jb20+OyBLb2VuaWcsIENocmlz
dGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcu
WmhhbmdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGF2b2lkIG92ZXItaGFuZGxl
IG9mIGZlbmNlIGRyaXZlciBmaW5pIGluIHMzIHRlc3QgKHYyKQ0KDQpBbSAwMi4wOC4yMSB1bSAw
NzoxNiBzY2hyaWViIEd1Y2h1biBDaGVuOg0KPiBJbiBhbWRncHVfZmVuY2VfZHJpdmVyX2h3X2Zp
bmksIG5vIG5lZWQgdG8gY2FsbCBkcm1fc2NoZWRfZmluaSB0byBzdG9wIA0KPiBzY2hlZHVsZXIg
aW4gczMgdGVzdCwgb3RoZXJ3aXNlLCBmZW5jZSByZWxhdGVkIGZhaWx1cmUgd2lsbCBhcnJpdmUg
DQo+IGFmdGVyIHJlc3VtZS4gVG8gZml4IHRoaXMgYW5kIGZvciBhIGJldHRlciBjbGVhbiB1cCwg
bW92ZSANCj4gZHJtX3NjaGVkX2ZpbmkgZnJvbSBmZW5jZV9od19maW5pIHRvIGZlbmNlX3N3X2Zp
bmksIGFzIGl0J3MgcGFydCBvZiANCj4gZHJpdmVyIHNodXRkb3duLCBhbmQgc2hvdWxkIG5ldmVy
IGJlIGNhbGxlZCBpbiBod19maW5pLg0KPg0KPiB2MjogcmVuYW1lIGFtZGdwdV9mZW5jZV9kcml2
ZXJfaW5pdCB0byBhbWRncHVfZmVuY2VfZHJpdmVyX3N3X2luaXQsIHRvIA0KPiBrZWVwIHN3X2lu
aXQgYW5kIHN3X2ZpbmkgcGFpcmVkLg0KPg0KPiBGaXhlczogY2Q4N2E2ZGNmNmFmIGRybS9hbWRn
cHU6IGFkanVzdCBmZW5jZSBkcml2ZXIgZW5hYmxlIHNlcXVlbmNlDQo+IFN1Z2dlc3RlZC1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4NCg0KSXQncyBhIGJpdCBhbWJp
Z3VvdXMgbm93IHdoYXQgZmVuY2VfZHJ2LmluaXRpYWxpemVkIG1lYW5zLCBidXQgSSB0aGluayB3
ZSBjYW4gbGl2ZSB3aXRoIHRoYXQgZm9yIG5vdy4NCg0KUGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uDQoNClJlZ2FyZHMsDQpD
aHJpc3RpYW4uDQoNCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jIHwgIDUgKystLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZmVuY2UuYyAgfCAxMiArKysrKysrLS0tLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmluZy5oICAgfCAgNCArKy0tDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gaW5kZXggYjFkMmRjMzllOGJlLi45ZTUzZmY4
NTE0OTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMNCj4gQEAgLTM2NDYsOSArMzY0Niw5IEBAIGludCBhbWRncHVfZGV2aWNlX2luaXQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgDQo+ICphZGV2LA0KPiAgIA0KPiAgIGZlbmNlX2RyaXZlcl9pbml0Og0K
PiAgIAkvKiBGZW5jZSBkcml2ZXIgKi8NCj4gLQlyID0gYW1kZ3B1X2ZlbmNlX2RyaXZlcl9pbml0
KGFkZXYpOw0KPiArCXIgPSBhbWRncHVfZmVuY2VfZHJpdmVyX3N3X2luaXQoYWRldik7DQo+ICAg
CWlmIChyKSB7DQo+IC0JCWRldl9lcnIoYWRldi0+ZGV2LCAiYW1kZ3B1X2ZlbmNlX2RyaXZlcl9p
bml0IGZhaWxlZFxuIik7DQo+ICsJCWRldl9lcnIoYWRldi0+ZGV2LCAiYW1kZ3B1X2ZlbmNlX2Ry
aXZlcl9zd19pbml0IGZhaWxlZFxuIik7DQo+ICAgCQlhbWRncHVfdmZfZXJyb3JfcHV0KGFkZXYs
IEFNREdJTV9FUlJPUl9WRl9GRU5DRV9JTklUX0ZBSUwsIDAsIDApOw0KPiAgIAkJZ290byBmYWls
ZWQ7DQo+ICAgCX0NCj4gQEAgLTM5ODgsNyArMzk4OCw2IEBAIGludCBhbWRncHVfZGV2aWNlX3Jl
c3VtZShzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBib29sIGZiY29uKQ0KPiAgIAl9DQo+ICAgCWFt
ZGdwdV9mZW5jZV9kcml2ZXJfaHdfaW5pdChhZGV2KTsNCj4gICANCj4gLQ0KPiAgIAlyID0gYW1k
Z3B1X2RldmljZV9pcF9sYXRlX2luaXQoYWRldik7DQo+ICAgCWlmIChyKQ0KPiAgIAkJcmV0dXJu
IHI7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVu
Y2UuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPiBp
bmRleCA0OWM1YzczMzFjNTMuLjc0OTU5MTE1MTZjMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4gQEAgLTQ5OCw3ICs0OTgsNyBAQCBpbnQgYW1k
Z3B1X2ZlbmNlX2RyaXZlcl9pbml0X3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLA0KPiAg
IH0NCj4gICANCj4gICAvKioNCj4gLSAqIGFtZGdwdV9mZW5jZV9kcml2ZXJfaW5pdCAtIGluaXQg
dGhlIGZlbmNlIGRyaXZlcg0KPiArICogYW1kZ3B1X2ZlbmNlX2RyaXZlcl9zd19pbml0IC0gaW5p
dCB0aGUgZmVuY2UgZHJpdmVyDQo+ICAgICogZm9yIGFsbCBwb3NzaWJsZSByaW5ncy4NCj4gICAg
Kg0KPiAgICAqIEBhZGV2OiBhbWRncHUgZGV2aWNlIHBvaW50ZXINCj4gQEAgLTUwOSwxMyArNTA5
LDEzIEBAIGludCBhbWRncHVfZmVuY2VfZHJpdmVyX2luaXRfcmluZyhzdHJ1Y3QgYW1kZ3B1X3Jp
bmcgKnJpbmcsDQo+ICAgICogYW1kZ3B1X2ZlbmNlX2RyaXZlcl9zdGFydF9yaW5nKCkuDQo+ICAg
ICogUmV0dXJucyAwIGZvciBzdWNjZXNzLg0KPiAgICAqLw0KPiAtaW50IGFtZGdwdV9mZW5jZV9k
cml2ZXJfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gK2ludCBhbWRncHVfZmVu
Y2VfZHJpdmVyX3N3X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgew0KPiAg
IAlyZXR1cm4gMDsNCj4gICB9DQo+ICAgDQo+ICAgLyoqDQo+IC0gKiBhbWRncHVfZmVuY2VfZHJp
dmVyX2ZpbmkgLSB0ZWFyIGRvd24gdGhlIGZlbmNlIGRyaXZlcg0KPiArICogYW1kZ3B1X2ZlbmNl
X2RyaXZlcl9od19maW5pIC0gdGVhciBkb3duIHRoZSBmZW5jZSBkcml2ZXINCj4gICAgKiBmb3Ig
YWxsIHBvc3NpYmxlIHJpbmdzLg0KPiAgICAqDQo+ICAgICogQGFkZXY6IGFtZGdwdSBkZXZpY2Ug
cG9pbnRlcg0KPiBAQCAtNTMxLDggKzUzMSw3IEBAIHZvaWQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9o
d19maW5pKHN0cnVjdCANCj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICANCj4gICAJCWlmICgh
cmluZyB8fCAhcmluZy0+ZmVuY2VfZHJ2LmluaXRpYWxpemVkKQ0KPiAgIAkJCWNvbnRpbnVlOw0K
PiAtCQlpZiAoIXJpbmctPm5vX3NjaGVkdWxlcikNCj4gLQkJCWRybV9zY2hlZF9maW5pKCZyaW5n
LT5zY2hlZCk7DQo+ICsNCj4gICAJCS8qIFlvdSBjYW4ndCB3YWl0IGZvciBIVyB0byBzaWduYWwg
aWYgaXQncyBnb25lICovDQo+ICAgCQlpZiAoIWRybV9kZXZfaXNfdW5wbHVnZ2VkKCZhZGV2LT5k
ZGV2KSkNCj4gICAJCQlyID0gYW1kZ3B1X2ZlbmNlX3dhaXRfZW1wdHkocmluZyk7IEBAIC01NjAs
NiArNTU5LDkgQEAgdm9pZCANCj4gYW1kZ3B1X2ZlbmNlX2RyaXZlcl9zd19maW5pKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIAkJaWYgKCFyaW5nIHx8ICFyaW5nLT5mZW5jZV9kcnYu
aW5pdGlhbGl6ZWQpDQo+ICAgCQkJY29udGludWU7DQo+ICAgDQo+ICsJCWlmICghcmluZy0+bm9f
c2NoZWR1bGVyKQ0KPiArCQkJZHJtX3NjaGVkX2ZpbmkoJnJpbmctPnNjaGVkKTsNCj4gKw0KPiAg
IAkJZm9yIChqID0gMDsgaiA8PSByaW5nLT5mZW5jZV9kcnYubnVtX2ZlbmNlc19tYXNrOyArK2op
DQo+ICAgCQkJZG1hX2ZlbmNlX3B1dChyaW5nLT5mZW5jZV9kcnYuZmVuY2VzW2pdKTsNCj4gICAJ
CWtmcmVlKHJpbmctPmZlbmNlX2Rydi5mZW5jZXMpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuaCANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmluZy5oDQo+IGluZGV4IDI3YWRmZmE3NjU4ZC4uOWMxMWNlZDQzMTJj
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5o
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmgNCj4gQEAg
LTEwNiw3ICsxMDYsNiBAQCBzdHJ1Y3QgYW1kZ3B1X2ZlbmNlX2RyaXZlciB7DQo+ICAgCXN0cnVj
dCBkbWFfZmVuY2UJCSoqZmVuY2VzOw0KPiAgIH07DQo+ICAgDQo+IC1pbnQgYW1kZ3B1X2ZlbmNl
X2RyaXZlcl9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4gICB2b2lkIGFtZGdw
dV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcp
Ow0KPiAgIA0KPiAgIGludCBhbWRncHVfZmVuY2VfZHJpdmVyX2luaXRfcmluZyhzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcsIEBAIA0KPiAtMTE1LDkgKzExNCwxMCBAQCBpbnQgYW1kZ3B1X2ZlbmNl
X2RyaXZlcl9pbml0X3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLA0KPiAgIGludCBhbWRn
cHVfZmVuY2VfZHJpdmVyX3N0YXJ0X3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLA0KPiAg
IAkJCQkgICBzdHJ1Y3QgYW1kZ3B1X2lycV9zcmMgKmlycV9zcmMsDQo+ICAgCQkJCSAgIHVuc2ln
bmVkIGlycV90eXBlKTsNCj4gK3ZvaWQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9od19pbml0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4gICB2b2lkIGFtZGdwdV9mZW5jZV9kcml2ZXJfaHdf
ZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQo+ICtpbnQgYW1kZ3B1X2ZlbmNlX2Ry
aXZlcl9zd19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4gICB2b2lkIGFtZGdw
dV9mZW5jZV9kcml2ZXJfc3dfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7IC12b2lk
IA0KPiBhbWRncHVfZmVuY2VfZHJpdmVyX2h3X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpOw0KPiAgIGludCBhbWRncHVfZmVuY2VfZW1pdChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcs
IHN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZSwNCj4gICAJCSAgICAgIHVuc2lnbmVkIGZsYWdzKTsN
Cj4gICBpbnQgYW1kZ3B1X2ZlbmNlX2VtaXRfcG9sbGluZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJp
bmcsIHVpbnQzMl90ICpzLA0K
