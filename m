Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6A2C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398F96108F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 398F96108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F076EB3F;
	Fri, 20 Aug 2021 23:41:56 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E17316EB3F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 23:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGIR+28nvY+uTqLdebZEr0hWL0L1gZQOGwswUvubtTcneQdAQV2fGVN1Vcg8vtKJ+/9EkVOKl8H7X+gSP+SWRBPBiHFobkBIpSxz9vCOLNghUHAhIyLb3CIg37bL4RTR3td/+Hd+XcryUhKfCXALo6yDjw4um02V9DXvloon+fugOwrik0cRUcENcDJYZNx7ZIVa8DxlO3N90dz5sijSxh+JQcMmUVmRQJZ/85Yk3yQ8D9ncIuC5FYZeeczQtnl1Z+MvTTsDE6SaAWLZo/RruN4VZrRVgOd5DZmTz+vQDtMyhVZ8JSS7D9HzHbe1ibV37WmyVytIWBmcGf7XVhBDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61tcqiGwsbsyHmPVA2snDHkXLLmgzlw4L5T0nFkN8NE=;
 b=TrJmyB02GneqYFe0pcQe0b4wlvWW+/sqSNAXZQJEOMtkTBJs7U1jA1J6yV7rY7D7jN1NuB+2BSy/sjfMqnTjY1+qzrgr6aTCOt79P8Wu0xhIpI4QBiNC+CpEn2qke/+3fNrVjIWDsQYbqKRzg07Mq84lW3vtEBycKs7aRNaIJYppFMX3+yot3quJUGr7y5HSM8wy9UwQ5hQNppzr4vQm5JcPxptI3yxzfNU29I+kVvHxjm8f76v6TIN6VsugcgWBkXkK9QmGeX+y4L5SSaKelyc6BaiMKUe3KMRhSgUNfWUHDbeckkGiewVe8/00kBityYm3wXmNStBkA9n3XMY1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61tcqiGwsbsyHmPVA2snDHkXLLmgzlw4L5T0nFkN8NE=;
 b=yUILtm8k72AWX7vmlcQy6nhYRalon8egZgitp9Fqky4Qg6JVgxcBgK53rtDmkHzfP9b2EsUTDpdHzfuGml+TKNN7KlvpqQLzGM3yb/FKwDvJs7pVfnRruMq/AON4EYgwlfirlJFbEQRwJTKJe953mYQReKVGpFgldxj/QkSNHmU=
