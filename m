Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC6AC636CC
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 02:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F5AE10E0A3;
	Tue, 14 Feb 2023 02:26:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52E2710E0A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 02:26:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bL9GTd/Rgntl2FflII/G0RF/04chRIjAd35rYf5gLE95WXrYKM4V2+zUnD/OpnXhTfanlDJcqxYaBcwKgFwXsoJ876ZAJmimqTXtJ2eNPgnPSQPNp8AbIktqizRrIaW6Sbe0LLPaOtNJrG6leDROC7K2dmaD3p8hxehc5nLQCryNmC/AnqSVrw94b2PsBdDVSWMTFApdMcdouhcpOwq54DRS8j2B7cXD5bkbrRWG5HJZxjzk5zGWbZSo8ZGZJDdWRPBlpMBfkqnwBIVqQZ6UDwSF4xjladeBFZgH/7psA0B/3/EW/xvE3tLl3mMZw+aGf65E3jpFexvnVrNmroFMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ph4M0ZkRPrJRMwjEiR/THFHmtmZbltjm96LzHN6J/fw=;
 b=E+ijseVwUedep6nR6DohWIBa9SE6d/8P5RO+4ugw9DHN20tmQ5BnUZy6J5r3bhmFHwyIaBGEBgjkXv58hKOlI+ENGJKM1CjYdlg/lA2JHdaPbUolTUx3Vg3QJkRdfPw3YFsd6LHLcx6ew4WIZyPb/zh2lB72LwrHcoz8Lk57h/JcXsdD5+mQXSy3ERAbFEKHA/NYeLLVjcxnCokV+zKyx0JgaoQFz7yXsF3D13fSu53CA4odaq8GaN7bWXBq7zYeMIqePPgfkaX0MgqUpIVSFeo0O4RwlBSHkNTQ/Hpr3H1UzJxZ9vd3FzAkdH50R5SsIVQDTQCsaop5IOuS/74zqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph4M0ZkRPrJRMwjEiR/THFHmtmZbltjm96LzHN6J/fw=;
 b=ZhnhsE9yAA21RY4Q4fuKPSFPWq77hjHhw5RXUNtd+i5auxP2wpT+j4kWnFfwGjM9lvEutGDpvxfC/+HEUP6C+npJdJALGzBvCWEZwR3GkSHpF66/c2E3dfOWBqJraP+g4LNbPoH/NpmOBT+3GBvzdO2A6P7HILKJouMEmvB/Fqk=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 02:26:46 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92%9]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 02:26:46 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, 
 "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new bad
 page
Thread-Topic: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new
 bad page
Thread-Index: AQHZPSwYCyokUNaSQkeAF4mLprNJJa7M1aWAgADiPAA=
Date: Tue, 14 Feb 2023 02:26:45 +0000
Message-ID: <DM5PR12MB1770AF75B3AFA71C91FEC5D9B0A29@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230210084529.9695-1-tao.zhou1@amd.com>
 <fe541c9c-4684-fd02-e5bc-f28b583744af@amd.com>
