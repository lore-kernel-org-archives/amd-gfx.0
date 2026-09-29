Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E08C9832A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 05:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 154FF10E5E4;
	Tue, 29 Sep 2026 05:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NN3OQ4Am";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C647310E5E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 05:45:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEM4jsq2qI8crS2pddH5GmKBABTH3mp2MWP4sMatxg4P8Jc/nwrf5NywYIIFWp8pmXeTxOfSV0D1k3COrO+dMt9W+y4u1iVQc1NQEe9MCdl+kdPbgAKOnwRNgG2tIz9ocuG8SZQ4c7tAoz7JTdU6nBCYit+D4wsR+K2jE6mMufuAUBt1UfyCw97iS3/ozg3248wSJz30f3FWhm+REgC1/KBlYNobR5f7luBXpIQAH/b8w/H7/wfE1VPt6dzuSJYFj+RXCfCEJFIHKJvUyYykRNpfWFIDXHoUrNxZ7KcwBT+FK5n+RwMs+qiRJSi3ekJ51myDQVuO+UCL6F7heCEVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deq250oy/NC0pecYbUl4n/mx0DBaV3Syr1OWN8Lc2ZM=;
 b=UY8BDkkjT5juAabO3VPQljhMNq1bjKkSciBkw3wRDwlAU7uZW2623xXoFBMZpwg3c2xwppvii6J1EEjNLzK68jbyv0RFbEBQlR/JY8PxOxNzzfmhpVK0PpPyH2ldi8j7msIDpE0qkuHNwymb5rKAfeM4Ftg8SE4/jZJYoYT6pMX69O1b298VreGYUmcSm7xJgVWfSRUtBwm+6ILdnzDKXTD1UTLEt2tNQUAqbVCm5mzoG3K5hPmblaiZOLpjMjfeEstnx+83wUB4BQnzelCRE5nXRmpSeLlAk8ecj44MgmKkVu5JqlU0B8ASdx+G2d2xM8wnNxWmzl5Lgmt+1bkjLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deq250oy/NC0pecYbUl4n/mx0DBaV3Syr1OWN8Lc2ZM=;
 b=NN3OQ4Am4yPTGHmRMTKwaIach5P1wg4HjSoiyxZf8jWXoqbZ7pMdNqQSj8D1mKGP7M1oKt90V/cri5S1XifJr6kP+13wxRcN9QbAbT5sEJAs6xR9+8gcBTbPArZ0n95QMwNEeLjmuJWntSWXsvTeEK9kRqA/e5ozl1b3s2AyHEk=