Received: from SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 by SA0PR12MB4544.namprd12.prod.outlook.com (2603:10b6:806:70::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 23:27:23 +0000
Received: from SN1PR12MB2382.namprd12.prod.outlook.com
 ([fe80::9449:ffb:5eb0:1179]) by SN1PR12MB2382.namprd12.prod.outlook.com
 ([fe80::9449:ffb:5eb0:1179%7]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 23:27:23 +0000
From: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: Use SDMA1 for buffer movement on Aldebaran
Thread-Topic: [PATCH 2/3] drm/amdgpu: Use SDMA1 for buffer movement on
 Aldebaran
Thread-Index: AQHXlYTaRsKjuiwHI0yBJhkuL4uvnat79t6AgAER5rA=
Date: Fri, 20 Aug 2021 23:27:23 +0000
Message-ID: <SN1PR12MB2382668597B787B0D30C8B6FF9C19@SN1PR12MB2382.namprd12.prod.outlook.com>
References: <20210820053245.340945-1-Joseph.Greathouse@amd.com>
 <20210820053245.340945-2-Joseph.Greathouse@amd.com>
 <e61724d5-dddd-bcfb-29f7-8dcd49bc3252@gmail.com>
In-Reply-To: <e61724d5-dddd-bcfb-29f7-8dcd49bc3252@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3159ce7-1fab-4b68-b5a9-08d964321057
x-ms-traffictypediagnostic: SA0PR12MB4544:
x-microsoft-antispam-prvs: <SA0PR12MB454425E86DAE77BFD9F7D7AAF9C19@SA0PR12MB4544.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p7mccMRDYMOWAX2ZRk1JFFB97SOjBL0ssE6BoAteT7BrW+euIVqCWehEKWCAYJO23FUZNUOHLiBmXHeBgjsE4SfDo2k29JwnzdYb/axZKAQw4LYEGL8guWSgYE8tB3WRQFddX/eM7Dmu7wyIy3J8HtoQI+Wc99EvWZJOmejjLEe4MhxDAQsMaV6xn9r0yV5nAp1nbXN0wY33br1KhPOHfOdMT8IiD3T61SimIfyZVMbQM0C8bcQU8ffc6R+2wrZDt9xz4HUI+p0fFJ84JtkrXTRvBFDni7CJzQmhYKi9ovzwziBle23TEEOXI28VOtkGs3lESa7680i5mrXpCZTeYuWjI6jBbaHpdFlpmo9ppMk1oUkyhY7KKBrZeF6atnfkTz6SawCO6EROsbjL6LSp44YaltZQ8HP48+4fjov5tKDWJJzvN5CU9ZvMD5H89T7B2lxLz8X3hqcLYuzPvuJmgVEu7f4F1Topw9qwg82vBzoIAnfN8lG36CQKewQC/WV4ZzZ14a3CLywe+1m2WBBzMLIwLYFtnHYqYQ7p3awBL+Rh9SHidbVjNuGes0bxoZ+0WT5A02HVSxFbdCH9A+zhd/5tiTfsDGWDTuaDIn8UwuVGFvNl7+JouG2o8rmoX9kmMCkWUxDOc2s6m5kUk744Z+gDonibUhrAzyeS7PcHdgcaTYen54XjakECXuWG4YJx2gUmXLeR7DbtbxMHOfZVEA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2382.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(76116006)(64756008)(66446008)(33656002)(316002)(110136005)(66476007)(86362001)(66946007)(122000001)(66556008)(38100700002)(55016002)(9686003)(83380400001)(38070700005)(66574015)(2906002)(26005)(8936002)(186003)(5660300002)(52536014)(6506007)(53546011)(7696005)(8676002)(478600001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjlEYmZGbUFSNCsrRVVySVFRZW50WFlkeGw4Q1A3dVJsUVAxeGpUeWF0ZjdF?=
 =?utf-8?B?WUtLRnRPb3Z5K2V1aDA2SGVsR0JNajhydXIvUU5tSTM4SlRSMERUSTVZUllu?=
 =?utf-8?B?ZUtSUnZDWkh2NXNWSGFMUE01c3RISmttREdBd1hPblFQd0lpa3p2MGFoWllK?=
 =?utf-8?B?MmNONTgzczdoK3ZSZGJ3M3ZvYmdCTDJaQUJZcC8yVEpSeDMvTTVHRFMzeWgv?=
 =?utf-8?B?QmY4VzFZbU1LM29xektIM21IcHJYRGMxa0I0c1IyWnhhUjBmMmJDMW9EYlNF?=
 =?utf-8?B?QTRETWovcW1GNFc4aVVvWmVmd3kyaEYzK3cwVWtNVjhZUjlSdUJ4NXNxcU00?=
 =?utf-8?B?SFUycnRybjZnaGVhQVpVdE5RaWJwNzZvOHRJSEJGazNwSWpoVDgvczFoM1R0?=
 =?utf-8?B?RVJkQUZPREpyNEFhamNKdFAxU3JjbjFxaWJ4YjkrWU1tdkV5Z01rNGxDOXM4?=
 =?utf-8?B?ZXJiRjQ5WkJpRDIrUzFNL3ZGWjNNUFhQUzVLRytVeFpxWGQ3dnF4UC9FZzlH?=
 =?utf-8?B?QWRhRmFoRk1lZFpMVUlZZjBGYis4S1FZeUVWelJ1OE9LTEk3aS96dlZrN3dO?=
 =?utf-8?B?WWg1WVJYMTgxWkVBZWZYQ0dYRlB5YVZZTWU2WHM4cnU1cDdZdWpsNzRjQ3Nm?=
 =?utf-8?B?eGxDOGZMUDl0VWhlZHdqZndoeDZOai9EOThqVkhsWkN4VllnSWJUc2F6TXpw?=
 =?utf-8?B?QXBYUld0eUZHTEFTYTZCaEhOZk15azZxWWdPeGwwcjZsZDIzaks2QkZEZEpF?=
 =?utf-8?B?RkE0Mkx1WDVadWJUR1FRWjBuWm9jNXh4RlF6QXhva2NITG5ON2trMTUyUkZx?=
 =?utf-8?B?eDdMQmdJZkhOUVVkSHNRcXNKeW1sdVFlR3R2K3dqbzBNTzZaUTJCOXp3QWNK?=
 =?utf-8?B?b3pSZDBPMG9tbVlsN0VPR0pmVzRMVnBEUE1IbGl6ZXdISTM5UWRBSEwrZWdF?=
 =?utf-8?B?UnlUdS9oNkkvSGNySnN4bWEwVzhwVVFCT0tGeVlBSlo5d25TbVhDYlVnL04v?=
 =?utf-8?B?disvMXJRRGhCQW8rTGpOcURrRTEvbjJ0b3k0d0xOelllT2NlVTcwYmRObGsr?=
 =?utf-8?B?TjFVeHgzK2xZTTZhNGZUNWFjK3Nrd0QyTHpmSHdkZnpySDVVaTVOY1I1Y1dM?=
 =?utf-8?B?ZWpGWDJIRFJPbGp2RFVaNXpjSXBQTmNjQ05oQkZWVDVuSlA2OFhLcDBYNHgx?=
 =?utf-8?B?Q1FkR0J3Mm8wQlkrQXVNREU0MmZyVWFuWlNlOFJpRzgxQ2hrdURtNnZ4ZTFY?=
 =?utf-8?B?b2xUaHFzUmptTlhVUHJLTVcvOStHVU5ZeEFIQW9aa2Fla1JXaTVpR044WjdS?=
 =?utf-8?B?WGNSYXc2d1BQTkxEU0x3WEtlVmJOeWQ4THdINFdCSEtJZ1lRbmtualRtVjdD?=
 =?utf-8?B?NGVmOFcvREhNL3lWa3VqbEN5eXZUU2d6UHhPUEFyL3hjaFg4c2ttdktqald2?=
 =?utf-8?B?QlNzUHp4eFhwY0lXeUZjcGxXaHlUWjEzZGhBNFNQVkZrSUh5N0RtYlhsQWU1?=
 =?utf-8?B?REUzNVpxTi9XY2dMSzl3Y3FCcHMzYnlEYmZrMW5LNTBJMW9hUUxkS3MwM0pY?=
 =?utf-8?B?KzRDR050aytIQUNPdkZGdDk3dWk3bG80dis4VEpScFJtY0w3aTl4aHlrTnIz?=
 =?utf-8?B?RGg0cURJL3JEaVdNdnBlemNBbGQ4dC9WMU9GcTVBdmV2UDAzRDBXQ3Y4YUpQ?=
 =?utf-8?B?bytaZWE4T2E3ZmZCdm1wcm55d2ZSNGNxWWlPNE1UK0MvNmhXTW1WaGx0SWJC?=
 =?utf-8?Q?N8Dx7+c2g42UuGBhtm1RReFhCdwYjC950YHXH+y?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2382.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3159ce7-1fab-4b68-b5a9-08d964321057
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 23:27:23.3702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mg7F1yB+nqs+H4BrZqa9hFfInzJqKusZ1pydowH5gvF172zezdBOnlsd5RxZl1F56WCB7uX/7kzJFJ0NlGNRcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4544
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxj
a29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3Qg
MjAsIDIwMjEgMjowMCBBTQ0KPiBUbzogR3JlYXRob3VzZSwgSm9zZXBoIDxKb3NlcGguR3JlYXRo
b3VzZUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAyLzNdIGRybS9hbWRncHU6IFVzZSBTRE1BMSBmb3IgYnVmZmVyIG1vdmVtZW50
IG9uIEFsZGViYXJhbg0KPiANCj4gQW0gMjAuMDguMjEgdW0gMDc6MzIgc2NocmllYiBKb3NlcGgg
R3JlYXRob3VzZToNCj4gPiBBbGRlYmFyYW4gc2hvdWxkIG5vdCB1c2UgU0RNQTAgZm9yIGJ1ZmZl
ciBmdW5jcyBzdWNoIGFzIHBhZ2UgbWlncmF0aW9uLg0KPiA+IEluc3RlYWQsIHdlIG1vdmUgb3Zl
ciB0byBTRE1BMSBmb3IgdGhlc2UgZmVhdHVyZXMuIExlYXZlIFNETUEwIGluDQo+ID4gY2hhcmdl
IGZvciBhbGwgb3RoZXIgZXhpc3RpbmcgY2hpcHMgdG8gYXZvaWQgYW55IHBvc3NpYmlsaXR5IG9m
DQo+ID4gcmVncmVzc2lvbnMuDQo+IA0KPiBUaGUgcGFydCB3aHkgd2UgZG8gdGhpcyBpcyBtaXNz
aW5nLCBhcGFydCBmcm9tIHRoYXQgbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IENocmlzdGlhbi4N
Cg0KSG93IGFib3V0IHRoaXMgZm9yIGEgcmVwbGFjZW1lbnQgZGVzY3JpcHRpb24/DQoNCkJlY2F1
c2Ugb2Ygc2hhcmluZyBhbiBNTUhVQiBwb3J0IHdpdGggb3RoZXIgZW5naW5lcywgdGhlIGhhcmR3
YXJlDQpkZXNpZ24gdGVhbSBoYXMgYWR2aXNlZCB0aGF0IEFsZGViYXJhbiBzaG91bGQgbm90IHVz
ZSBTRE1BMCBmb3INCmJ1ZmZlciBmdW5jcyBzdWNoIGFzIHBhZ2UgbWlncmF0aW9uLiBJbnN0ZWFk
LCB3ZSBtb3ZlIG92ZXIgdG8NClNETUExIGZvciB0aGVzZSBmZWF0dXJlcy4gTGVhdmUgU0RNQTAg
aW4gY2hhcmdlIGZvciBhbGwgb3RoZXINCmV4aXN0aW5nIGNoaXBzIHRvIGF2b2lkIGFueSBwb3Nz
aWJpbGl0eSBvZiByZWdyZXNzaW9ucy4NCiANClRoYW5rcywNCi1Kb2UNCg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogSm9zZXBoIEdyZWF0aG91c2UgPEpvc2VwaC5HcmVhdGhvdXNlQGFtZC5jb20+
DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYyB8
IDggKysrKysrLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc2RtYV92NF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYw0K
PiA+IGluZGV4IDg5MzEwMDBkY2Q0MS4uNzcxNjMwZDdiYjNmIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jDQo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMNCj4gPiBAQCAtMjY4OSwxMSArMjY4OSwxNSBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9idWZmZXJfZnVuY3Mgc2RtYV92NF8wX2J1ZmZl
cl9mdW5jcyA9IHsNCj4gPg0KPiA+ICAgc3RhdGljIHZvaWQgc2RtYV92NF8wX3NldF9idWZmZXJf
ZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gICB7DQo+ID4gKyAgICAgaW50
IGVuZ2luZSA9IDA7DQo+ID4gKw0KPiA+ICsgICAgIGlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJ
UF9BTERFQkFSQU4pDQo+ID4gKyAgICAgICAgICAgICBlbmdpbmUgPSAxOw0KPiA+ICAgICAgIGFk
ZXYtPm1tYW4uYnVmZmVyX2Z1bmNzID0gJnNkbWFfdjRfMF9idWZmZXJfZnVuY3M7DQo+ID4gICAg
ICAgaWYgKGFkZXYtPnNkbWEuaGFzX3BhZ2VfcXVldWUpDQo+ID4gLSAgICAgICAgICAgICBhZGV2
LT5tbWFuLmJ1ZmZlcl9mdW5jc19yaW5nID0gJmFkZXYtPnNkbWEuaW5zdGFuY2VbMF0ucGFnZTsN
Cj4gPiArICAgICAgICAgICAgIGFkZXYtPm1tYW4uYnVmZmVyX2Z1bmNzX3JpbmcgPSAmYWRldi0+
c2RtYS5pbnN0YW5jZVtlbmdpbmVdLnBhZ2U7DQo+ID4gICAgICAgZWxzZQ0KPiA+IC0gICAgICAg
ICAgICAgYWRldi0+bW1hbi5idWZmZXJfZnVuY3NfcmluZyA9ICZhZGV2LT5zZG1hLmluc3RhbmNl
WzBdLnJpbmc7DQo+ID4gKyAgICAgICAgICAgICBhZGV2LT5tbWFuLmJ1ZmZlcl9mdW5jc19yaW5n
ID0gJmFkZXYtPnNkbWEuaW5zdGFuY2VbZW5naW5lXS5yaW5nOw0KPiA+ICAgfQ0KPiA+DQo+ID4g
ICBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV92bV9wdGVfZnVuY3Mgc2RtYV92NF8wX3ZtX3B0
ZV9mdW5jcyA9IHsNCg0K
