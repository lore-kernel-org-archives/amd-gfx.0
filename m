Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B0EC54E41
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Mar 2024 14:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED3710F19D;
	Wed,  6 Mar 2024 14:45:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tBGX9jl1";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8862310F19D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Mar 2024 14:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0tIjo6eZOZk9o54Izu6tlSeXhD6qqPlNlsCPPpCc1SjxLIYWw3hKNBo6Ota3Iy/tpJNfbcmxm7BlKdHB8PpRM4ebHaW6bc3ARj4q7veztTgSB3jdrpEFuIAGkQrBHTJvc3t29+V+MsBRJBm55vU96xJvh/9IpzKK2t8HwS03n3xDjuXu9CBVSMOl079BwgQrkr8RAl76sMQPLyhv7+sk7JFyt+qQOT020F/76qEkJ6r9lw9cC7L924nSJRbZyF0RC3YGCSYa6SIy7vVaQW5aHMf4VPAACiIpKX6RrI99S6e7RK70mklqgXJpz/liWFz+hvqMP5EZr81YugFYMNC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sobEdVLOd8mgi6LN+jKoGG8mShzQO1VXo0wW7lpLYOM=;
 b=jz6xaC8OgSwxvEcj7on7tVGHsadhVNYh7d/HTTV5zFDPOrkXEIyPsG/7DPDJ5G8Lqsnb78ulfmOAjU93JzV3RYjjhnU2p/dAfpCPEU0/UuYRWE73jYAi5s1lkB3bKT6EW5uG8oZ+3Y17vAYSktSS1jhvnb9FGk5WViSUoflV3IdE4L+R4jQ80YDOAZqwiA9l9H/XOcDRrKjOLUdWTfKssa2te5/M4sU7hV/8BmyYLUozltuBfBOq9siv3JSakWlkmCG+L0pcEmWsmZQer1WiO8TX/jUU39TWerulixd3pg6K7jYS4u49y/ULdeLaUNaI43Ge7PY9FA8vyJj+816aYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sobEdVLOd8mgi6LN+jKoGG8mShzQO1VXo0wW7lpLYOM=;
 b=tBGX9jl1D3nLJN7xHYQxu88jLtvG0Bdwl2QpGMlLHXiwsM19SBfNvhHD2WZmmpbHjqkyElMEN0D89zJlM7QBfqWQL7gPDe6UvoIa71Q/2Y50VwD9+J3Jv6+J9j6L6bjO0bf+qIbcxPcAydl0nynOOetJB2DW+/Igq3bNMg2bHM0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 14:45:13 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae%7]) with mapi id 15.20.7362.024; Wed, 6 Mar 2024
 14:45:13 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?gb2312?B?stzX08H6?= <gainerying@163.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Yat Sin, David" <David.YatSin@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: Re: Re:RE: Why has to offer "/dev/drv/render128" fd when running ROCm
 demo?
Thread-Topic: Re:RE: Why has to offer "/dev/drv/render128" fd when running
 ROCm demo?
Thread-Index: AQHabwOJP4qNdOXXdEG27AnQsGo9dbEplgJ4gAAGlDCAAJLBAIAAnEbQ
Date: Wed, 6 Mar 2024 14:45:13 +0000
Message-ID: <BL1PR12MB5144F26E487F5DE355C927D5F7212@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <26c1a512.11d3c.18e0edda56b.Coremail.gainerying@163.com>
 <BL1PR12MB51446D775639DE08F0C909F2F7222@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BN9PR12MB511505BAEBB3578722974CFC92222@BN9PR12MB5115.namprd12.prod.outlook.com>
 <3fadf81a.7dac.18e123934a3.Coremail.gainerying@163.com>
