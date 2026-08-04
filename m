Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC93FC5518F
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 14:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B7D10EA98;
	Tue,  4 Aug 2026 14:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5AupFAah";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013055.outbound.protection.outlook.com
 [40.93.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E6810EA92
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 14:21:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQu/vZCi1i7c+RXgXM4af2ulMZWkU79OCAJ1DIaIKoeaJ1rsa/B8zCf32Vj6nFzbODtxVbxueQUTUsc/UPHO5t4FGGB0quHrNnPjkfwxQoQPYYAzNYXZcRuqgS6qtFQCzfqESox90UBaBbsXTaaFQZQxstCkEvJM2SwYJFPcCRqqzDNfsVAaS9tDzowUYEaSfbtL3wjJAruhvcemcsrr/0DAC8gWMP978HMaHnjaIK2v/cvNzz1PXARrzHGeog0VO3y9e1KnDfVUMPSySJyWHb3KAcEKG3mKORSgJAk9WI7KYe4kvS+4QP07WNKNeFyAohPFjk97RhIaE233dOOhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHmZ8Q1OYUhOOmGIcyq9odxUbMU49MRXS0XdXjeV6vY=;
 b=wowbyM0H0VYR4jZex25goT5YnXORupZKC68vkltEw7RbSh71U723ytpra1PGZ1d5SAWd5XitjkLZys5c500og2gZwbibudgW+KDlmgJC28ruxMG2iLO4MlUOdOwDugRqdy680Ppy+JTIGVr4K2t2NV7iEcBv31ViTwxzLewPHoBDjqowwkY9ZdxqXbMAf1QE4s0Oc1pB05SUMy4uywKXrtVeplv0hbsIpVCNXbIt/PhHnZXZRmlKSNKKz/wEBfIFv22AtFiwhyIkbLowWrvycE8eCHTQzTu8VG2aTnFEhS79Rh50gS6wwnxqcMFY8vcYYXkVF1Yat1UDCA6Y/Dfr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHmZ8Q1OYUhOOmGIcyq9odxUbMU49MRXS0XdXjeV6vY=;
 b=5AupFAah170Jw9vsyLSPWQODHqWJKJBW2Jq0dFrajP5nsQtIMPA8h9cLWo7pEmrfyD7GvYYfxmdAp3OB67bYfkaSsZsIkzSko+jNabrkkAgK+nHLR6cM3+G0Id6o6xrZnjIK42X3roCrbqRAXH58lslYltgLqywXc4t4f+Lu9oo=
Received: from SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16)
 by LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 14:21:14 +0000