Received: from CY1PR12MB9699.namprd12.prod.outlook.com (2603:10b6:930:108::5)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 05:45:24 +0000
Received: from CY1PR12MB9699.namprd12.prod.outlook.com
 ([fe80::e27c:fbef:402c:4440]) by CY1PR12MB9699.namprd12.prod.outlook.com
 ([fe80::e27c:fbef:402c:4440%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 05:45:21 +0000
From: "Wang, YuBiao (Ethan)" <YuBiao.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip PF-only programming on the VF
Thread-Topic: [PATCH] drm/amdgpu: skip PF-only programming on the VF
Thread-Index: AQHdS/KUb9t8bnjDKE+V0w2jWFiCpLblELmAgAACJ3A=
Date: Tue, 29 Sep 2026 05:45:21 +0000
Message-ID: <CY1PR12MB9699451FD7B93462739D3442E58C2@CY1PR12MB9699.namprd12.prod.outlook.com>
References: <20260924070129.2150408-1-YuBiao.Wang@amd.com>
 <3ee41db3-c971-4954-91ba-a00b235d3115@amd.com>
In-Reply-To: <3ee41db3-c971-4954-91ba-a00b235d3115@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-29T05:42:59.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR12MB9699:EE_|PH7PR12MB6465:EE_
x-ms-office365-filtering-correlation-id: 9cde924c-92b9-4540-3295-08df1decd9f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|18002099003|22082099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: I6AyhPicUuTF/cLeBYA+u/6Fq4Ol3OysU85f1cdk8iz5lDONLbeg1IXQVq0GBNtL7NkYSKcnl71jBOcpuW7k0wlc3sv0WAyHT5SmnzoP28K/vX79DmMRc+iXeBkZxfBsQJU+jjJgc3o0ccqAlfYR5rG1N2wCS3EjHIY8ccio17Rlql0YjMhTQDFsiwipDH0Is2fkOvBV0iWW5SQSwJOMCOfcJwHCv3q+QwCN5EOQlkBi+mrPfcHEzICoGQo2xXbaazIKMkwK6jNyghPL5P/AVWpdCUchZcSAyL6EIY+4fbtEkod0mAn3FVHO0sn8rmGCxb5Mnmg+V9DZRU/HHIX0q1Kq9touF9/h3c95P7+gKCPIyhJ50c7Lg/mC4HV3PXZwQFJaICX6ReOkEaVTe5UqyfVCvOEZTqu0x3AOGWPyLYy5lwRCx4a97pztSzOJIBXAo6Du8htq/rJ6V0Owgusn/hDBX6ZSTVZIplxUZkAE6IsF5pepKX0MOfptduPJJS2Q2PIPsWZNAvpM94aHYaAkBBeLtSGMO5iEfb3qv01b+84g1smHY8eccEQOf+KKr/W6Dy9+24J6sfuQEvcjOi6oMOymr8EzG1mI/3wt0iXDHvFregjF7LxeK98UN+Bi76vm+OdWUJe8vs3NQPYGe29DZuLdDTZdFhjGQnh7MfZMex9AA5XHmZaZQ5AWPDfnZXGpvEBuxJ7s0pJx1jtnSHnl/HXft0nvnAFAkRVVMueNlJ0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR12MB9699.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHZPVUJGTUgzVFp2c3NJQnpmeDc0eFcvN0YrY1Q0M3pQM3BpSDVkbXlaNDlh?=
 =?utf-8?B?WFRvZFdDUHlYNW80cXllOEhYbWRqbVJHNExjZnhwL29yWGNFdEludHlmOGNN?=
 =?utf-8?B?RWY2WUZoN2NmamFuWDFpall5VG9JRS8yaTVPckVqRDNiQVAwRFdDYjJFZlgr?=
 =?utf-8?B?Q2x5WFd1c2NlTHJJM0EwNEFkbmcxa0U2aFdOL0t3YW9jK2gwQUV1b0xPZE5K?=
 =?utf-8?B?Mkt6WjcxZStKbHlTcnVUT3R3by92UGVFaFpLck5qSG8rR1F5TGhzLytoUDRa?=
 =?utf-8?B?VjlDSS9RT0FkM3k1VCtoUFBoenFDTFljK2l2TGlHc0tpc3I0Z0VHN1dZd1Rt?=
 =?utf-8?B?VzNDcEQ2V2RlSU1EUkhwend0K0xkaEFjMHdRTytmYVFnNExSWitqNzJnM0h4?=
 =?utf-8?B?SmRQb1lEcGtKTUVBNnh1MmVYcHkxVVBiekpRZ3FPeGZxR1Q1NTh0NU9EZXhw?=
 =?utf-8?B?b1hpRWVPU1V2UXFqc1VPUHVPdFhpUnZaY29VM0Y0WEpPM0VwelpoN1RvaEhn?=
 =?utf-8?B?TmVVaGtIVWhkdzcwMXI1UFVvdU1MNkxWQWRpaTgvTGdRTFQ0V2lvTGRTM2NZ?=
 =?utf-8?B?ZFNUL2JEOTI1dkV3LzIrb2RLc0QvWmdsN3U2RkZBTlowcTA3dlhzVFhhSDVC?=
 =?utf-8?B?NUh4SzJKSGFwdWdSWWNUWnpEZWd2MmZTWkdsaWwrWHZKSFNZcjNXSXFsajd6?=
 =?utf-8?B?NUt0SmFKRllSbktLQ2VnZEJMN3ZObnI5QWdJQ1RmdUFMREN0ZGJ3ME9oc01M?=
 =?utf-8?B?eDNyTlUxenB5V2I2UWVrd3ZtdVNyMXlHVlEySHVMTEFYZWc3RjRzZDM4TGlr?=
 =?utf-8?B?SW5XRW9XTEtscWN5dHA1TGwveHNNUklwZThrZnVkdkYvZlhnWWw3Rkl5M2dr?=
 =?utf-8?B?c0pEa0pHd2NEcXZBSHRUNExNN00rRVhUNzhRSUQ2YlNMMWNsYzhZWDd1a01q?=
 =?utf-8?B?VHMxTExFbk1xeWJOeGJ3RGRuSGhsQ2t3S1FOQ292Y3hvc1NnZWx6clpKb0Zi?=
 =?utf-8?B?Y3ZIdTVWdGVJczNKd1d6KzV1UjFxcVJRcFRkZDVZNEowa1ZZUDJ1cXRKRzYz?=
 =?utf-8?B?Slh4NEFJL2poRiswUUpXTk0wbjJlNzM2eGJZeStnTUxiZ1RlSjlFRS9semMr?=
 =?utf-8?B?WUYrWUY5RTExM1I1TEFlZTZxaFMySmx3Q0UvR2hlTXcrdjdHTit2VjlDeEp0?=
 =?utf-8?B?V0xxZURvajRoSnVGcFJKQnFieklGRGt2Z0lWNmNUMU9oWW4vQnFRWHNDMVVI?=
 =?utf-8?B?d2laZzVJcFRCQ1RlVllrVVh5bUdtdW9NL2tmZE11NTNYaEhuNzl3ekd2Kzdv?=
 =?utf-8?B?NjdNdFUzeDdYdGxNQmhOcWJaMFlxQjJmRXhLd0thMzMrd1E5SFd4VW9JR09O?=
 =?utf-8?B?RXdZMzhCc0Y4SFhlWmRBeVlERGxlY0RIUzN0bWFFNG4rNUFIMnBqcGljS3JE?=
 =?utf-8?B?Qm00T3Q0ckNuQk5OOFd4VSszV0ozNjJLMUhkL20zdFRZSWJFQmV5dm4xcklj?=
 =?utf-8?B?UUdBRXhLWGJOcW9CVGt5NjdXMlpUazZjd1BudVUyTDQ5N0NsS3VQUktrRmp0?=
 =?utf-8?B?UXUzWmdjbTFvQUFTWEhCVjkrUDVVQ1I0ZU5XelhDaklVQU5RR2hxdTdyRjRr?=
 =?utf-8?B?UlpIUytvT3BlbU5meWFFZkRGbjFPdmttUHN4QjN4NXV3V2djcjJKMUV1MzIr?=
 =?utf-8?B?U1J0QkNhR0cwOVpUNlNhM3ZCQXZnREkyMXQ5QTR5eUE3Mkw5TDRBWlpCTGRz?=
 =?utf-8?B?Z2ZyT1dpM1pEN0xZbGNwY1p0TEI0cnJxckJDN1VOT200c1RUaGJ5ZXRpY01m?=
 =?utf-8?B?azdCSnQrbTl5dXBlSTBGTVdaNXdLL3h1MXFSYUc0TElKelVFbkM5KzI0RW0v?=
 =?utf-8?B?cm5ndVJ3MFF6UWdjZ3RQeXFrVHk4QTlXL1MxbnpDMVBuU2dlNnUvOCtyeGIy?=
 =?utf-8?B?SXRrd2pMd3hJTi83SDlUUWFOT0ZqS3lxTzgwMm1wNTB4RG5pOXV2MGNUbkJV?=
 =?utf-8?B?ejlvMTVzbXpHd1hLRklSMFROWlVIM1JRN2oyWm1Sd3J6WDZZaEpvMnhvc09E?=
 =?utf-8?B?WnJGZlpnRzRnY2Q1elFjL240NVFnejMzdUlNdThEUS8vbHp2QUxyanpSOExi?=
 =?utf-8?B?eWdpU0FBa29Va1oxOXNpeFJENXhqMjdMT2dBZnpUT3hnRU54eEl5ejFtenFQ?=
 =?utf-8?B?TXZSL2JNT01TMStlNzZpTFlEaml4TmpoR2VxR1NqMTNKN21oaWl0M0xYNmc2?=
 =?utf-8?B?SUd4a21INnc3ZFhKQmxmNmJIYkRSVDd1ZUJ2ZllZZUxCaXZYdkJlT0h3M0VW?=
 =?utf-8?Q?7RGPgox3jAXJP6xip3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9699.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cde924c-92b9-4540-3295-08df1decd9f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 05:45:21.5805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPmPYGtOQ60v596ba9zAxeo9LNe60PPMfOkT1VfJZBj/JIwIQUf8V8qrhkNpZJMQsDi4dRu4yeHJ1l61d3r6dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
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

QU1EIEdlbmVyYWwNCg0KSGkgTGlqbywNCg0KSG9zdCBkcml2ZXIgd2lsbCBwcm9ncmFtIHRoZSBW
RiBjb3BpZXMgZm9yIEZCX0xPQ0FUSU9OIGFuZCBTWVNURU1fQVBFUlRVUkUgcmVnaXN0ZXJzIHZp
YSBQU1AgaW50ZXJmYWNlIHNvIGFtZGdwdSBkb2Vzbid0IG5lZWQgdG8gaGFuZGxlIGl0IHVuZGVy
IHNyaW92Lg0KDQpSZWdhcmRzICYgVGhhbmtzLA0KWXViaWFvDQoNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQpTZW50
OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjksIDIwMjYgMTozNSBQTQ0KVG86IFdhbmcsIFl1QmlhbyAo
RXRoYW4pIDxZdUJpYW8uV2FuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBa
aGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRD
SF0gZHJtL2FtZGdwdTogc2tpcCBQRi1vbmx5IHByb2dyYW1taW5nIG9uIHRoZSBWRg0KDQoNCg0K
T24gMjQtU2VwLTI2IDEyOjMxIFBNLCBZdUJpYW8gV2FuZyB3cm90ZToNCj4gR29sZGVuIHJlZ2lz
dGVyIGluaXQsIHRoZSBTRE1BIFJCIGNvbW1hbmQgc3dpdGNoIHNldHVwLCB0aGUgR0ZYSFVCDQo+
IEwyIHByb3RlY3Rpb24gZmF1bHQgY29udHJvbHMgYW5kIHRoZSBndWVzdC1zaWRlIEZCX0xPQ0FU
SU9ODQo+IHByb2dyYW1taW5nIGFsbCB0b3VjaCByZWdpc3RlcnMgYSBWRiBkb2VzIG5vdCBvd24s
IHNvIGxlYXZlIHRoZW0gdG8gdGhlIFBGLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZdUJpYW8gV2Fu
ZyA8WXVCaWFvLldhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3YxMl8xLmMgICAgfCAgMyArKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhodWJfdjEyXzEuYyB8IDI0ICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92N18xLmMgICAgfCAgMyArKy0NCj4gICAzIGZp
bGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEyXzEuYw0KPiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTJfMS5jDQo+IGluZGV4IGRiNTQxOTM5NTU1Yi4u
NGY2ZWFjMzBiMjM1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjEyXzEuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEyXzEu
Yw0KPiBAQCAtMjY2NSw3ICsyNjY1LDggQEAgc3RhdGljIGludCBnZnhfdjEyXzFfaHdfaW5pdChz
dHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykNCj4gICAgICAgaWYgKHIpDQo+ICAgICAg
ICAgICAgICAgcmV0dXJuIHI7DQo+DQo+IC0gICAgIGdmeF92MTJfMV9pbml0X2dvbGRlbl9yZWdp
c3RlcnMoYWRldik7DQo+ICsgICAgIGlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KPiArICAg
ICAgICAgICAgIGdmeF92MTJfMV9pbml0X2dvbGRlbl9yZWdpc3RlcnMoYWRldik7DQo+DQo+ICAg
ICAgIGdmeF92MTJfMV9jb25zdGFudHNfaW5pdChhZGV2KTsNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92MTJfMS5jDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YxMl8xLmMNCj4gaW5kZXggN2ZhNDUxYjM3M2ZjLi5iMTM5
NjdhMWM4ZmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeGh1
Yl92MTJfMS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92MTJf
MS5jDQo+IEBAIC00ODIsMjcgKzQ4Miw2IEBAIHN0YXRpYyB2b2lkIGdmeGh1Yl92MTJfMV94Y2Nf
cHJvZ3JhbV9pbnZhbGlkYXRpb24oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgc3Rh
dGljIGludCBnZnhodWJfdjEyXzFfeGNjX2dhcnRfZW5hYmxlKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90
IHhjY19tYXNrKQ0KPiAgIHsNCj4gLSAgICAgdWludDMyX3QgaTsNCj4gLQ0KPiAtICAgICBpZiAo
YW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7DQo+IC0gICAgICAgICAgICAgLyogR0NNQ19WTV9GQl9M
T0NBVElPTl9CQVNFL1RPUCBhcmUgVkYgY29weSByZWdpc3RlcnMNCj4gLSAgICAgICAgICAgICAg
KiBWQklPIHBvc3QgZG9lcyBub3QgcHJvZ3JhbSB0aGVtIGF0IGJvb3QgdXAgcGhhc2UNCj4gLSAg
ICAgICAgICAgICAgKiBOZWVkIGRyaXZlciB0byBwcm9ncmFtIHRoZW0gZnJvbSBndWVzdCBzaWRl
ICovDQo+IC0gICAgICAgICAgICAgZm9yX2VhY2hfaW5zdChpLCB4Y2NfbWFzaykgew0KPiAtICAg
ICAgICAgICAgICAgICAgICAgV1JFRzMyX1NPQzE1KEdDLCBHRVRfSU5TVChHQywgaSksDQo+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnR0NNQ19WTV9GQl9MT0NBVElPTl9C
QVNFX0xPMzIsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbG93ZXJfMzJf
Yml0cyhhZGV2LT5nbWMudnJhbV9zdGFydCA+PiAyNCkpOw0KPiAtICAgICAgICAgICAgICAgICAg
ICAgV1JFRzMyX1NPQzE1KEdDLCBHRVRfSU5TVChHQywgaSksDQo+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmVnR0NNQ19WTV9GQl9MT0NBVElPTl9CQVNFX0hJMzIsDQo+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdXBwZXJfMzJfYml0cyhhZGV2LT5nbWMu
dnJhbV9zdGFydCA+PiAyNCkpOw0KPiAtICAgICAgICAgICAgICAgICAgICAgV1JFRzMyX1NPQzE1
KEdDLCBHRVRfSU5TVChHQywgaSksDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmVnR0NNQ19WTV9GQl9MT0NBVElPTl9UT1BfTE8zMiwNCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBsb3dlcl8zMl9iaXRzKGFkZXYtPmdtYy52cmFtX2VuZCA+PiAyNCkp
Ow0KPiAtICAgICAgICAgICAgICAgICAgICAgV1JFRzMyX1NPQzE1KEdDLCBHRVRfSU5TVChHQywg
aSksDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnR0NNQ19WTV9GQl9M
T0NBVElPTl9UT1BfSEkzMiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
cHBlcl8zMl9iaXRzKGFkZXYtPmdtYy52cmFtX2VuZCA+PiAyNCkpOw0KDQpUaGVzZSBoYXZlIFZG
IGNvcGllcywgYW5kIGxpa2VseSBuZWVkcyBwcm9ncmFtbWluZyBhcyBpbiBnZnhodWJfdjEyXzFf
eGNjX2luaXRfc3lzdGVtX2FwZXJ0dXJlX3JlZ3MuIENvdWxkIHlvdSBjaGVjaz8NCg0KVGhhbmtz
LA0KTGlqbw0KDQo+IC0gICAgICAgICAgICAgfQ0KPiAtICAgICB9DQo+ICAgICAgIC8qIEdBUlQg
RW5hYmxlLiAqLw0KPiAgICAgICBnZnhodWJfdjEyXzFfeGNjX2luaXRfZ2FydF9hcGVydHVyZV9y
ZWdzKGFkZXYsIHhjY19tYXNrKTsNCj4gICAgICAgZ2Z4aHViX3YxMl8xX3hjY19pbml0X3N5c3Rl
bV9hcGVydHVyZV9yZWdzKGFkZXYsIHhjY19tYXNrKTsgQEANCj4gLTU3Niw2ICs1NTUsOSBAQCBz
dGF0aWMgdm9pZCBnZnhodWJfdjEyXzFfeGNjX3NldF9mYXVsdF9lbmFibGVfZGVmYXVsdChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldg0KPiAgICAgICB1MzIgdG1wOw0KPiAgICAgICBpbnQgaTsN
Cj4NCj4gKyAgICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkNCj4gKyAgICAgICAgICAgICBy
ZXR1cm47DQo+ICsNCj4gICAgICAgZm9yX2VhY2hfaW5zdChpLCB4Y2NfbWFzaykgew0KPiAgICAg
ICAgICAgICAgIHRtcCA9IFJSRUczMl9TT0MxNShHQywgR0VUX0lOU1QoR0MsIGkpLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWdHQ1ZNX0wyX1BST1RFQ1RJT05fRkFVTFRf
Q05UTF9MTzMyKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nk
bWFfdjdfMS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92N18xLmMNCj4g
aW5kZXggMzIxYzY3ZTAxNDQzLi5kMWUwOWFjYzY4NGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjdfMS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NkbWFfdjdfMS5jDQo+IEBAIC0xMzk3LDcgKzEzOTcsOCBAQCBzdGF0aWMgaW50
IHNkbWFfdjdfMV9od19pbml0KHN0cnVjdA0KPiBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQ0K
Pg0KPiAgICAgICBpbnN0X21hc2sgPSBHRU5NQVNLKGFkZXYtPnNkbWEubnVtX2luc3RhbmNlcyAt
IDEsIDApOw0KPg0KPiAtICAgICBzZG1hX3Y3XzFfcmJfY21kX3N3aXRjaChhZGV2LCBpbnN0X21h
c2spOw0KPiArICAgICBpZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkNCj4gKyAgICAgICAgICAg
ICBzZG1hX3Y3XzFfcmJfY21kX3N3aXRjaChhZGV2LCBpbnN0X21hc2spOw0KPg0KPiAgICAgICBy
ID0gc2RtYV92N18xX2luc3Rfc3RhcnQoYWRldiwgaW5zdF9tYXNrKTsNCj4gICAgICAgaWYgKHIp
DQoNCg==
