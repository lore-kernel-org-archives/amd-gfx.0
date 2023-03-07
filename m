Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BC4C678D5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 08:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B05FA10E384;
	Tue,  7 Mar 2023 08:23:20 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8999510E384
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 08:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ap1WYyWKL+01zxnJEGvNWbyM4Gbz7m9QADmr9JTwtM1njM9O+awHcl0gDYRSfkoWVyS6l3txNo7wWn7nFVNEG94x6zSln8/2sAXIGgn5zfsKm8KXcrKBQqGuJbnzqFySaXOU+HqF+RbGsM8DaOFhr1p6knjmLkBEFSQPUOFeF0+NoLEkE0z1JTswH2x5EfFdxArmrQxjulqJhXRCibcN1WFy6kx0p22D+QSoB2f3nFqoIAbzhWFZN335TOaJImsm4/487YKn1v16OydwOvJyP8lOmnjNPYHqNsbFiLUXOFE/UinD97e/Nape/oLNBmym/Tk99gazwtl9jWxy/LVSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3qMgC6F3Ur5BB9IRg50l7y6wvgFfSkqAgMdhuOy2nE=;
 b=Bdp2NBwi8dCGJKD9UJyYl6b/UD10xd6hrsr5q4xPHKh/FFP4pjbSQONPZJ/lE91HZwdje2BQOjxM4ikQ0RxgK69530hclNmKL5rkz1HmbM1s27VAV412G+dAN3jbUPieJSsHmWbqQtr6r0P5Z90t1whp5qNAeO/DXwrkE6RjuLUUFLM8b2LHHqf+CasAlV8kDRTGH+kITq+SE7e4M0uJ2JAgRfTaBRDy6GTPqJEKMkmGha8/GzH1GooEx9IRkNomp8ztciOJIef7GodRGYumwB8pyBKx6vJEAvlzTmqeMN52K56KdeJNRitiYkcToy02DlA9KKQofpKxYU11p/5UCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3qMgC6F3Ur5BB9IRg50l7y6wvgFfSkqAgMdhuOy2nE=;
 b=rtvswNCqQMDOoOZq2miUk/wuIdWmVtXoskFuLZMXxXzKUfE54basyVk18CPYBgPe3hAISFTRrzRSbvJ67JeR6Quj64dBucnWFqwXP2wzQROciOqXOg8IJ9Gqv6S4ts1VWxlmO48l4Picq9jJmVk6k0nDiZ3z9VjjTIYJCp3qnk4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.29; Tue, 7 Mar 2023 08:23:17 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%5]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 08:23:17 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: =?utf-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <mumei6102@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/pm: Fix sienna cichlid incorrect OD volage
 after resume
Thread-Topic: [PATCH v2] drm/amd/pm: Fix sienna cichlid incorrect OD volage
 after resume
Thread-Index: AQHZTvNsZSSiHO8rAEqp9PpQqj9faa7u/doQ
Date: Tue, 7 Mar 2023 08:23:17 +0000
Message-ID: <DM6PR12MB2619D4679EE188A9F44F0FD9E4B79@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230304142035.37615-1-mumei6102@gmail.com>
 <20230304234431.29507-1-mumei6102@gmail.com>