Received: from SN7PR12MB7856.namprd12.prod.outlook.com
 ([fe80::a3e7:285e:e0d8:24c1]) by SN7PR12MB7856.namprd12.prod.outlook.com
 ([fe80::a3e7:285e:e0d8:24c1%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 14:21:14 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gmc12.1: fix MMHUB0 check in pasid tlb flush
Thread-Topic: [PATCH] drm/amdgpu/gmc12.1: fix MMHUB0 check in pasid tlb flush
Thread-Index: AQHdHqdUeIME3hBr3Ui7scP5R4+idraHreoAgAZLIYCAAAJdAA==
Date: Tue, 4 Aug 2026 14:21:14 +0000
Message-ID: <SN7PR12MB7856F8ABA229D71492DCC521F4D42@SN7PR12MB7856.namprd12.prod.outlook.com>
References: <20260728153930.1531949-1-alexander.deucher@amd.com>
 <CADnq5_N3oqFeYwaV6nO_wxU+7K=4ymM=yLHZCy1e03FxMQy2Jw@mail.gmail.com>
 <CADnq5_M3YV1OhEtYUY9Ym5w7FqnVYvsV1WAFBNVSJgC3gwmgxQ@mail.gmail.com>
In-Reply-To: <CADnq5_M3YV1OhEtYUY9Ym5w7FqnVYvsV1WAFBNVSJgC3gwmgxQ@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-04T14:20:10.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7856:EE_|LV3PR12MB9235:EE_
x-ms-office365-filtering-correlation-id: 99417c9d-e712-4970-e373-08def233a423
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: UmVgGUKcJ+Qr9IdoNXoX/O8geROay3HjWwR3FAJrASLTLQ6KxD9m2GMhlT2as5nvaQaqBwp/0lwLv+oR3Q1dtDD/ABTYvwXSvHx3m1TPOKcpTFU5wE7uTo4shAchh5Otni9Kzo72FsvHd2MtAKNRlfmv5T+6trhuPxnizGaiRzDjgr5W+iPVUYP0oCZalJD4mfoxmkeWRHL8Jjxe98U9S5pK9+l+RHctTO13O+wgWln5W/K+O1N6BfV6PQBC8t7FSFxoyOugjn5CSwEbteLGRgD4xHRcTrIArqMsZoAYiNrcJZkyxzK7nSWmB4KYTmmp55W/ABK1KBY52Xd0D9Y2PN8+7EnA9VDBgkK3L90+WVM87p5/YCNguGFS8Rx1fKhOsIXA6JbgbSWJLxfhSKlGwefHNHTeEQu4mX61D7zE3MeQjeF5sDBW30U6H6O2gkvFkQXPkQnVhfX193bIzbmVlhGdPO7nbXJXK4ThxeB6OKmrOTxfL6fkPm/0pZItQjd766hrBQQzLiBo/+5Coz0QMGg8OkoefdGSHZgdd730cuWALvjdYZDfGVZsmhFuQndqWjsgbQx3uGwUQfBbdZ2a2YfOwwCY39eg1MHp5V+j2sDMZxT0dJXwEGW3V4qYAof8eRJks6H1qEsgiqfcCbtulPEAo5yFLktmCSI99tVjD9xAQtONNa6x85eyt9WegzZD37XgXl0U09rlop/JcNDYhkyBB6WEcZHPr63EnevLQ7A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7856.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE04MU0yVGZCRTJiSmNmUDU5dUt0eEJ1WjdSUzJBU3FKR2JBeG5FQzNoVUZq?=
 =?utf-8?B?WmUwYlNTYWtHbzFwMnVLa3haSFVOdk4rZTZuME9SUmk1QUNSQ2tCRGViazhV?=
 =?utf-8?B?dmNnUGk0dTRwUTE1cWh5VUFiU0xOQlNtQ0JoZW9hYnBiYlMzSHFTRTNYUTFB?=
 =?utf-8?B?WE1qUFdwY2tQYUp3WVFZSjBXVEFjbXNwdE5nTUdSMGdybXA3dGNqTERaaHNT?=
 =?utf-8?B?YzBTNExndmFDNWEvV0t2UDdZaEVjdFhmMDhNbThOSGIzV1lhYUJ5cGJKN0Zy?=
 =?utf-8?B?SlFWQ2YvMWFUbUFzYVRVOHNxZjhWTHJWNHVKN1AxRWJsZmliUFBKQmxyK216?=
 =?utf-8?B?NzV3bUVYVTBESlN5VEpPdnNjRlBIMGovL0xOc1dXS0tReVFvOHY4Qld1SktT?=
 =?utf-8?B?emhUTW02cE9rZkNYSkxpeWRHZGhsaGtneG5GTUR3TXVkVUxOWE5TWHVQWFgz?=
 =?utf-8?B?ajFhU0JMZ2pxaHMwNzdmdUdRVlppMHczeG9uVUp5a0xHTUN0eERHNFczOTk5?=
 =?utf-8?B?NkJXeUVNWjNTSTl2WFViZTEyd0Y4WHAwOW1EemhCK3dud2tuQk5MdFZwSUZU?=
 =?utf-8?B?Z1c5UHJHa2xoaU1lOUFjajVYdENYaDU4YUdQdkNIbThwRWhVTEQzdnYvSnl5?=
 =?utf-8?B?R2VvZ0Vjdkkzcm1RSmpmMnhQRjFuZyswZGdydkYzMDl3eG13bHUzdFBCTHND?=
 =?utf-8?B?NS9XSkxEd0Q3eWc4aEllR3dJaTdjbGtnSUpNQlVNbUxuQzJ2TmtzSTNZSEcx?=
 =?utf-8?B?M1NzUFQ2cDcyaWNDbmRxQUdCdWI5dXRQMkwyU0NIYmZjajYyOGhhaTNpTzJk?=
 =?utf-8?B?TTlFWUZGbWc3cng2c0xrWlhTaUxObUt2Zk1RdGVyVUlXd2FqQUZkN2h5U0NO?=
 =?utf-8?B?TmJhbzZXSmQrWGVFNkFlekYvYnNzb1lIR09CN21WS0NNSityY24ycndWUkxp?=
 =?utf-8?B?N2pwS2FwNkcyKzVKc1dzNHI3eHVsV3VxZ1VmckljeWZselREKzFUdFhHazhh?=
 =?utf-8?B?VzZFRnV3Mkg0L3Y2RVJzQkN3RXI0bWd0TjMwbHlMemNKMTlYMGdOakwrUU0v?=
 =?utf-8?B?V1g0UTQzSmZsdGNwTnNjZzlwbDJmOEx2Sk04KzdzUU5qQXZZKzViYkVyWnBu?=
 =?utf-8?B?UUZ4VVF4djd0ajh1TXBvYWR1SlBXVjFHdFVRSFA5c2h1RXFvYU5Zd0ZyaXZu?=
 =?utf-8?B?OHNQdXdWcGkwMFpFTEYzbURFUDc1NFFpMUUzKzJ1QTJYZ3RaRWY1MVBuZTlw?=
 =?utf-8?B?Vnk4a3Y4K2JCT0NiSWphNlIzemhTTG9VcnY4S0RNbGROZHc2RHBsSmx1UCtl?=
 =?utf-8?B?OUVGQnRjTVZUYU8yTUF5ZFI3YUh1bXNUVUhzRlRFZ202MTFER0hlWHFjdmVm?=
 =?utf-8?B?Q0JtQmZMRDNqZFcwR2hnVndJN2JZL3FHWVBJMlQ5OFRObEt2WnphMWNQc3hE?=
 =?utf-8?B?NG1JRHUvbDFKNHl0LzQ5TUpFMC92ZmFTUnBzUnJneDIrNm1USGpxMEMvYjBo?=
 =?utf-8?B?UW5NaEc3RkM0VHNScTBPZUNxRmtiVlZpWEZBYTJEOEMvRHRWUmllVk4zT201?=
 =?utf-8?B?Q1lsMDZZT3luQ1ZFaDFzcjFEamU2VzVWcG5WSnlzbDJqcC94dnAvL0lJckdB?=
 =?utf-8?B?MFdEeGgwOEdvN3VQeWxYdnFNTXRRbitKanNIMnBnd2xLbUY2ZzBrWGlYQTFj?=
 =?utf-8?B?OHBCdVU1Um8yOFI4dDkxNTVRYThaSWJmVUZsRnNzT044Uy9NaW5pNFVoU3VY?=
 =?utf-8?B?TTgyWDNmYjA4aDBwUCtYaDB0L3dtYnNaWnBMdHlSMmlaOFcvbGF2ZzZRMXF5?=
 =?utf-8?B?cFdiOFRJZFI2VWxuV2JYZmlVS05DS2pCbHYrNDREbkdGSVBnK21KS0NjM0JQ?=
 =?utf-8?B?WEYzMHFiT3A1Q3hQbEM1aGMyTUpSSXdTYXo3OTMwVTFORXYwdWR0ZmRkaERz?=
 =?utf-8?B?Y0tBc2traERjeEhyd3U3WTFEb0NULzQyM0piK2VsYlRpSVdmMVc3QlA4Y0FE?=
 =?utf-8?B?akRQM0N4Y0gyU0wxSnZWdDNMNmlqd0dSQ3BxdXZqUFl1V3hiVy9OTVB6ajVW?=
 =?utf-8?B?NlV5ME85MEoxdlZpcElkNFJyYUpFUDVKY3IzSkg4VHRvOGxhMEVxeklaNEI2?=
 =?utf-8?B?NFAvZEltUWNvZEdKaFlKMThpa3BYL2NNNlpmc1NXUUFPQ3dGVlVkQnNwVzJZ?=
 =?utf-8?B?Nm1WNElGRUYyQWp5Y2ZtUFM3SnNjTzZpcGVzOCtiUHAra1pKYzVVTmQ0S0FH?=
 =?utf-8?B?bm45bTJqNWYvK0MwaDVyVTJqNnA4V3hhbTZXSGxtVGdaL3BkNmlsTEJnODBy?=
 =?utf-8?Q?m7V6KwdhHJNon6VXAj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7856.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99417c9d-e712-4970-e373-08def233a423
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 14:21:14.3644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lgWA9wsZXBaSlpQvjDB8sndbxi9tGMggFajN7iW0zRjD1pb61uAfNnLUMk+hFiekYVjWTDyaHTFyxIq2DFGpZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235
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

QU1EIEdlbmVyYWwNCg0KVGhhbmtzIHRvIGNhdGNoIHRoaXMgLg0KDQpSQiA6IFNoYW95dW4ubGl1
IDxTaGFveXVuLmxpdUBhbWQuY29tPg0KDQpSZWdhcmRzDQpTaGFveXVuLmxpdQ0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFp
bC5jb20+DQpTZW50OiBUdWVzZGF5LCBBdWd1c3QgNCwgMjAyNiAxMDoxMiBBTQ0KVG86IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgTGl1LCBTaGFveXVuIDxTaGFveXVuLkxpdUBhbWQuY29tPg0K
U3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdS9nbWMxMi4xOiBmaXggTU1IVUIwIGNoZWNr
IGluIHBhc2lkIHRsYiBmbHVzaA0KDQpHZW50bGUgcGluZz8NCg0KT24gRnJpLCBKdWwgMzEsIDIw
MjYgYXQgMTA6MDXigK9BTSBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3Jv
dGU6DQo+DQo+IFBpbmc/DQo+DQo+IE9uIFR1ZSwgSnVsIDI4LCAyMDI2IGF0IDExOjQ44oCvQU0g
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+
IENoZWNrIGZvciBtbWh1YjAgcmF0aGVyIHRoYW4gbW1odWIxLiAgTG9va3MgbGlrZSBhIGNvcHkg
cGFzdGUgdHlwby4NCj4gPg0KPiA+IEZpeGVzOiBkMGM5ODlhMGFhZDMgKCJkcm0vYW1kL2FtZGdw
dSA6IFVzZSB0aGUgTUVTIElOVl9UTEJTIEFQSSBmb3INCj4gPiB0bGIgaW52YWxpZGF0aW9uIG9u
IGdmeDEyXzEiKQ0KPiA+IENjOiBTaGFveXVuIExpdSA8c2hhb3l1bi5saXVAYW1kLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTJfMS5jIHwg
MiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEy
XzEuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMl8xLmMNCj4gPiBp
bmRleCA4NTVjZDI5Y2JmZmFhLi41NGE1ZTY0ZjUzYjNiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTJfMS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3YxMl8xLmMNCj4gPiBAQCAtMzk2LDcgKzM5Niw3IEBAIHN0YXRp
YyB2b2lkIGdtY192MTJfMV9mbHVzaF9ncHVfdGxiX3Bhc2lkKHN0cnVjdA0KPiA+IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsDQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgaWYgKGFsbF9odWIpIHsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBpbnZhbGlkYXRlIG1tX2h1YiAqLw0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgIGlmICh0ZXN0X2JpdChBTURHUFVfTU1IVUIxKDApLCBhZGV2
LT52bWh1YnNfbWFzaykpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAodGVzdF9i
aXQoQU1ER1BVX01NSFVCMCgwKSwNCj4gPiArIGFkZXYtPnZtaHVic19tYXNrKSkgew0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5wdXQuaHViX2lkID0gQU1ER1BVX01NSFVC
MCgwKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPm1lcy5mdW5j
cy0+aW52YWxpZGF0ZV90bGJzX3Bhc2lkKCZhZGV2LT5tZXMsICZpbnB1dCk7DQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgfQ0KPiA+IC0tDQo+ID4gMi41NS4wDQo+ID4NCg==