In-Reply-To: <3fadf81a.7dac.18e123934a3.Coremail.gainerying@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-03-06T14:45:13.127Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BY5PR12MB4178:EE_
x-ms-office365-filtering-correlation-id: b0503185-5445-4a4e-60a2-08dc3dec07f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0uGFCD1F9UF/nWdPVHwGter2IH1zZtcPkklIIRCsX/MzJ2OaazXoNEU4sRWXWNpBHQjmBSuxb3hc7lehCxAOwu4hTsajW00E3XQtZ6mPa/wIoKuOmb87t/nf+PLXY416v5bQ5NxNe+wBuuPs7wnUBvbr5SYll7wrG+39oJFp3VMROLaygN4abUcRmpRXhH3U31+TTR4np6jB7gj270iJa68uL8qLIv7AA1r/fBJzrQMFctzmTIZL17E7haqQl0KnhS351800hFm2CZ7ACdyH2wna5/ixGeBuOgjWmX4J5eqf4qvVoXerWFUPt6NYFs2DxVJm1nl5Li+CCLbjOznaGOj9/VSWh7ireCfusJ5zBz40MinOCEPrHEJVqjzcKaJVNwBCqsJqPWvT9C7A5m2DoqprMH0gNvwZBP/O92qTymPJOhDT4JGNjwPk8ai9cxv3eqGWgLzzosG4CQVi20ZAR/59c82Qt4XLWAUb4uI9iCY/zaeESOOwHgZKj23tmw+SV/3/sGNMeS8oUzKj5ea+vR34Rov6CtnvsltnGeqUAz0gHaubKG9VkvZ2jycFERDLQlPmbL4WAvqHvOndcBk75pPx1v9U+rov2n77QRg1sjwuT3YLVR0mrerNE+kQshiBQDuvYpi+Glvgte41uPrnr/mXevnJC6SZyQsSzrVCio9zyEdazio7tM7U6ssGQpcBAHLbZpeHAnaLMYhxHH5NWA0XKLgC7+W7/PjcmR+HR0k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eWpWUmVkcE9STGtNeCsrWUJCbWtVS1NYOEtVN2srWmZkcmVwR3dlNWV4WlUr?=
 =?gb2312?B?c00xakx5eVNucWg0Q0ZTbkxRbnF5dlFDYlR2ZG9PdjczYTloWTN0VzBPS3ZO?=
 =?gb2312?B?a2NVTHN6aSs0ZDAySExYcXd0Nk9WUGhMSnA0RjRYTjdKaCtleDR6SVd6eUZx?=
 =?gb2312?B?SUZXMGYxaW05clh2eTFxUUtTazh6K1lCbm5CenlMTEZBVmdhU29aREI1eXZ0?=
 =?gb2312?B?aUhSaThOQmJVWGtnYnJFT2MxSzNpOWo1Y08xTzJmdW1nL0IyMHp6Y1Q3c3RK?=
 =?gb2312?B?TUN6THJySm9QTWNReUJvdTBBTDdRK0d4YmlHVTZQeDBrZUI1c3ZtcjVXTDRs?=
 =?gb2312?B?MVFBVDBQZDR0aWRDc3ZBL0JjcjFSOU8rdllLTFlpMEtzWVpsZ05IUjM2MDJM?=
 =?gb2312?B?SWFpYUhDSG9ZMmdkaGc2RS9IZGVzSU5VMTQ0UUtvb09KeEZKcmFNNGJSdzFE?=
 =?gb2312?B?SW1FWE5jWndodVJHNDA5WWpaMU1zY0k1NFlOUG9QcUFwRkNjbzVHUlBQYUgv?=
 =?gb2312?B?WVYrRGFJZU8zUmpaeWlWMm95RnZHUmt5QmhKNStYVktlZlJNNkpYQUU4V2c1?=
 =?gb2312?B?Y3FEL2RjRHphRnRaaXN3YS9wSkFmelg4bHlmSmhDd3NWQzl0ZzRMQ1N4Z05C?=
 =?gb2312?B?ZG1nQll2NXJCWUliZlp1Q3dQNGtMSmxqc2dEeGt1SmR2T0k5OXRNR0JaVWcr?=
 =?gb2312?B?V041MG03TWlKczhXbnZwUk9EYUtDUG10U2JJZVBObHk0UmlrZnpWbmJiYWxT?=
 =?gb2312?B?WitoUHpvdEZwcjBZOXp1Z21haEF2eXBBdlJabFZVbjY4TkI4UFFiTnh6ellj?=
 =?gb2312?B?NlhzOWNUNEpOVlRVVk5RWUNtM1oxOFY3VFZXc2xwNEJvTm1TV1VrL21KSDkr?=
 =?gb2312?B?Q1B0YkZCcEsxcGg3ZFdIeUQ1b1FWb2p3KzNiSWd2S0FUaDRhODE4NC9WTHQy?=
 =?gb2312?B?b2JDQkt2OTl3SEEyM1R1aTFvWW1hR0tNaXRULy9qQlNlbDlycTMrUWVTTVFw?=
 =?gb2312?B?RHFQMllTcUpKTkpJNXBQbXYreFVpSlZHUDUyVUFzSXlSSXI1L0FkNG5kWW1R?=
 =?gb2312?B?Z1djaG1nMUhjenpsbU5xc0dOSUF3d3ZldStBVlFnOGY1dVdrZTZWMkJoUnZR?=
 =?gb2312?B?b0puUlNadit1bWxwVkxhY2RCZS9SMGJxOUtLZ0kra1gvZjJ4Q1N6WHRkMUJw?=
 =?gb2312?B?UGRtUWQyZW91Z3U5d0w1Tks3eE51RmluakxWUUtyTmdycVQ1aXZsSmkyejli?=
 =?gb2312?B?VUVxemlvNXVNQVJoeDJFUU5YY0JQcWJwbVlCY2kwbXdHb0FEK2FSSVc3V05l?=
 =?gb2312?B?TlEyN3ZCWi9LRWZRdWUwZVVJUy9YbU1FUURwbVRnb0kvRVBMUnJhRldORVBN?=
 =?gb2312?B?Mzd0VGRNSmZPN0FBdnl3Qy9QYXhjZSs2M0Z0U1hOYUpFb05HbjRQV1ZXTXhY?=
 =?gb2312?B?LytQY1NJcXphZE1FSGdQeHA2Njh5c2tXbkNzK0lmMFNkODVyNFFUN3M5Ym1N?=
 =?gb2312?B?SnJVSjlLa29YcHFCSStSdjJUVnVRbkpuQUI5MFFQUFlsU3lhSmVvUy85Tkhq?=
 =?gb2312?B?WGxFUFEwd0RTZXkveEFJVWNMYmszdS9xZHJTblRIOWdUemd1b2gwNlY2TjRi?=
 =?gb2312?B?SGQya0Fyamk0S1padDhGUVdkUWJCTFh0cnF4V05PT21oQWFhR25FeDdVOFp3?=
 =?gb2312?B?dE1xMklIelkxcTFWM0V2a1BxamxtUlhMbytpalhNQXNMVjQ2amthWU9XbVRZ?=
 =?gb2312?B?TVM4TWdVR1hWbzhEbEozaGp2WCsvWGRnbXlrVDZKVWNFeXRMcTN5bjJYZjJM?=
 =?gb2312?B?L3R5MkRETE14SkMzaTBYcEpoUzdlYUpWemxMdlJOb1NwYlJlRDJGdVdJS0hD?=
 =?gb2312?B?RGpsR0xYRzAvcHhuVVlsem5KV3B6N2VJMnRZd0NCV09XTG4vYnlVTlBjbDdO?=
 =?gb2312?B?VUIvTVZPUnIyR1h3WlprWXN4aDd5WG96ekJyWVhhdk1UaW9LRFhBWmVkRzd3?=
 =?gb2312?B?bGtJUHF2bDF0Sm05NlFwWm8vUjkvOEVmL0FtUEN1ZXk5Y0FRYTVyNy9zbzlI?=
 =?gb2312?B?SWhmdjVlN3NaeW9mR01JT3pVeXdBZUFMOTRCS2dVREsxa21EKzk4YTBoQzhI?=
 =?gb2312?Q?elTM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144F26E487F5DE355C927D5F7212BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0503185-5445-4a4e-60a2-08dc3dec07f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 14:45:13.4462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZeAP/UaPzqU6xtuBpt2nrq2qJq9h5HLicbn9oBbGyqlUmQPJuZriNKBujjgzZhx5Jp3O5GcF3M9OI/pZa4O/Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
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