In-Reply-To: <fe541c9c-4684-fd02-e5bc-f28b583744af@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|DS0PR12MB8294:EE_
x-ms-office365-filtering-correlation-id: 2cb8511c-3701-4f51-2ef1-08db0e32eb3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5p3dPGpZcug3+dbJphDL3cAr4dBFkdqMXDIRdbXzhNH/yyW/9fNVVE6B5XAgsbuaPMpnQeO0wFHQGyFveBDerXQ5k4FeQ6M8TCrZf6ED4wCwPWypQ1DG3hgk5hYO68s50WfAMtEDCqsnLDdrsPI+m/xJ5RLxoaWcGKk0XLAy/D2AOx8/vceQrt+k8DjP2+cqDDUu6ihwr3dpetatQX9QmW5br5z3+g5ki+wCzZXCJYajvlNO+/WT5CBjCt/r8RMwgkwG3ggpoE8bkGuc7CKBaHHBOP2MUbLggAZGy2rVFBeYWwKMhcYhKmSY2ZtZTia9eHltP0D7OphB4WL+LLx4u3VFUDvoTqFW6CN6NLe4J83dettnRLSYpqnpm+AL8ftVPYXZy4VFKPVk29tPa+KXNJ+id6d0KUxVKt/RtCzPeBb18vD/tIjB7+ebGHWhooKqq7vMULdI98WXbQZPjUu/+xw2spZtiTpn+rrLNy0o9KWD3BGyc7B0vSvmvS8jPkztXAEmj8Xi7YX0jXBO0M6LvLP6Y4waq6pcZFE8slEITfC4CEf7QwbgBbDiaoql4lL4owObm3pDHUUZ10z2m0Ss3p3cdGRyUoX1wDnYv+9H66sEa3aR9NFvbdWl6Q0WBYwQdvkz4vMMlloVLFyR2s17/h4+TLP9LwnFJoI3W2XYRqQa/yzRMznGxjJ577hh80Mq6/ACTRzDfep4aRWISs2njfnOYP78XR36dm4S0fsJr9c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199018)(6636002)(110136005)(9686003)(2906002)(7696005)(41300700001)(26005)(66556008)(66946007)(8676002)(66446008)(64756008)(66476007)(76116006)(83380400001)(8936002)(53546011)(52536014)(5660300002)(6506007)(71200400001)(186003)(921005)(38070700005)(38100700002)(122000001)(33656002)(86362001)(478600001)(316002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWtZSFIwZDMyLzdScS95dlBMYkJsc2grZW0xUlNsemZqWWx3ZCtvaXpHeHAr?=
 =?utf-8?B?MUNiS0MzSGh5UE1GQ1RkYkVpaVVmRDlVdjFKdm9vQXU4YmhKRzhrUTlJMkZG?=
 =?utf-8?B?NGVBT2gvcUJFKy8rNTl5cU54MjRVUGlidHRkM25vWE9Dc3IwZjZiVzBZQ1N3?=
 =?utf-8?B?T2lUajBpNTEzMWpXYkcxWWNyRHJHbkRlRnN2Ty95THJVNzVhanlOdEtmTUF0?=
 =?utf-8?B?UHFxdmpJd1BlSHd2bGpuSEM2YUFrc1VzL1N1aUFTUFFzcnRHeTNhTEJ3OHYw?=
 =?utf-8?B?cVVwTDBMVTQrczR5cXE5MjBEWUN4Y3VuQUE0QkJud1ZyQXBkRTNuQ3hGbk1m?=
 =?utf-8?B?Tmx2MDZjMkNNTWlmeE5UT2Q3Y3ZjYVJ2ajR5QlE1WmlaQlg5c2ord051SE5n?=
 =?utf-8?B?SkZ2U01GcXYvV2duS2tUTUpoZFdROXZ1MXNwaG55MWc1LzBUOUk0QWdrTHV5?=
 =?utf-8?B?UUVzeVBGbmFSY1hRNzkzOWtQU1g1QUJUaHQ3TG03NjN5eXhIZ2s2NlBkOUl5?=
 =?utf-8?B?Wnlmc1BONm8wTjJsYWhBWVdjdCtyUFRZdkNRV3pvajB4WDVxd1p0bHFkUXBE?=
 =?utf-8?B?V1pmOVFNYXpqMk1OQUQ1ZDUxOE96dENiVXpKbEZPMFpYRGRESTFWR3ljNG52?=
 =?utf-8?B?Qy80RDVsK1BCYWx3bUVVYzkrVzZUaW5kUndMdkdERzdJcktMaTdQMkdqcEU4?=
 =?utf-8?B?a3JnTklSZkh5cmlpTSt5bnVkRDYrTHlQRVVObTZYMUNEa3c3cjlWZ3ZMd1VU?=
 =?utf-8?B?UXpTZHFpR0oxb0tIaUJFY0ZiS0RCaGpsWnB0QUJnTXdJSTdzZEJXL3JvMjNC?=
 =?utf-8?B?Qy9RWkdzbFo5d3Y4YzFzYnVWbjVPVjJ3SVl3bWhmU0NSR2hYYkk2Y2VURnJa?=
 =?utf-8?B?TkZSTlhuUFM2OUY5MjNHdFIwSmRSbFltU24vTjBYZURFT0FHdm4vTmFtZUVW?=
 =?utf-8?B?QnNZTDFsZ3pnRmlRNVk5RkRwN0NqZ1lzd0h1elNIWUNJdE5rU1BITnRWdFJm?=
 =?utf-8?B?a20rSWpQTW9hQ3BrNTljRFVHWmFGMFh0TVNCOEZSdjNWSWdHNVk3TW52TEJT?=
 =?utf-8?B?SUk5VWp1U0c5K21HMDlpQllaRm1MQlNCSTVUMVozYlNRL3ZLclBSbzRrRjVN?=
 =?utf-8?B?bVI5ZG1QZGwvYjNDYmhQbFNVdEhIb1h2eEtDNVFnKzBEM3RnemtqTHJQU0Fo?=
 =?utf-8?B?YVNDZGdpV1YraktublZKTnl6eUVxYzV6MUJoQ1N2QkRFcXNhRUNRZ3M3SUs4?=
 =?utf-8?B?Z0I3ZFpZQ1JsNk0xZEJ2RkJoMEpHam92VjRBY1BLS0hKc25jRHJBTndGVlZF?=
 =?utf-8?B?WHExejlheXZvMWVyWGV3RklmOEMzWmtjU3V0UWNpbVpGSmVleUF1SlBqUFl2?=
 =?utf-8?B?Sk9oTHVuQkFmSXR0Y2tGR1JYZkoxdi94TmZCL05VWlZibEhoUjBpRnBDdmxU?=
 =?utf-8?B?Rm9OdFNLRkVFZFZBV3dGRXNlOVowZU93SUxvWm1UVTZHcVg5UE40alBlVHI5?=
 =?utf-8?B?VEtsS2lSbnh1eXFxbXd4eEp2NFVoRlJpbjg4MzNYbkFrRmlKNXpNTUNBRHRS?=
 =?utf-8?B?Uy9yamVlSzFjL0x4RTRCTVQ2a1pmNkZJdnFBdEE4TXFDVjRleU5nbzh6cmsw?=
 =?utf-8?B?QVI0TXJ1b2ZDcjJ2eFN0d3NRd21ic3UyME9Zd250RXVtb3VxNjB0OFBjMjFQ?=
 =?utf-8?B?ckgvL2JrcWcxTjhZQWZGK2VPTG52NUxBZmRSbVRxSkpFcko1Y201cE5nREVn?=
 =?utf-8?B?NVJWZ0FGNHprMlJSbDhFVTE1K3hIM0dtQ0drcGtIMnZzN3VLc2NDYmp4Wnhv?=
 =?utf-8?B?TERiQkN6YVhzTU4vYkM3UEZIRG51dGt3SzJHZldyRzFCNTNrVFg4OXBsRlFP?=
 =?utf-8?B?US9WMFMwNlBla2luWStJZXYyalRocldtbFQ2WlFXaWFVRSttbFZEZlRQYkVK?=
 =?utf-8?B?cE53RHJKeVNDYkg4YldvclNBaFE0bkkxYW1KVlhqWTh1QnpwY3RDTVNXLzE4?=
 =?utf-8?B?NVozc0RGOGR5WEJuT29HM3RZdHNXVkF0NHVTL1p6eG1ia1BGeFBvdXVmUXRz?=
 =?utf-8?B?d3hvcUp2WW5Ba3l5a2NXZXRSZmVoOFFWR2tjVTNEY0tHbWxMSVR1bVdkMmdo?=
 =?utf-8?Q?q9Z8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb8511c-3701-4f51-2ef1-08db0e32eb3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 02:26:46.0684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lhdEqqW7lsaBdC50r5RM8i8KSUu01Q7BvdVFCEgQfkTn8I09NSuzNDCD9v8bSw5z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExp
am8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxMywgMjAyMyA4OjM4
IFBNDQo+IFRvOiBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywNCj4gSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29t
PjsgWWFuZywgU3RhbmxleQ0KPiA8U3RhbmxleS5ZYW5nQGFtZC5jb20+OyBDaGFpLCBUaG9tYXMg
PFlpUGVuZy5DaGFpQGFtZC5jb20+OyBMaSwgQ2FuZGljZQ0KPiA8Q2FuZGljZS5MaUBhbWQuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBkb24ndCBpbmNyZWFzZSBVTUMg
UkFTIFVFIGNvdW50IGlmIG5vIG5ldw0KPiBiYWQgcGFnZQ0KPiANCj4gDQo+IA0KPiBPbiAyLzEw
LzIwMjMgMjoxNSBQTSwgVGFvIFpob3Ugd3JvdGU6DQo+ID4gSWYgYSBVTUMgYmFkIHBhZ2UgaXMg
cmVzZXJ2ZWQgYnV0IG5vdCBmcmVlZCBieSBhbiBhcHBsaWNhdGlvbiwgdGhlDQo+ID4gYXBwbGlj
YXRpb24gbWF5IHRyaWdnZXIgdW5jb3JyZWN0YWJsZSBlcnJvciByZXBlYXRseSBieSBhY2Nlc3Np
bmcgdGhlIHBhZ2UuDQo+ID4NCj4gDQo+IFRoZXJlIGlzIGFtZGdwdV9yYXNfY2hlY2tfYmFkX3Bh
Z2Ugd2hpY2ggY2hlY2tzIGlmIGFkZHJlc3MgaXMgYWxyZWFkeSBwYXJ0IG9mDQo+IGFuIGV4aXN0
aW5nIGJhZCBwYWdlLiBDYW4ndCB0aGF0IGJlIHVzZWQ/DQo+IA0KPiBUaGFua3MsDQo+IExpam8N
Cg0KW1Rhb10gYW1kZ3B1X3Jhc19jaGVja19iYWRfcGFnZSBpcyBhbHJlYWR5IGNhbGxlZCBpbiBh
bWRncHVfcmFzX2FkZF9iYWRfcGFnZXMsIHRoaXMgcGF0Y2gganVzdCBtYWtlcyB1c2Ugb2YgdGhl
IHJlc3VsdCBvZiBhbWRncHVfcmFzX2NoZWNrX2JhZF9wYWdlLg0KDQo+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyB8IDkgKysrKysrKystDQo+ID4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdW1jLmMgfCA2ICsrKysrLQ0KPiA+ICAg
MiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0K
PiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ID4gaW5kZXgg
ZTg1YzQ2ODljZTJjLi5lYWZlMDFhMjQzNDkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ID4gQEAgLTIwNDksNyArMjA0OSw3IEBAIGludCBhbWRn
cHVfcmFzX2FkZF9iYWRfcGFnZXMoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4g
ICB7DQo+ID4gICAJc3RydWN0IGFtZGdwdV9yYXMgKmNvbiA9IGFtZGdwdV9yYXNfZ2V0X2NvbnRl
eHQoYWRldik7DQo+ID4gICAJc3RydWN0IHJhc19lcnJfaGFuZGxlcl9kYXRhICpkYXRhOw0KPiA+
IC0JaW50IHJldCA9IDA7DQo+ID4gKwlpbnQgcmV0ID0gMCwgb2xkX2NudDsNCj4gPiAgIAl1aW50
MzJfdCBpOw0KPiA+DQo+ID4gICAJaWYgKCFjb24gfHwgIWNvbi0+ZWhfZGF0YSB8fCAhYnBzIHx8
IHBhZ2VzIDw9IDApIEBAIC0yMDYwLDYgKzIwNjAsOA0KPiA+IEBAIGludCBhbWRncHVfcmFzX2Fk
ZF9iYWRfcGFnZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gICAJaWYgKCFkYXRh
KQ0KPiA+ICAgCQlnb3RvIG91dDsNCj4gPg0KPiA+ICsJb2xkX2NudCA9IGRhdGEtPmNvdW50Ow0K
PiA+ICsNCj4gPiAgIAlmb3IgKGkgPSAwOyBpIDwgcGFnZXM7IGkrKykgew0KPiA+ICAgCQlpZiAo
YW1kZ3B1X3Jhc19jaGVja19iYWRfcGFnZV91bmxvY2soY29uLA0KPiA+ICAgCQkJYnBzW2ldLnJl
dGlyZWRfcGFnZSA8PCBBTURHUFVfR1BVX1BBR0VfU0hJRlQpKQ0KPiBAQCAtMjA3OSw2DQo+ID4g
KzIwODEsMTEgQEAgaW50IGFtZGdwdV9yYXNfYWRkX2JhZF9wYWdlcyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwNCj4gPiAgIAkJZGF0YS0+Y291bnQrKzsNCj4gPiAgIAkJZGF0YS0+c3BhY2Vf
bGVmdC0tOw0KPiA+ICAgCX0NCj4gPiArDQo+ID4gKwkvKiBhbGwgcGFnZXMgaGF2ZSBiZWVuIHJl
c2VydmVkIGJlZm9yZSwgbm8gbmV3IGJhZCBwYWdlICovDQo+ID4gKwlpZiAob2xkX2NudCA9PSBk
YXRhLT5jb3VudCkNCj4gPiArCQlyZXQgPSAtRUVYSVNUOw0KPiA+ICsNCj4gPiAgIG91dDoNCj4g
PiAgIAltdXRleF91bmxvY2soJmNvbi0+cmVjb3ZlcnlfbG9jayk7DQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VtYy5jDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdW1jLmMNCj4gPiBpbmRleCAxYzdmY2I0ZjIz
ODAuLjc3MmM0MzFlNDA2NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdW1jLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdW1jLmMNCj4gPiBAQCAtMTQ1LDggKzE0NSwxMiBAQCBzdGF0aWMgaW50IGFtZGdwdV91
bWNfZG9fcGFnZV9yZXRpcmVtZW50KHN0cnVjdA0KPiA+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+
ID4NCj4gPiAgIAkJaWYgKChhbWRncHVfYmFkX3BhZ2VfdGhyZXNob2xkICE9IDApICYmDQo+ID4g
ICAJCQllcnJfZGF0YS0+ZXJyX2FkZHJfY250KSB7DQo+ID4gLQkJCWFtZGdwdV9yYXNfYWRkX2Jh
ZF9wYWdlcyhhZGV2LCBlcnJfZGF0YS0+ZXJyX2FkZHIsDQo+ID4gKwkJCXJldCA9IGFtZGdwdV9y
YXNfYWRkX2JhZF9wYWdlcyhhZGV2LCBlcnJfZGF0YS0NCj4gPmVycl9hZGRyLA0KPiA+ICAgCQkJ
CQkJZXJyX2RhdGEtPmVycl9hZGRyX2NudCk7DQo+ID4gKwkJCS8qIGlmIG5vIG5ldyBiYWQgcGFn
ZSBpcyBmb3VuZCwgbm8gbmVlZCB0byBpbmNyZWFzZSB1ZQ0KPiBjb3VudCAqLw0KPiA+ICsJCQlp
ZiAocmV0ID09IC1FRVhJU1QpDQo+ID4gKwkJCQllcnJfZGF0YS0+dWVfY291bnQgPSAwOw0KPiA+
ICsNCj4gPiAgIAkJCWFtZGdwdV9yYXNfc2F2ZV9iYWRfcGFnZXMoYWRldik7DQo+ID4NCj4gPiAg
IAkJCWFtZGdwdV9kcG1fc2VuZF9oYm1fYmFkX3BhZ2VzX251bShhZGV2LA0KPiA+IGNvbi0+ZWVw
cm9tX2NvbnRyb2wucmFzX251bV9yZWNzKTsNCg==