In-Reply-To: <20230304234431.29507-1-mumei6102@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-07T08:23:13Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=54589467-fd6a-4f5a-80bd-71ee69796111;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DM6PR12MB4500:EE_
x-ms-office365-filtering-correlation-id: 8a977530-6ad8-41d0-40be-08db1ee53404
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UgTOUpu63wCJz4jijLkTSFa0L6bnso+O4Qw91Pyb+B5N1O+DO5s5ksdXj7oLmJIFMhvCAXAvXJC086SS0ELtObx8WnLJ2JL8NOnmoZAvSZfiQuQXnxGDX26qDt/uSkbPt2xxohR1dYKhbdHrXMP/Uo0E8lm+3Wi8XpElunaT9c1Jgp5c339s7lrGk9ce5Bj5jKdZvwDSs5l/gzOllPcgVdUFX7oiuaxKDbLsP7P74TtJ1Q446e8q48w+AtX1g3p6dLOGIfJKeJNBY32v+kLY6YcWdLQ8fXata/OGCosMgQXSQgxx61oVfRVHqGNHT53sc80ezUxZlGWDDscatUJeZic2rBRK9vADEv53jn6BFwCqGNToXZOBm8GfF6qG7h8idEwosMx/2rU51JaHdg6avdnxPxvWtoyHKTGLgMToJhWt/VDxDQG1C78VRYmG9kwOKIfANyb+kRfrPxOEle5yiCvAaG7aVeh6yBudG9xcakjeHT4JCXkKZZiokZJD/dss/nojZk9n4YHTI5iyf26O2nCkIaPshapXB/zJtemCH7XmTFtPc3A/iq/+ARiLaO0wlrzIUM7GIsifT/4cP91mrTSAQR8nH6r8BDU5fBID6f+bGf4HfQ/tv8DR6uR3/c+Yv51ax2PkxpNamd9WJMOA1s9f/naHWN4dsKfBHO4Xc6taf/KOh/cxwmYl0S2Wc9gZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199018)(38100700002)(122000001)(86362001)(33656002)(38070700005)(5660300002)(2906002)(76116006)(66556008)(66476007)(66446008)(64756008)(8936002)(8676002)(66946007)(41300700001)(52536014)(186003)(53546011)(26005)(9686003)(83380400001)(66574015)(110136005)(478600001)(55016003)(316002)(6506007)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDNwMjJnd3VBODBkbWpRby9SWjAyenk2UWV4UWZIT3dkeHdXYUI5RXBNaEY1?=
 =?utf-8?B?MGtvcndZODRMYm42cm8rL2hMNVNXVnM2N3J1VnpwdlVuTk1UZElPbEVRKzY1?=
 =?utf-8?B?M0d1bm1odU4vQ0RjYVVWVm83czFqZUJtSmY1RTcrdGV2S2xpdlRTTXJVdkRs?=
 =?utf-8?B?eUJscSthVFQyS3RNelhpcFoxVXE5OFRCa2V0OHJ6RlZxd2RidklqajYxUzRJ?=
 =?utf-8?B?Ty8vWThBUlNKbEp3RXpyM2t1TE9wRGVNQUg0eUJDQ0RMWnJyZkpacys5am9S?=
 =?utf-8?B?bGJtcDB1aHZxL0pNWG9SRGFNMkx4NHlEeW9GNTcrdFJqSGRPdWloYVRWeDJW?=
 =?utf-8?B?VkJSV21teFc2dHk5NUF1U1pXdkt2WGpFSE9STmREWWtWdmkvVW5rUzNIb1JX?=
 =?utf-8?B?VW1uaFJ2ZEdrNDZMdU4rSXVHbUE5SFVXVWx4d1AvTmtlamZ3Z0VjS0dGR3dj?=
 =?utf-8?B?N2d0aVl1UTZaYVhnSU93bjM1ZmsrQ0trbXF1VTNCaHltZFdKQXRuZVc4Z0Fl?=
 =?utf-8?B?eXVuQ3dCb1VyUXhKZmVzd1pESHhlMHBCMU44S09ONUhGbUlsL01PRU5OWWdY?=
 =?utf-8?B?VUpZcy93dUJnN2hIWS9uZy9jcWI2YkNCVTR4QUlONDFzUmNJQmFCWmdzcjdJ?=
 =?utf-8?B?UHZneWF5dUt6QTlIdUJwUDg2a0FCckduQVRzWEFTRzFWRUtkTTVWTGUyVVdn?=
 =?utf-8?B?OVBzY3c0cU8vU0tjNVB6ek1adGd1SkJKR09uL1dJdHJzZDBweGtJSHRmL2M1?=
 =?utf-8?B?L204YmFKK1NySmlMa1l4T3V6aEVQS0pVQ0x6Z0pEN2VOOU5KL0JqdU1ObFJC?=
 =?utf-8?B?MzVRZ1FOZkdJa215aXFoKzA2WlNuSy9NeEM0RVIwbVA1T0tLUTI2UE9EbmdO?=
 =?utf-8?B?MUZ4K3RlcUdOQkdlRjlKcURwRnY2VnFvekJ6LzVjdjMvLytXQlljUklFKzR1?=
 =?utf-8?B?bVd2MHducEVxMGhSMHByOGJHMkllZWNiaHpoeHJ4ZTZ2aFk3SmFYRmVncjMv?=
 =?utf-8?B?bnd4R1JBdkUrTnJyQWJSUXVEWVBFL3E1dmI1NXRoMWM5ZW1PekJhdCs4UnpI?=
 =?utf-8?B?TWRmWVhXT2ZYOTNiaTUwazcxRE5KZkp2dVB5NHM3eXZYSS81L044dE1DYjJQ?=
 =?utf-8?B?b1JzbXVVNzVxRTVPVmNWN0phZlViQVBoZjhUYmtCa05TZmFoQnM1SWtSNVlt?=
 =?utf-8?B?ZHZrb1NJaU5IN0lxRnpqSVI2UlJPN2F5clJ6NVN6cFBBa3pOMWRMWW8ycWtC?=
 =?utf-8?B?QWFiQmw4WFBueHMwYndoT25kTVp2MEJEVXl2eDU3anErRHJBdVY2aWtEQ29m?=
 =?utf-8?B?Mm8rc29HSmJJamJCenVsSElKYURDOUp0Y0xyWXdFSUtla2Q3TkRMZmx4Lzd6?=
 =?utf-8?B?VnRYOTZQKzNjTjAwK1FsdmllVHJBVmdSWFB1V1VwaWNPTkNjT2kybWl2Rith?=
 =?utf-8?B?ZXUrdWpYanM1SFUwWURHVjdTN1pZbmZ6T1RZazJUMHVrNllMTjEzUzNBU2ZL?=
 =?utf-8?B?dDRCbjVZaTA4NnBOVHF5Q2doTTNONnBLU1Ruc1N4TW5VaXNDellOdXM5TXFZ?=
 =?utf-8?B?Z2o2clVkMnBUdDBqd2tnTFAyNlp1cEVleGt1WlhuUlF2M09UMk9obExLNkhx?=
 =?utf-8?B?VjdJcWlVN1BkK1hqbVk1ZHNLN3FNU09wYmpuMmRSR2xGMmNrYTZvNkY3UWhD?=
 =?utf-8?B?ZndkTDZZSjAvVks2Qys1bVJyY2l2QXhJS3JXZGJVY3ZBeHVFdnBSMlp4dGll?=
 =?utf-8?B?NDJtd1o2R1BlU2s0MVZsUXBrcGhwcGl4YkdTOGF6ei9wYWJ0MkhSM3BkVzRi?=
 =?utf-8?B?VlVvY3MyUmFQKzB4S1B6Zzl5ZlFoNmN2cWpJVjEya1lOekxhTUxtTGdCSndx?=
 =?utf-8?B?Njh1UGlCK0FpbkpEd0ROUVh3V2pIenpTUXR5RW0ra2VKcnJrY1NObW5zZFRY?=
 =?utf-8?B?U0ZDUzUvSXROYWpTRmV3cGNFcWV1emZ0NXFsMDNFVnRQSEZoVmVadTByU1VX?=
 =?utf-8?B?VUc0WUZZcVc3b0VsYmFTYkx5NUJMSzFQeXJaZHNodGpPK0pFTTZlZkRNMGNP?=
 =?utf-8?B?b1dHWDNHVTcvSERmb1F4NFBDR0s0SkVBbWlwK09vUWI0SC9HRkF4LzUzRXlW?=
 =?utf-8?Q?G+BA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a977530-6ad8-41d0-40be-08db1ee53404
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 08:23:17.1938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rq1SnSmEmcsAMFk4ugs0X6wMeeY+LhxymiG/OUDD8Rkox1shIeAiD6XV5sBp+3CX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkNhbiB5b3Ugc2hhcmUgbW9yZSBi
YWNrZ3JvdW5kIGFib3V0IHRoaXM/IEkgY2Fubm90IHNlZSBob3cgdGhpcyBjYW4gYWRkcmVzcyBp
bmNvcnJlY3QgT0Qgdm9sdGFnZSBpc3N1ZS4NCg0KQlINCkV2YW4NCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+IEJsYXplaiBTemN6eWdpZWwNCj4gU2VudDogU3Vu
ZGF5LCBNYXJjaCA1LCAyMDIzIDc6NDUgQU0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IENjOiBCxYJhxbxlaiBTemN6eWdpZcWCIDxtdW1laTYxMDJAZ21haWwuY29tPg0K
PiBTdWJqZWN0OiBbUEFUQ0ggdjJdIGRybS9hbWQvcG06IEZpeCBzaWVubmEgY2ljaGxpZCBpbmNv
cnJlY3QgT0Qgdm9sYWdlIGFmdGVyDQo+IHJlc3VtZQ0KPiANCj4gQWx3YXlzIHNldHVwIG92ZXJk
cml2ZSB0YWJsZXMgYWZ0ZXIgcmVzdW1lLiBQcmVzZXJ2ZSBvbmx5IHNvbWUNCj4gdXNlci1kZWZp
bmVkIHNldHRpbmdzIGluIHVzZXJfb3ZlcmRyaXZlX3RhYmxlIGlmIHRoZXkncmUgc2V0Lg0KPiAN
Cj4gQ29weSByZXN0b3JlZCB1c2VyX292ZXJkcml2ZV90YWJsZSBpbnRvIG9kX3RhYmxlIHRvIGdl
dCBjb3JyZWN0DQo+IHZhbHVlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IELFgmHFvGVqIFN6Y3p5
Z2llxYIgPG11bWVpNjEwMkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgLi4uL2FtZC9wbS9zd3NtdS9z
bXUxMS9zaWVubmFfY2ljaGxpZF9wcHQuYyAgIHwgNDMgKysrKysrKysrKysrKystLS0tDQo+IC0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3NpZW5u
YV9jaWNobGlkX3BwdC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9z
aWVubmFfY2ljaGxpZF9wcHQuYw0KPiBpbmRleCA2OTdlOThhMGEyMGEuLjc1ZjE4NjgxZTk4NCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9zaWVubmFf
Y2ljaGxpZF9wcHQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEx
L3NpZW5uYV9jaWNobGlkX3BwdC5jDQo+IEBAIC0yMTQzLDE2ICsyMTQzLDkgQEAgc3RhdGljIGlu
dA0KPiBzaWVubmFfY2ljaGxpZF9zZXRfZGVmYXVsdF9vZF9zZXR0aW5ncyhzdHJ1Y3Qgc211X2Nv
bnRleHQgKnNtdSkNCj4gIAkJKE92ZXJEcml2ZVRhYmxlX3QgKilzbXUtPnNtdV90YWJsZS5ib290
X292ZXJkcml2ZV90YWJsZTsNCj4gIAlPdmVyRHJpdmVUYWJsZV90ICp1c2VyX29kX3RhYmxlID0N
Cj4gIAkJKE92ZXJEcml2ZVRhYmxlX3QgKilzbXUtPnNtdV90YWJsZS51c2VyX292ZXJkcml2ZV90
YWJsZTsNCj4gKwlPdmVyRHJpdmVUYWJsZV90IHVzZXJfb2RfdGFibGVfYmFrOw0KPiAgCWludCBy
ZXQgPSAwOw0KPiANCj4gLQkvKg0KPiAtCSAqIEZvciBTMy9TNC9SdW5wbSByZXN1bWUsIG5vIG5l
ZWQgdG8gc2V0dXAgdGhvc2Ugb3ZlcmRyaXZlDQo+IHRhYmxlcyBhZ2FpbiBhcw0KPiAtCSAqICAg
LSBlaXRoZXIgdGhleSBhbHJlYWR5IGhhdmUgdGhlIGRlZmF1bHQgT0Qgc2V0dGluZ3MgZ290IGR1
cmluZyBjb2xkDQo+IGJvb3R1cA0KPiAtCSAqICAgLSBvciB0aGV5IGhhdmUgc29tZSB1c2VyIGN1
c3RvbWl6ZWQgT0Qgc2V0dGluZ3Mgd2hpY2ggY2Fubm90IGJlDQo+IG92ZXJ3cml0dGVuDQo+IC0J
ICovDQo+IC0JaWYgKHNtdS0+YWRldi0+aW5fc3VzcGVuZCkNCj4gLQkJcmV0dXJuIDA7DQo+IC0N
Cj4gIAlyZXQgPSBzbXVfY21uX3VwZGF0ZV90YWJsZShzbXUsIFNNVV9UQUJMRV9PVkVSRFJJVkUs
DQo+ICAJCQkJICAgMCwgKHZvaWQgKilib290X29kX3RhYmxlLCBmYWxzZSk7DQo+ICAJaWYgKHJl
dCkgew0KPiBAQCAtMjE2Myw3ICsyMTU2LDIzIEBAIHN0YXRpYyBpbnQNCj4gc2llbm5hX2NpY2hs
aWRfc2V0X2RlZmF1bHRfb2Rfc2V0dGluZ3Moc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQo+ICAJ
c2llbm5hX2NpY2hsaWRfZHVtcF9vZF90YWJsZShzbXUsIGJvb3Rfb2RfdGFibGUpOw0KPiANCj4g
IAltZW1jcHkob2RfdGFibGUsIGJvb3Rfb2RfdGFibGUsIHNpemVvZihPdmVyRHJpdmVUYWJsZV90
KSk7DQo+IC0JbWVtY3B5KHVzZXJfb2RfdGFibGUsIGJvb3Rfb2RfdGFibGUsIHNpemVvZihPdmVy
RHJpdmVUYWJsZV90KSk7DQo+ICsNCj4gKwkvKg0KPiArCSAqIEZvciBTMy9TNC9SdW5wbSByZXN1
bWUsIHdlIG5lZWQgdG8gc2V0dXAgdGhvc2Ugb3ZlcmRyaXZlDQo+IHRhYmxlcyBhZ2FpbiwNCj4g
KwkgKiBidXQgd2UgaGF2ZSB0byBwcmVzZXJ2ZSB1c2VyIGRlZmluZWQgdmFsdWVzIGluICJ1c2Vy
X29kX3RhYmxlIi4NCj4gKwkgKi8NCj4gKwlpZiAoIXNtdS0+YWRldi0+aW5fc3VzcGVuZCkgew0K
PiArCQltZW1jcHkodXNlcl9vZF90YWJsZSwgYm9vdF9vZF90YWJsZSwNCj4gc2l6ZW9mKE92ZXJE
cml2ZVRhYmxlX3QpKTsNCj4gKwkJc211LT51c2VyX2RwbV9wcm9maWxlLnVzZXJfb2QgPSBmYWxz
ZTsNCj4gKwl9IGVsc2UgaWYgKHNtdS0+dXNlcl9kcG1fcHJvZmlsZS51c2VyX29kKSB7DQo+ICsJ
CW1lbWNweSgmdXNlcl9vZF90YWJsZV9iYWssIHVzZXJfb2RfdGFibGUsDQo+IHNpemVvZihPdmVy
RHJpdmVUYWJsZV90KSk7DQo+ICsJCW1lbWNweSh1c2VyX29kX3RhYmxlLCBib290X29kX3RhYmxl
LA0KPiBzaXplb2YoT3ZlckRyaXZlVGFibGVfdCkpOw0KPiArCQl1c2VyX29kX3RhYmxlLT5HZnhj
bGtGbWluID0NCj4gdXNlcl9vZF90YWJsZV9iYWsuR2Z4Y2xrRm1pbjsNCj4gKwkJdXNlcl9vZF90
YWJsZS0+R2Z4Y2xrRm1heCA9DQo+IHVzZXJfb2RfdGFibGVfYmFrLkdmeGNsa0ZtYXg7DQo+ICsJ
CXVzZXJfb2RfdGFibGUtPlVjbGtGbWluID0gdXNlcl9vZF90YWJsZV9iYWsuVWNsa0ZtaW47DQo+
ICsJCXVzZXJfb2RfdGFibGUtPlVjbGtGbWF4ID0gdXNlcl9vZF90YWJsZV9iYWsuVWNsa0ZtYXg7
DQo+ICsJCXVzZXJfb2RfdGFibGUtPlZkZEdmeE9mZnNldCA9DQo+IHVzZXJfb2RfdGFibGVfYmFr
LlZkZEdmeE9mZnNldDsNCj4gKwl9DQo+IA0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiBAQCAtMjM3
Myw2ICsyMzgyLDIwIEBAIHN0YXRpYyBpbnQNCj4gc2llbm5hX2NpY2hsaWRfb2RfZWRpdF9kcG1f
dGFibGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4g
DQo+ICtzdGF0aWMgaW50IHNpZW5uYV9jaWNobGlkX3Jlc3RvcmVfdXNlcl9vZF9zZXR0aW5ncyhz
dHJ1Y3Qgc211X2NvbnRleHQNCj4gKnNtdSkNCj4gK3sNCj4gKwlzdHJ1Y3Qgc211X3RhYmxlX2Nv
bnRleHQgKnRhYmxlX2NvbnRleHQgPSAmc211LT5zbXVfdGFibGU7DQo+ICsJT3ZlckRyaXZlVGFi
bGVfdCAqb2RfdGFibGUgPSB0YWJsZV9jb250ZXh0LT5vdmVyZHJpdmVfdGFibGU7DQo+ICsJT3Zl
ckRyaXZlVGFibGVfdCAqdXNlcl9vZF90YWJsZSA9IHRhYmxlX2NvbnRleHQtDQo+ID51c2VyX292
ZXJkcml2ZV90YWJsZTsNCj4gKwlpbnQgcmVzOw0KPiArDQo+ICsJcmVzID0gc211X3YxMV8wX3Jl
c3RvcmVfdXNlcl9vZF9zZXR0aW5ncyhzbXUpOw0KPiArCWlmIChyZXMgPT0gMCkNCj4gKwkJbWVt
Y3B5KG9kX3RhYmxlLCB1c2VyX29kX3RhYmxlLA0KPiBzaXplb2YoT3ZlckRyaXZlVGFibGVfdCkp
Ow0KPiArDQo+ICsJcmV0dXJuIHJlczsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBzaWVubmFf
Y2ljaGxpZF9ydW5fYnRjKHN0cnVjdCBzbXVfY29udGV4dCAqc211KQ0KPiAgew0KPiAgCWludCBy
ZXM7DQo+IEBAIC00NDAwLDcgKzQ0MjMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBwdGFibGVf
ZnVuY3MNCj4gc2llbm5hX2NpY2hsaWRfcHB0X2Z1bmNzID0gew0KPiAgCS5zZXRfc29mdF9mcmVx
X2xpbWl0ZWRfcmFuZ2UgPQ0KPiBzbXVfdjExXzBfc2V0X3NvZnRfZnJlcV9saW1pdGVkX3Jhbmdl
LA0KPiAgCS5zZXRfZGVmYXVsdF9vZF9zZXR0aW5ncyA9IHNpZW5uYV9jaWNobGlkX3NldF9kZWZh
dWx0X29kX3NldHRpbmdzLA0KPiAgCS5vZF9lZGl0X2RwbV90YWJsZSA9IHNpZW5uYV9jaWNobGlk
X29kX2VkaXRfZHBtX3RhYmxlLA0KPiAtCS5yZXN0b3JlX3VzZXJfb2Rfc2V0dGluZ3MgPSBzbXVf
djExXzBfcmVzdG9yZV91c2VyX29kX3NldHRpbmdzLA0KPiArCS5yZXN0b3JlX3VzZXJfb2Rfc2V0
dGluZ3MgPQ0KPiBzaWVubmFfY2ljaGxpZF9yZXN0b3JlX3VzZXJfb2Rfc2V0dGluZ3MsDQo+ICAJ
LnJ1bl9idGMgPSBzaWVubmFfY2ljaGxpZF9ydW5fYnRjLA0KPiAgCS5zZXRfcG93ZXJfc291cmNl
ID0gc211X3YxMV8wX3NldF9wb3dlcl9zb3VyY2UsDQo+ICAJLmdldF9wcF9mZWF0dXJlX21hc2sg
PSBzbXVfY21uX2dldF9wcF9mZWF0dXJlX21hc2ssDQo+IC0tDQo+IDIuMzkuMg0K