--_000_BL1PR12MB5144F26E487F5DE355C927D5F7212BL1PR12MB5144namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W1B1YmxpY10NCg0KTm8gc3VjaCBzaXR1YXRpb24gZXhpc3RzLiAgdGhlcmUgaXMgYWx3YXlzIGEg
cmVuZGVybm9kZS4NCg0KQWxleA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
RnJvbTogstzX08H6IDxnYWluZXJ5aW5nQDE2My5jb20+DQpTZW50OiBXZWRuZXNkYXksIE1hcmNo
IDYsIDIwMjQgMTI6MjUgQU0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyA8YW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWWF0IFNpbiwgRGF2aWQgPERhdmlkLllhdFNpbkBhbWQu
Y29tPjsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KU3ViamVjdDog
UmU6UkU6IFdoeSBoYXMgdG8gb2ZmZXIgIi9kZXYvZHJ2L3JlbmRlcjEyOCIgZmQgd2hlbiBydW5u
aW5nIFJPQ20gZGVtbz8NCg0KSGkgZmVsaXg6DQogICBUaGFua3MgZm9yIHlvdXIga2luZGx5IGhl
bHAuDQoNCmkgc3RpbGwgaGFzIGEgcXVlc3Rpb24sIGlmIG9uIGEgcHVyZS1jb21wdXRlIHBsYXRm
b3JtLCB3aGljaCBoYXMgbm8gL2Rldi9kcmkvcmVuZGVyIG5vZGUsIGJ1dCBvbmx5IHdpdGggYSBz
aW5nbGUgL2Rldi9rZmQgbm9kZSwgaG93IHRoZSBjb21wdWUgc2NlbmFyaW8gd29ya3Mgc2luY2Ug
dGhhdCB3ZWkgaGF2ZSBubyAicmVuZGVyIiBmZCBleGlzdHM/DQppcyBzdWNoIHBsYXRmb20od2l0
aG91dCByZW5kZXIgbm9kZSkgZXhpc3RzPw0KDQogdGhhbmtzIGZvciB5b3VyIGtpbmRseSBoZWxw
LiENCg0KQlJzDQp6bGNhby4NCg0KDQoNCg0KDQpBdCAyMDI0LTAzLTA2IDA0OjQzOjMwLCAiS3Vl
aGxpbmcsIEZlbGl4IiA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4gd3JvdGU6DQoNCltBTUQgT2Zm
aWNpYWwgVXNlIE9ubHkgLSBHZW5lcmFsXQ0KDQoNCkkgYWxyZWFkeSBhbnN3ZXJlZCB0aGlzIHF1
ZXN0aW9uIGluIGEgcmVwbHkgdG8gYW5vdGhlciBlbWFpbCB0aGF0IHdhcyBhZGRyZXNzZWQgdG8g
bWU6DQoNCg0KDQpUaGUgcmVuZGVyIG5vZGVzIGFyZSB1c2VkIGZvciBDUFUgbWFwcGluZyBvZiBW
UkFNIHdpdGggbW1hcCBjYWxscyBhbmQgYW4gb2Zmc2V0IHRoYXQgaWRlbnRpZmllcyB0aGUgQk8u
IFRoZSByZW5kZXIgbm9kZSBhbHNvIGNyZWF0ZXMgdGhlIEdQVSB2aXJ0dWFsIGFkZHJlc3Mgc3Bh
Y2UgdGhhdCBpcyB1c2VkIGJ5IEtGRCB0byBjcmVhdGUgdGhlIEdQVSBtZW1vcnkgbWFwcGluZ3Mu
IEFwcGxpY2F0aW9ucyB0aGF0IHVzZSBib3RoIGdyYXBoaWNzIGFuZCBjb21wdXRlIGNhbiBzaGFy
ZSB0aGUgc2FtZSBHUFUgdmlydHVhbCBhZGRyZXNzIHNwYWNlIGluIHRoaXMgd2F5Lg0KDQoNCg0K
WmxjYW8sIGluIHRoZSBmdXR1cmUsIHRoaXMgdHlwZSBvZiBxdWVzdGlvbiBtYXkgYmUgYmV0dGVy
IGFkZHJlc3NlZCB0byBhIG1haWxpbmcgbGlzdCBzdWNoIGFzIGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnLCBpbnN0ZWFkIG9mIHdyaXRpbmcgc2VwYXJhdGVseSB0byBkaWZmZXJlbnQgbWFp
bnRhaW5lcnMuDQoNCg0KDQpSZWdhcmRzLA0KICBGZWxpeA0KDQoNCg0KDQoNCkZyb206IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NClNlbnQ6IFR1ZXNkYXks
IE1hcmNoIDUsIDIwMjQgMzoxNyBQTQ0KVG86ILLc19PB+iA8Z2FpbmVyeWluZ0AxNjMuY29tPjsg
S3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgWWF0IFNpbiwgRGF2aWQg
PERhdmlkLllhdFNpbkBhbWQuY29tPg0KU3ViamVjdDogUmU6IFdoeSBoYXMgdG8gb2ZmZXIgIi9k
ZXYvZHJ2L3JlbmRlcjEyOCIgZmQgd2hlbiBydW5uaW5nIFJPQ20gZGVtbz8NCg0KDQoNCltBTUQg
T2ZmaWNpYWwgVXNlIE9ubHkgLSBHZW5lcmFsXQ0KDQoNCg0KKyBGZWxpeCwgRGF2aWQgdG8gY29t
bWVudC4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KRnJvbTogstzX08H6
IDxnYWluZXJ5aW5nQDE2My5jb208bWFpbHRvOmdhaW5lcnlpbmdAMTYzLmNvbT4+DQpTZW50OiBU
dWVzZGF5LCBNYXJjaCA1LCAyMDI0IDg6NDYgQU0NClRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb208bWFpbHRvOkFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
Pg0KU3ViamVjdDogV2h5IGhhcyB0byBvZmZlciAiL2Rldi9kcnYvcmVuZGVyMTI4IiBmZCB3aGVu
IHJ1bm5pbmcgUk9DbSBkZW1vPw0KDQoNCg0KSGkgYWxleGFuZGVyLjoNCg0KICAgICAgc29ycnkg
Zm9yIGJvdGhlci4gYnV0IGkgcmVhbGx5IG5lZWQgc29tZSBoZWxwIHRvIGRlYWwgd2l0aCBteSBw
dXp6bGUuDQoNCmkgYW0gYSBmcmVzaG1hbiB0byBBTUQgR1BVIERyaXZlciwgTk9XIGkgYW0gdHJ5
aW5nIHRvIHdyaXRlIGEgc2ltcGxlIGRlbW8gdG8gdXNlICIvZGV2L2tmZCIgYW5kIGRvIHNvbWUg
IHZyYW0gYWxsb2MvZnJlZSB0ZXN0cywgIGJ1dCBpIGZvdW5kIHlvdSBtdXN0IGRvIHRoZSByaWdo
dCAiQU1ES0ZEX0lPQ19BQ1FVSVJFX1ZNIiBpb2N0bCBjb21hbW5kIGJlZm9yZSB5b3UgdHJ5IEdQ
VSB0byBkbyB2cmFtIGFsbG9jYXRpb24gYW5kIG90aGVyIHRoaW5ncy4gIGZyb20gdGhlIGtmZCBk
cml2ZXIgY29kZSx0aGUgcHJlLWNvbmRpdGlvbiB0byBkbyB0aGUgcmlnaHQgIkFNREtGRF9JT0Nf
QUNRVUlSRV9WTSIgaXMgdG8gb2ZmZXIgYSAiL2Rldi9kcnYvcmVuZGVyMTI4IiBmZCAgdG8gdGhl
IHBhcmFtZXRlcnMuDQoNCg0KDQpzbywgd2h5IG5lZWQgdG8gZG8gdGhpcz8ga2ZkIGlzIHVzZWQg
Zm9yIGNvbXB1dGUsIGJ1dCAiL2Rldi9kcmkvcmVuZGVyMTI4IiBpcyBzcGVjaWZ5IHRvIGdmeCB1
c2FnZWQsIHdoeSBtdXN0IG9wZW4gdGhlICIvZGV2L2RyaS9yZW5kZXIxMjgiIGR1cmluZyB0aGUg
S0ZEIGNvbXB1dGUgc2NlbmFyaW8/DQoNCnRoYW5rcyBmb3IgeW91ciBraW5kbHkgaGVscCENCg0K
DQoNCkJScw0KDQp6bGNhby4NCg0KDQo=

