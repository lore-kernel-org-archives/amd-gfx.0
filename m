Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40C5C28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 12:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E51D10E198;
	Thu, 25 Aug 2022 12:52:20 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE7C10E198
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 12:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRUsGrdsbFqNxOJyFydtv6ButxDMZU0Yvp1Xs1vnEOSp66OaPTp5I3YbcR+GmB6rr9eVI9mQ6nv7ftkFgPXYOM5oz8zeuuyM8x9F4FiW7iKEiuxwsnPC5sFfp/N06IArH9gAixoK3mM8g+G/L+LMI9SwvDlLut9Cbvng7T0VReH2J1AjPRE8FKkyd3JmebBDquA2za0guVZDzQUEshZlH5XduL+drlHV97OeHFzN3Jp/5CgYa0xpgPYkTuHeWOCG02jKl8mMcWwKbkSulRFB2EDyQoXmqx7etw2k/l2jP8PC3BxsTHNStm+U2ESg0rjROnUUQgae5zLy/kqh2haJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oVAxf94ZR82Fa79/OSaVq8CP0v7GiAzktxu0zLnVEM=;
 b=gVporay/P9uZelEG2LMwRAZm9Nkab5SwchKWr7gtTBqwCHHtc+blQgPbYotFoFKUffhal4+5RM5J0rJMaf0u/iUEScVICZYYgPtHb3YsqXVjw2+SC03NGOVUST6D+q7awXwnpaOrIM5oK/OgUWdfv0vM6FPwDrK62pBCHpfaJpiYipTZeKpUDQbq7AI3MgVWpANxZ+eHLI9Ew4YF1wrhihbgP0hITtO9vc738x25jtgkHxMb5ltTEoejqrjyvo6drkin6hWxImCizmsZvD4uZaxOWjkcYRw/oSFQoJjptGXPfCxnwttMhPuy+xQ1wnWtxFfvbbbYu+7yMNuKMyGRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oVAxf94ZR82Fa79/OSaVq8CP0v7GiAzktxu0zLnVEM=;
 b=iCab5CEfdSsVvssKaLp4NL1/XXR2buOBQjs3yq23oiDym5fB0nbXQOJ1zq+naUlZ0ZJcWm/VqrjROTSLoEZ5Lj7hajdSbD789EokHrzXccDXE/GQHXYhxsTC6eIQdGWgJVZj7S9MLXT3YuemwykDDxWKGqL2LzdiI/BVIM7iB5g=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 CY4PR12MB1206.namprd12.prod.outlook.com (2603:10b6:903:3b::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.18; Thu, 25 Aug 2022 12:51:51 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::5097:87be:3557:c681]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::5097:87be:3557:c681%5]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 12:51:51 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Handle potential NULL pointer dereference
Thread-Topic: [PATCH] drm/amdgpu: Handle potential NULL pointer dereference
Thread-Index: AQHYsLzZTS2TJPBDNkGN/BMXH268U62/jwIAgAANeICAAALpQA==
Date: Thu, 25 Aug 2022 12:51:51 +0000
Message-ID: <DM5PR12MB1308A8C9A177803B3FF55D9185729@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20220815153123.138156-1-kent.russell@amd.com>
 <DM5PR12MB1308B61FF812A91CA0FC77EC85729@DM5PR12MB1308.namprd12.prod.outlook.com>
 <4f4292c0-7841-a955-c07c-1eb8f1aa9293@amd.com>
