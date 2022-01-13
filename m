Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E67C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 02:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CDB010E199;
	Thu, 13 Jan 2022 02:34:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2718410E199
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 02:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBsTdZqbzp9ZpFl7wYxmWBeDgDHigqsdQ9TxdgIyk3A+HN3iAVFn/Hlp3v/PGBiZgj2aKoic+beeTe/3FmgQ5W1YHnYHXtDUdmel4PMFaohLS7TQqUSWWuisl8BnFsgkg5HF2aTJXlb8x/zkanOGx/27LZ6VCvvE4BZLhhx0uQbNDYPsiNYITnyrbr6MbvXKhlK/emRIjSBvu8l9wqweGbBKm4WMmkKyZeSSzZxER2EKxGd1Ahc27zWQ0QrWoSEBDEbRYOsnb3SXQPX3MSJCd1dZ0QRWVO/A6pirKKPQU/b0GRB9wc+pkDq/yp+IvugJqr6bFoR74RUkxpj7S8R/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+6X3Fvm+90snFY9g/OIvRzPaMM37bbuUakcVyJDLNY=;
 b=Z/5XSaQs4cRCgQukp5hdVTQpaJXTZCWv5KsOjjpvVwV4jUHT3i2DIesFhtdydummlxmEbu9GM6Ug46BGlPS4YNG8TFFDED5QCuL8FhjCjDWj+B26GSDKo1nTtYyf6I/OIQ93kJ07/qungeqzQoZPPJTyUf4/Bkre+aE1rrIS0pyaWJDKpvXHAyK+/dJPi4Ujud+u0QYq+JNYItdNxPMwpBFYtasRwhJyea98tcImugWE2p+1IM+yseDvj5ZBOEWads5Lwp6Ug9ea1UTpYABZlW96DTffKy7M/qCNRVo6PmTQJFDJnDBVFfzLuTu2x27I7U71Cgcu6wML1nYY2QIXgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+6X3Fvm+90snFY9g/OIvRzPaMM37bbuUakcVyJDLNY=;
 b=BucmgdoUiLXdNTpeaj0GhXKHeAaaEHTkbyNZvZPvJf4kTBrGtXwAtVq3UmCTrAZp7jPBUVjPy2d4M9AZyXF7J8k+oHaV6LgZcTwras5waGF2b7TF97WDG01T2aJc1ESdkpTnBb+6FKSwCYUaVD1l0Lel3LFEoVp3XDx6o67PK1E=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CH2PR12MB4860.namprd12.prod.outlook.com (2603:10b6:610:6c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 02:34:46 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::68f6:f42b:2c29:7f94]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::68f6:f42b:2c29:7f94%6]) with mapi id 15.20.4888.010; Thu, 13 Jan 2022
 02:34:46 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: No longer insert ras blocks into ras_list
 if it already exists in ras_list
Thread-Topic: [PATCH 2/2] drm/amdgpu: No longer insert ras blocks into
 ras_list if it already exists in ras_list
Thread-Index: AQHYB4jQYTlX6XLig0Sz+X28kPiSbKxfltmAgACeRZA=
Date: Thu, 13 Jan 2022 02:34:45 +0000
Message-ID: <CH2PR12MB4215F28C65D2637329E0CF56FC539@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220112074802.2867813-1-YiPeng.Chai@amd.com>
 <20220112074802.2867813-2-YiPeng.Chai@amd.com>
 <8c41ded6-ae6d-9940-360b-bccbaae511cc@amd.com>