--_000_BL1PR12MB5144F26E487F5DE355C927D5F7212BL1PR12MB5144namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
No such situation exists.&nbsp; there is always a rendernode.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Alex</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> =B2=DC=D7=D3=C1=FA &l=
t;gainerying@163.com&gt;<br>
<b>Sent:</b> Wednesday, March 6, 2024 12:25 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Yat Sin, D=
avid &lt;David.YatSin@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.c=
om&gt;<br>
<b>Subject:</b> Re:RE: Why has to offer &quot;/dev/drv/render128&quot; fd w=
hen running ROCm demo?</font>
<div>&nbsp;</div>
</div>
<div>
<div style=3D"line-height:1.7; color:#000000; font-size:14px; font-family:A=
rial">
<div style=3D"margin:0">Hi felix:</div>
<div style=3D"margin:0">&nbsp; &nbsp;Thanks for your kindly help.</div>
<div style=3D"margin:0"><br>
</div>
<div style=3D"margin:0">i still has a question, if on a pure-compute platfo=
rm, which has no /dev/dri/render node, but only with a single /dev/kfd node=
, how the compue scenario works since that wei have no &quot;render&quot; f=
d exists?<br>
</div>
<div style=3D"margin:0">is such platfom(without render node) exists?&nbsp;<=
/div>
<div style=3D"margin:0"><br>
</div>
<div style=3D"margin:0">&nbsp;thanks for your kindly help.!</div>
<div style=3D"margin:0"><br>
</div>
<div style=3D"margin:0">BRs</div>
<div style=3D"margin:0">zlcao.</div>
<p style=3D"margin:0"><br>
</p>
<p style=3D"margin:0"><br>
</p>
<p style=3D"margin:0"><br>
</p>
<div style=3D"zoom:1"></div>
<div id=3D"x_divNeteaseMailCard"></div>
<p style=3D"margin:0"><br>
</p>
<p>At 2024-03-06 04:43:30, &quot;Kuehling, Felix&quot; &lt;Felix.Kuehling@a=
md.com&gt; wrote:</p>
<blockquote id=3D"x_isReplyContent" style=3D"padding-left:1ex; margin:0px 0=
px 0px 0.8ex; border-left:#ccc 1px solid">
<div><style>
<!--
-->
</style>
<div lang=3D"EN-US" style=3D"word-wrap:break-word">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0000FF=
; margin:5pt; font-style:normal; font-weight:normal; text-decoration:none">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif">I already answered this question in a reply to a=
nother email that was addressed to me:</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif">&nbsp;</span></p>
<p class=3D"x_MsoNormal" style=3D"margin-left:36.0pt"><span style=3D"font-s=
ize:11.0pt; font-family:&quot;Calibri&quot;,sans-serif">The render nodes ar=
e used for CPU mapping of VRAM with mmap calls and an offset that identifie=
s the BO. The render node also creates the GPU virtual
 address space that is used by KFD to create the GPU memory mappings. Appli=