In-Reply-To: <4f4292c0-7841-a955-c07c-1eb8f1aa9293@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-25T12:51:49Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ee1952d9-160c-4f05-81e5-40d77d20b63b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9156344-e72a-45bb-117a-08da8698949a
x-ms-traffictypediagnostic: CY4PR12MB1206:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vkkePCYH27Rzi9RSctJJEvWcNEAiMM5/pYdWfBoRn5u9e9g37dyEBoX4Fjz3/HljmmjFngZ34zz5e+lSX2JQjVw1O77zGM7poy6heyZSPlxWjWXn02fcTPdgPTWACkhB9UwB5rdayQZ5e6JVp2o4KD7YwHxf3RTZ9vAETZnqBUyjVs9tCdeOJLnm1svGHKRdYS0esytgHptSfUENxAYQt3vkAUPzjkY0F+xL5p2R2M0jwqGsfpfSxJE+kEXrGsVAMW7Q+FSmfUvytxXbxOBqM0gae8eDhNKqDwJExQnRAg6t0Y14nTd8Pdv6EbdrP7xbfm/ewXMipyeDDZW8Lzxjjm15pjUDGfn91VBHXEl6w+qx6bZTrZxkPlHoG/kbRaFHWi/DSgYTkHxKu0PvbQPTW6kSueeZqJR2PtJDuEXKeIKyR4/NDdfTjpf50s76HHDBGZ8Gg3IURqWSGbfrydoAwlef03k7N/gA/ITenmfWuvHtExPJxMcNBUgxwANlYBLJ6MKCHoi7viNSmmKtvyeL99rsUCdm1wKYN68Aud5s7PRsvtODC58iKloYBcXzmpoiZ2NtLHhqr/83pw7ODbnf5kGNtjcEFjCWBq6jZCvNcMnJsBLfCvBt6bM2GW/VfSGtPOHrhewc1oFa0/JeR03r6u9MtFBeIT7id8GPWVDJARQfeIfvKQNx45ZR6Kqdb5hzPsU++3eWqPAKyIoTU30dkiV7JJC5wOHFDdJKtn2mKzepCUe/BNNUu+LH3jaNG151nC1LKb+zlLBI/7cfIqr/bw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(110136005)(4326008)(316002)(52536014)(66476007)(66946007)(66556008)(64756008)(55016003)(8676002)(8936002)(5660300002)(38100700002)(122000001)(2906002)(66446008)(76116006)(38070700005)(86362001)(33656002)(6506007)(9686003)(53546011)(7696005)(186003)(478600001)(41300700001)(26005)(83380400001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkY1WHdGQnlvdzlkcDZ4aHJCeVBtTTA2bW1oZGxIVk92OVNIZ2xpVFRHK2ZT?=
 =?utf-8?B?Yks5bW04bjBGZThOUFRHMDE5Y0cxZE1HNURsTjNzVDRUQTk2S1k4NWJNZk1Z?=
 =?utf-8?B?YlJnNnRVNlQxRWNzREFKTnBkL0pzRlBTUXhoTDA3Z0x1NTVUbzZsV0ZTQVB2?=
 =?utf-8?B?QStpdUZCSkZMUHFqa3crdmlIaEVJSGczZnlra3pKckFJcDlWYTVWeDRRN3VB?=
 =?utf-8?B?NnBDTzJNNDR4OGpKYVVzRXFmVU9zWEZHU0kzS1FSQWJITEFqV1hQcEl5dXVx?=
 =?utf-8?B?T3pid2tmRk5Rd1NaVFUvNzNSS3Nac0NLYXM2K1dKWi9oalpXdTZNNmJPVlYy?=
 =?utf-8?B?b2Yza0pheUM3R25zTE8rYUg5SmJiM2lUbTg2K1gyc3EycnZxVDc1MmpHYWY1?=
 =?utf-8?B?SGxnMWgyczVZbE42SmRzbVBldGYvRUJVU0RuQmJNWTEwcHhrcHVPMGI3aHJ2?=
 =?utf-8?B?L1BXWXJZU3o2OTFoTklwVTY5U2NnUzFLMTNKL1lLbXMzd3JDMWduWjYrRjBo?=
 =?utf-8?B?blczckF5d1Rob3BUN0JnTXNKVmxhbHBjNVAydlZrZzFqZDVTNHdsN28xWTVp?=
 =?utf-8?B?bmNWWkwxckM2MUQ3ZUVvdnRzdGkxWGQ2dk1LL0pMUFNYM0Z3anFyaWxRMDJK?=
 =?utf-8?B?VTQ1Y2tsaFRMUlNabDZhN2M4R0JOaHlka2tROUp4OWF5WTRlczM5Tm51R2h6?=
 =?utf-8?B?dVJhejczdzhxNThzdS8wd3NQRHVuMkpMTjB0Zm5ubEI1cDYrd29xY0JEUitP?=
 =?utf-8?B?c08vNUxvZWpLTmRxNWFsbkIyNExwSTRtbyt3NEdnYktCbjIrN1JLb0Y0a2Zx?=
 =?utf-8?B?UjQwVFlhRWdLN3ZsdmRWU0VTbTFMODVqTUhSbmNmcWcxaXF6R0dWVkZOM0xz?=
 =?utf-8?B?WHh5YXpmNGM0VjE4LzhkM3gyTFp4RFFwaHR1TjZQb1U0RnhxM3NxVVIxRm54?=
 =?utf-8?B?OGUrd2ZwWEQvYXQ2RHorUXc0b0RXZmcvZUdLRlFoZ01YVWNpb2kxQThkMmdO?=
 =?utf-8?B?c2RnRGg4Y0d1UzA4MG5qaDRzaUkwcVJIM2ZaVjFtYWNQVlZkU1RjaUpzNU1H?=
 =?utf-8?B?REdhQVhQWU5GakNqSFJvWTJTalJjalVqZ0hnYys5bCt5dkdJb3FZUFJ1Vm1S?=
 =?utf-8?B?Tnd0WDZYaUwvVUZHYzduL2hQWURKbzUxTU9PVjI5MTd6SUlnNy9RcnNxMTdO?=
 =?utf-8?B?c0RVT1pMS1VFRHUwQnIrVkpEenV4cTl4ZVhnY3VjOGlYQ0FGbFdOQldNUDdZ?=
 =?utf-8?B?RkUyQkM4RHlaVHBqVDVneTMzbUhDWEVYQXlzUlR4Q0hPOG4vZjNsaithTTNR?=
 =?utf-8?B?MHFobGhDZlc1MVM3WUJkaUpMaGorR1RDVS9mU09MbHhwSHVJR2NUYW9PNmd3?=
 =?utf-8?B?Z0NJRHh4YVR2cFdTN3RHeHhYOFBwZ2NhbG4xUmhXTlVkYVkxWDZ6L2l1UXgv?=
 =?utf-8?B?cnM5UWVlL0IyYUpPQjJUY0ROTENVM2VvTUZvT082RDE0R05tZWN3c3ZYVzE2?=
 =?utf-8?B?eXNxTnltc3E3MCtDYStQSWpUTjVTQ3JwemozRjFIaVlDQVhHdXRGQzVadVRm?=
 =?utf-8?B?c3VqelIrZGd2b1RkZm5KaktpajEzV01EemJjbjN4dWdqbWtjTFJhSlU4Mk45?=
 =?utf-8?B?VUpxY2ZFT2hBZWtXbzFuSmc5VzdxNTRiS1lyM1IzZFRtNXNaU3VBNWMyYVds?=
 =?utf-8?B?Z1U3TFkybitSYnRYQWhxN2ljcEtpS3Jya3IzUkJabWprS2xUWHNOQ0RlRXB0?=
 =?utf-8?B?K2YvcUxBZ1JOaVlXSHMwalFvYlU1dUVnSFhTZHgvWEFPUXcySGZaUXYxNFhQ?=
 =?utf-8?B?ZGw5R2Urdkc3MEUwT1VMYlZtTXBmRTgwOFVrcXVzVUx4Q0RTQzN3V0p5TGlu?=
 =?utf-8?B?a0w4cDdLdFk0cVAyVkdqdGkzVDBGZG9DWVlYYnZUS0htVGZ6amNYRm90Rkli?=
 =?utf-8?B?WWVSdlpwVmhOV2Z5alIwcWtrS002TDRyUlZGeHZmdDg5a21xbkpCSWRLNjFh?=
 =?utf-8?B?ZXdCdzI5ZVlOL0JNeVFlTlJTaG1MdEF4eVFZSlpDRUZYY0Y0L2Y2aU9oYVRZ?=
 =?utf-8?B?RTZEbkRaNjliVlJsaWRqZ09lZjZaQk9lU09IcCtJakt0R0NuTUNUajZyVXpE?=
 =?utf-8?Q?skNc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9156344-e72a-45bb-117a-08da8698949a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 12:51:51.2153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqxUsZLxZxNIy6HSt+fNLGvF2qXc5e42jvhQGnHVFfb3SN3/NdiHCR73E5ytVS6Cd7HDsEmLssy8DeCiJNCHIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1206
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
Cc: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkdvb2QgcG9pbnQsIGFzIGlmICgx
IHx8IDApIHNob3VsZCBzaG9ydC1jaXJjdWl0IGF0IHRoZSBpZiAoMSkgcGFydC4gVGh1cyB3ZSBz
aG91bGQgZ28gZG93biB0byBOT1RJRllfRE9ORSBpZiBtIGlzIE5VTEwuIFlhemVuIGNhbiBjb25m
aXJtIGhlcmUsIGFzIGhlIHdhcyB0aGUgb25lIHdobyB3aXRoIG1lIHdoZW4gd2UgZm91bmQgdGhl
IG9yaWdpbmFsIGlzc3VlLiBJdCdzIHBvc3NpYmxlIHRoYXQgb25lIG9mIHRoZSAzIG1lc3NhZ2Ug
ZmllbGRzIHdhcyBOVUxMIGluc3RlYWQgb2YgdGhlIGFjdHVhbCBtZXNzYWdlIGluIG91ciByZXBy
byBzaXR1YXRpb24sIGJ1dCBJJ2xsIGRvdWJsZS1jaGVjayB0aGUgc2hvcnQtY2lyY3VpdCBzaWRl
IG9mIEMgdG8gY29uZmlybS4gSSBrbm93IGl0IHNob3J0IGNpcmN1aXRzIGZvciAmJiwgSSBkb24n
dCBrbm93IGlmIGl0IGRvZXMgZm9yIHx8Lg0KDQogS2VudA0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4gDQpTZW50OiBU
aHVyc2RheSwgQXVndXN0IDI1LCAyMDIyIDg6MzQgQU0NClRvOiBSdXNzZWxsLCBLZW50IDxLZW50
LlJ1c3NlbGxAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogR2hh
bm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGRybS9hbWRncHU6IEhhbmRsZSBwb3RlbnRpYWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlDQoN
Cg0KDQpPbiA4LzI1LzIwMjIgNToxNiBQTSwgUnVzc2VsbCwgS2VudCB3cm90ZToNCj4gW0FNRCBP
ZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+IA0KPiBGcmllbmRseSBwaW5nDQo+IA0KDQpX
b25kZXIgaG93IGl0IGdvZXMgYW55IGZ1cnRoZXIgd2hlbiBtIGlzIE5VTEwuIEl0IHNob3VsZCBk
byBzaG9ydGN1dCBldmFsdWF0aW9uIGFuZCByZXR1cm4gTk9USUZZX0RPTkUsIHJpZ2h0PyBPciBp
cyB0aGlzIGZvciBiZXR0ZXIgcmVhZGFiaWxpdHk/DQoNClRoYW5rcywNCkxpam8NCg0KPiAgIEtl
bnQNCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJ1c3NlbGwsIEtl
bnQgPEtlbnQuUnVzc2VsbEBhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCAxNSwgMjAy
MiAxMTozMSBBTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IEdo
YW5uYW0sIFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+OyBSdXNzZWxsLCBLZW50IA0KPiA8
S2VudC5SdXNzZWxsQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogSGFu
ZGxlIHBvdGVudGlhbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UNCj4gDQo+IElmIG0gaXMgTlVM
TCwgd2Ugd2lsbCBlbmQgdXAgcmVmZXJlbmNpbmcgYSBOVUxMIHBvaW50ZXIgaW4gdGhlIHN1YnNl
cXVlbnQgbSBlbGVtZW50cyBsaWtlIGV4dGNwdSwgYmFuayBhbmQgc3RhdHVzLiBQdWxsIHRoZSBO
VUxMIGNoZWNrIG91dCBhbmQgZG8gaXQgZmlyc3QgYmVmb3JlIHJlZmVyZW5jaW5nIG0ncyBlbGVt
ZW50cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFt
ZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMu
YyB8IDUgKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jhcy5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0K
PiBpbmRleCBhYjliYTVhOWMzM2QuLjAyODQ5NWZkZmE2MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiBAQCAtMjgzOCwxMiArMjgzOCwxNSBAQCBzdGF0
aWMgaW50IGFtZGdwdV9iYWRfcGFnZV9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5i
LA0KPiAgIAlzdHJ1Y3QgZWVwcm9tX3RhYmxlX3JlY29yZCBlcnJfcmVjOw0KPiAgIAl1aW50NjRf
dCByZXRpcmVkX3BhZ2U7DQo+ICAgDQo+ICsJaWYgKCFtKQ0KPiArCQlyZXR1cm4gTk9USUZZX0RP
TkU7DQo+ICsNCj4gICAJLyoNCj4gICAJICogSWYgdGhlIGVycm9yIHdhcyBnZW5lcmF0ZWQgaW4g
VU1DX1YyLCB3aGljaCBiZWxvbmdzIHRvIEdQVSBVTUNzLA0KPiAgIAkgKiBhbmQgZXJyb3Igb2Nj
dXJyZWQgaW4gRHJhbUVDQyAoRXh0ZW5kZWQgZXJyb3IgY29kZSA9IDApIHRoZW4gb25seQ0KPiAg
IAkgKiBwcm9jZXNzIHRoZSBlcnJvciwgZWxzZSBiYWlsIG91dC4NCj4gICAJICovDQo+IC0JaWYg
KCFtIHx8ICEoKHNtY2FfZ2V0X2JhbmtfdHlwZShtLT5leHRjcHUsIG0tPmJhbmspID09IFNNQ0Ff
VU1DX1YyKSAmJg0KPiArCWlmICghKChzbWNhX2dldF9iYW5rX3R5cGUobS0+ZXh0Y3B1LCBtLT5i
YW5rKSA9PSBTTUNBX1VNQ19WMikgJiYNCj4gICAJCSAgICAoWEVDKG0tPnN0YXR1cywgMHgzZikg
PT0gMHgwKSkpDQo+ICAgCQlyZXR1cm4gTk9USUZZX0RPTkU7DQo+ICAgDQo+IC0tDQo+IDIuMjUu
MQ0KPiANCg==