In-Reply-To: <8c41ded6-ae6d-9940-360b-bccbaae511cc@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69cbd7e1-9d10-42c8-805f-08d9d63d4357
x-ms-traffictypediagnostic: CH2PR12MB4860:EE_
x-microsoft-antispam-prvs: <CH2PR12MB486059D48FD71BB317EF75C5FC539@CH2PR12MB4860.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46HfVkzwUI8E98TJjg4hE8j8QDfO7IjoFTNQHUcnESVhKzmjNBtoaUksTNieIQnnPSvPBcoLb6kUSx42ttXQTVg3xE7tIyB4WC2LZzDAd/sAiFgxaI1aN4VgFSLX26juFiBl7Bpl7464WgJsKEVMgzSe3G0xwvvz5AHsIQOVuYyNqgaTWdMxARLZtZfiZBMtYhVm/ZezsZnQK5GB6EeAoKAwbxFFoe8GqXESPe7UWQxFXCfx2d/xxrxcp+7DmVuZEE7aDquuenfuMztivmAWMIAakkvsZVRnJfbJxAV7lldL8mzc1By8P7wZ6ztXTzLuxvAuwP+wOk0ACpPzYGDN1sqS3E20G0aBB98Vy7ozhq7n87vz3hYrVjgcSX7VmfJJKyb2xz7gyCbNTHjv0rLuvfzti6ofDeDw7Dbeec3n24DlrHC/9RRTTWFvczZMNByo7L+N2eo4q1d+MLXPRBxONj83mNYl5vK7eGzKulyglyQSeEVsjpUGZdieR3rIgYuOZ5npvM/l3xIgHLq650oUMqgdWUv3IXYNDWwqF6gFOdJpHFV/o9tncXWSKnC9nqg5fvhGdbUlmX+EubXgmpbSZJYxsa9p9bwaUCrL1b8mUlG+050iExuEn6J9CkxnzgQfsfze0cT1kCrIqYqMPSSUGlkL0mTXDJZtQzHlXBweijKRLS+Ns9lRtRnfvpbsABmJyF2Z6xNaE+TmCbDX3+ZpPA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(2906002)(5660300002)(7696005)(53546011)(8676002)(4326008)(6506007)(122000001)(52536014)(186003)(38070700005)(33656002)(508600001)(38100700002)(86362001)(9686003)(8936002)(71200400001)(66556008)(66946007)(316002)(64756008)(110136005)(76116006)(54906003)(83380400001)(66446008)(55016003)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1JmT09qSFpnSUNPalM4Nm15Wi9LemxZR09jaXZoTDJQZlFwaWFSeElMek9v?=
 =?utf-8?B?Q3F2eEhCTFB5OS9oQ1JtZS85UlR4ZjVFM01EVjlibEdRSjdJenFZZHVDV1FD?=
 =?utf-8?B?V0NNS0FJOXBHN2RHaFVFMkFoQnlvL20zNnJOd21YWXpsWGNPanE1YXZ1aWsy?=
 =?utf-8?B?SEVETHdPRllMcjk3L2ZmTnhNRWZtUTQwOXN6QUd1TTUra2ZzbkpydTRpcHZX?=
 =?utf-8?B?aGo0RlB0YmdHclRWUTB6dHdOMkVVc2l5WFE5WWFkRFMwZzJWbjU3RFk0OGhY?=
 =?utf-8?B?WGdvMzdoeFFJaENUb3NFb25wNm51YTcyTDU1cWFVUzUycEsxS0JBSFNxWGNa?=
 =?utf-8?B?OHBmRnhjcVFuRGgxV3AzSkNPcEJtWUZRdnkzdGgybm9TZVpTbXJ5cHlQQkRp?=
 =?utf-8?B?bzNqc2V3WCtlSDc3UHpoS3dqcDVzY2ZzcUpPM25rRXd2WHdXalpwZXhnRkdh?=
 =?utf-8?B?UGZRSjhHYTZpYXZuQzVmK2NUNXpWZ1dlU01Pd3NscEZDQ2RjeVBuNG95VlNF?=
 =?utf-8?B?azFZK3gzYUxJckRPc1MraEIrSldqcmxHWXFzK09lMmxoODBJMTBXdlVPS0xT?=
 =?utf-8?B?VllPSzBzSlZVK24xVC9wTzMwWVVDZWRXNEZ4Tmc4Q1VuNVJxTDg1UnRMNVo2?=
 =?utf-8?B?SjY0dnVGVG5HWGxmeTZkamcvd2NYYlJLSGk5OXJ6V3VpVlZUa2NlaVJJTVdi?=
 =?utf-8?B?c00yckE5WU51RDF0ZjVXdlBhR0ZOZk5hdDNBOGlZS1huM1Ric1g2a0FwdkU1?=
 =?utf-8?B?VEJ3MFJTWFNqTXdNcDMvVXRPTW4wbmVGcGRtK3BiNlFUbHJ2VEZ3dWRHQU9U?=
 =?utf-8?B?azgyWW5nRE9QYWlpVDAwTnJLNHdPcEQwVjk5NGthU2ZCK010UHlIZ1lFWi9z?=
 =?utf-8?B?MmFUcStibGZ2VVhkQnhBSGRvUWFTd2krMlNoZWs3UkFYTGpvb1dmY283WkVy?=
 =?utf-8?B?NVpvOU4rR0dKejM1QTE1TEVRRWRMQ1FkZUN1N1N5OE5HQ09BUGVpL3V0alpa?=
 =?utf-8?B?S0E1dFdlYzFsTXh1Y2FWNDYyWnpNSXk5SmYxRnhvMVZVdVNEN0VuS01Wemd5?=
 =?utf-8?B?VFBmZDhiVmpoMDk1ZWF5cmcyQ0VkdTB5UnVVTjlGRitHTDlnL1F1ZXhBU1k1?=
 =?utf-8?B?K29KWURITTBmaHJJM1FUNWpkWVBLd3VGWXlLSkRUR2loQWF0dUdQdm1yQTBW?=
 =?utf-8?B?bzZ3VUZsMlY4Q2tIRGlKeHQ2WVFPUG9DSEJtK2JLeFVvdmQwSFZKMkFwbDNV?=
 =?utf-8?B?d2RJa1JEK2VtQkxoUlBVWUxVQWlKVmZ6L2cydXNmSEF3eEdFQW5yZDJjeUpU?=
 =?utf-8?B?dzExMzJzU29pSlRRWUhvdk5iMzlCcC9TSUdlL1R0MzFZRERmODdkb0xMcjM1?=
 =?utf-8?B?eGhCbnhIRGlzeWlxSjYyS3hRL25PUEl3MExKeE9MN0Zod0lYVGlFVXVDbytT?=
 =?utf-8?B?Q1VKMGpmWFNvYUlWRE4ydWEveXFpK3QveEdXT25uMG5FN1YvRkUzN1pKNlpq?=
 =?utf-8?B?bklqWFVuWkx2QmFQdG5IVzdaaHkvMG5Mbks3V1lRSnJ1U1lhNHhhR2JXekxz?=
 =?utf-8?B?aVBrYWRkaW9ua0dQK2ZPaHBqTTM5aU8zR1k4YU1KMk1GZmYxMDZWbHRQY01j?=
 =?utf-8?B?YU05Q2tkSGFNaDkveXFmV29YS0wxYmtLOFcxU0Vsa0l3YUZyOHpnazVqZ1RU?=
 =?utf-8?B?cFU2VTJhVjFpU2dpbXN3d1lPUVJQRHo0ZVpZbEM3RngwaFdYWEZTTCs5U0Fa?=
 =?utf-8?B?WW9wSS9lODFlT0xSR0NmQUdlU3ZhNzNIWkozRllOK09lejhoNHNhV2tJSS9G?=
 =?utf-8?B?L3FPMVlMZ3RFbW9uWWxEenVQU242ek8za3RCcllOWFBSVlNUQmM1QjhjcHl2?=
 =?utf-8?B?MjRLenRoVkU3VG5vQW5WS3YxQmZLcFdZK0p4YjJWaDZZallER2FpNzVrbHdB?=
 =?utf-8?B?aTQreHE4T0loY1RJWjVCcnV3MDYvb1EveTNaeTRkY0ViWS8yRDVSbXkrY09M?=
 =?utf-8?B?VElNaWU1NTJqT0pOZkRKUWJRS3RJWTJ1emQ1S2x4Yk1QY1psdFdjU0dtdm1p?=
 =?utf-8?B?WS8ycjIyOGlqc2F3cFhDUjRoZzkyTnJxS0Y3S1JhTUZDWHhCOTNIUkR2WklD?=
 =?utf-8?B?dFhKUUN0OGxCZTlNaDF5K2M5TWxTUGJlK1YwbVhvbzRIRnpyc3cxMXRqNzBE?=
 =?utf-8?Q?Hgf9Re+PYjMqYUp965csY1E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cbd7e1-9d10-42c8-805f-08d9d63d4357
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 02:34:45.9074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wIwLcuzvsTubRh3EFJKoryOyRhgS1mUsfuxPGQxdWXd/IQ1Dga43l7CqnTwSqvqzb37CGv/QK5VWg6Cq+jbcxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4860
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgRmVsaXg6DQogICAgIGFtZGdwdV9yYXNfcmVnaXN0ZXJfcmFzX2Jsb2NrIHdhcyBjYWxsZWQg
YnkgYWxsIElQIHJhcyBibG9ja3MsICBhbmQgZXZlcnkgaXAgYWxzbyBoYXMgZGlmZmVyZW50IHJh
cyB2ZXJzaW9ucy4gIFdlIGRvIGNvbW1vbiB3b3JrIHRvZ2V0aGVyLCB3aGljaCBjYW4gcmVkdWNl
IHRoZSBjaGFuY2Ugb2YgdGhlIHJhcyBmdW5jdGlvbiBnb2luZyB3cm9uZy4NCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdA
YW1kLmNvbT4gDQpTZW50OiBUaHVyc2RheSwgSmFudWFyeSAxMywgMjAyMiAxMjozOSBBTQ0KVG86
IENoYWksIFRob21hcyA8WWlQZW5nLkNoYWlAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQpDYzogWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBaaGFuZywgSGF3
a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgQ2xlbWVudHMsIEpvaG4gPEpvaG4uQ2xlbWVu
dHNAYW1kLmNvbT47IENoYWksIFRob21hcyA8WWlQZW5nLkNoYWlAYW1kLmNvbT4NClN1YmplY3Q6
IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBObyBsb25nZXIgaW5zZXJ0IHJhcyBibG9ja3Mg
aW50byByYXNfbGlzdCBpZiBpdCBhbHJlYWR5IGV4aXN0cyBpbiByYXNfbGlzdA0KDQoNCkFtIDIw
MjItMDEtMTIgdW0gMjo0OCBhLm0uIHNjaHJpZWIgeWlwZWNoYWk6DQo+IE5vIGxvbmdlciBpbnNl
cnQgcmFzIGJsb2NrcyBpbnRvIHJhc19saXN0IGlmIGl0IGFscmVhZHkgZXhpc3RzIGluIHJhc19s
aXN0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiB5aXBlY2hhaSA8WWlQZW5nLkNoYWlAYW1kLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCA4ICsr
KysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+IGluZGV4IDYyYmUwYjQ5MDliMy4u
ZTZkM2JiNGI1NmU0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmFzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jh
cy5jDQo+IEBAIC0yNzU0LDkgKzI3NTQsMTcgQEAgaW50IGFtZGdwdV9yYXNfcmVzZXRfZ3B1KHN0
cnVjdCBhbWRncHVfZGV2aWNlIA0KPiAqYWRldikgIGludCBhbWRncHVfcmFzX3JlZ2lzdGVyX3Jh
c19ibG9jayhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gIAkJc3RydWN0IGFtZGdwdV9y
YXNfYmxvY2tfb2JqZWN0KiByYXNfYmxvY2tfb2JqKSAgew0KPiArCXN0cnVjdCBhbWRncHVfcmFz
X2Jsb2NrX29iamVjdCAqb2JqLCAqdG1wOw0KPiAgCWlmICghYWRldiB8fCAhYW1kZ3B1X3Jhc19h
c2ljX3N1cHBvcnRlZChhZGV2KSB8fCAhcmFzX2Jsb2NrX29iaikNCj4gIAkJcmV0dXJuIC1FSU5W
QUw7DQo+ICANCj4gKwkvKiBJZiB0aGUgcmFzIG9iamVjdCBoYWQgYmVlbiBpbiByYXNfbGlzdCwg
ZG9lc24ndCBhZGQgaXQgdG8gcmFzX2xpc3QgYWdhaW4gKi8NCj4gKwlsaXN0X2Zvcl9lYWNoX2Vu
dHJ5X3NhZmUob2JqLCB0bXAsICZhZGV2LT5yYXNfbGlzdCwgbm9kZSkgew0KPiArCQlpZiAob2Jq
ID09IHJhc19ibG9ja19vYmopIHsNCkluc3RlYWQgb2YgYSBsb29wLCBjYW4ndCB0aGlzIGJlIGRv
bmUgbW9yZSBlZmZpY2llbnRseSB3aXRoICJpZiAoIWxpc3RfZW1wdHkoJnJhc19ibG9ja19vYmot
Pm5vZGUpKSI/DQoNCk9mIGNvdXJzZSB0aGlzIHdvdWxkIHJlcXVpcmUgdGhhdCB5b3UgbW92ZSB0
aGUgSU5JVF9MSVNUX0hFQUQgdG8gc29tZSBlYXJsaWVyIHN0YWdlIHNvIHRoYXQgbGlzdF9lbXB0
eSBpcyByZWxpYWJsZS4NCg0KUmVnYXJkcywNCsKgIEZlbGl4DQoNCg0KPiArCQkJcmV0dXJuIDA7
DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gIAlJTklUX0xJU1RfSEVBRCgmcmFzX2Jsb2NrX29iai0+
bm9kZSk7DQo+ICAJbGlzdF9hZGRfdGFpbCgmcmFzX2Jsb2NrX29iai0+bm9kZSwgJmFkZXYtPnJh
c19saXN0KTsNCj4gIA0K