cations that use both graphics and compute can share the same GPU virtual a=
ddress space in this way.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:10.5pt; font-family:&quot=
;Arial&quot;,sans-serif; color:black">Zlcao, in the future, this type of qu=
estion may be better addressed to a mailing list such as amd-gfx@lists.free=
desktop.org, instead of writing separately to
 different maintainers.</span><span style=3D"font-size:11.0pt; font-family:=
&quot;Calibri&quot;,sans-serif"></span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif">Regards,<br>
&nbsp; Felix</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif">&nbsp;</span></p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0c=
m 0cm 0cm">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0=
pt; font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander &lt;Ale=
xander.Deucher@amd.com&gt;
<br>
<b>Sent:</b> Tuesday, March 5, 2024 3:17 PM<br>
<b>To:</b> </span><span lang=3D"ZH-CN" style=3D"font-size:11.0pt">=B2=DC=D7=
=D3=C1=FA</span><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&=
quot;,sans-serif"> &lt;gainerying@163.com&gt;; Kuehling, Felix &lt;Felix.Ku=
ehling@amd.com&gt;; Yat Sin, David &lt;David.YatSin@amd.com&gt;<br>
<b>Subject:</b> Re: Why has to offer &quot;/dev/drv/render128&quot; fd when=
 running ROCm demo?</span></p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt; font-family:&quo=
t;Arial&quot;,sans-serif; color:blue">[AMD Official Use Only - General]</sp=
an></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">+ Felix, David to comment.</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif; color:black">From:</span></b><span style=3D"f=
ont-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">
</span><span lang=3D"ZH-CN" style=3D"font-size:11.0pt; color:black">=B2=DC=
=D7=D3=C1=FA</span><span style=3D"font-size:11.0pt; font-family:&quot;Calib=
ri&quot;,sans-serif; color:black"> &lt;</span><a href=3D"mailto:gainerying@=
163.com"><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,s=
ans-serif">gainerying@163.com</span></a><span style=3D"font-size:11.0pt; fo=
nt-family:&quot;Calibri&quot;,sans-serif; color:black">&gt;<br>
<b>Sent:</b> Tuesday, March 5, 2024 8:46 AM<br>
<b>To:</b> Deucher, Alexander &lt;</span><a href=3D"mailto:Alexander.Deuche=
r@amd.com"><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;=
,sans-serif">Alexander.Deucher@amd.com</span></a><span style=3D"font-size:1=
1.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">&gt;<br>
<b>Subject:</b> Why has to offer &quot;/dev/drv/render128&quot; fd when run=
ning ROCm demo?</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p><span style=3D"font-size:10.5pt; font-family:&quot;Arial&quot;,sans-seri=
f; color:black">Hi alexander.:</span></p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:10.5pt; font-family:&quot=
;Arial&quot;,sans-serif; color:black">&nbsp; &nbsp; &nbsp; sorry for bother=
. but i really need some help to deal with my puzzle.&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:10.5pt; font-family:&quot=
;Arial&quot;,sans-serif; color:black">i am a freshman to AMD GPU Driver, NO=
W i am trying to write a simple demo to use &quot;/dev/kfd&quot; and do som=
e&nbsp; vram alloc/free tests,&nbsp; but i found you must do the right
 &quot;AMDKFD_IOC_ACQUIRE_VM&quot; ioctl comamnd before you try GPU to do v=
ram allocation and other things.&nbsp; from the kfd driver code,the pre-con=
dition to do the right &quot;AMDKFD_IOC_ACQUIRE_VM&quot; is to offer a &quo=
t;/dev/drv/render128&quot; fd&nbsp; to the parameters.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:10.5pt; font-family:&quot=
;Arial&quot;,sans-serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:10.5pt; font-family:&quot=
;Arial&quot;,sans-serif; color:black">so, why need to do this? kfd is used =
for compute, but &quot;/dev/dri/render128&quot; is specify to gfx usaged, w=
hy must open the &quot;/dev/dri/render128&quot; during the KFD compute
 scenario?</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:10.5pt; font-family:&quot=
;Arial&quot;,sans-serif; color:black">thanks for your kindly help!</span></=
p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:10.5pt; font-family:&quot=
;Arial&quot;,sans-serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:10.5pt; font-family:&quot=
;Arial&quot;,sans-serif; color:black">BRs</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:10.5pt; font-family:&quot=
;Arial&quot;,sans-serif; color:black">zlcao.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:10.5pt; font-family:&quot=
;Arial&quot;,sans-serif; color:black">&nbsp;</span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</blockquote>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB5144F26E487F5DE355C927D5F7212BL1PR12MB5144namp_--
