Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C06C48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 05:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 124EE60FEB
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 05:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124EE60FEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B61846E038;
	Wed, 16 Jun 2021 05:44:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C181B6E038
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 05:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbH6wO++05825aEkM4urBBWd0M/KIPqbW6SnG9/KLqJWgQg3kqMD+h3KY7oUxQ1IxqDDYGlTnBXsgR7tuj2Ktoj21o/PruhWMT2eoVMNsH4ZofIQjoTtITB2L9QAzgLF3UUhro+1ViA1iqg8cJvaIAHLmMMUwhLQdsbPaeTi3TD0Hc6U2Toze6Woaj7NAp/mBuvo5XpEReDi2+7mJW5XTFdy0I5Lb9Wl/NSrw8Csj4sO4J06grcbVrKXciOPQgMeYHpCkaYZe9dB4NRHenIsflLLFlXvbJCpFNfVXbDYhCw3Nqlbv0HEeAI3JyEgtfW+xcBRfIYZM6MPVMxjAXfKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW2HPwNNMe0i58ZVqfJEVVOpploZn4rNj9/vwGlvSPs=;
 b=S/rVTKdC8d+7BwV+dyVOdfqc3i3KVMbXUcU3GfuJECcEwRrVt6Q+u8z9Q8K6zkrySQ4HKBTdyWUx+UffCWdITih5IG2OFEVukKnWuRWxAPiRgzKIfO7+2ZNp/AN5uH3bRcB8/TH9lW9gG8ks9Q9rOYHhNbZINvfk0jcG2L5AhKOzy7/gGksbV4kaVs8y05KoDHlKaDBbZuu4HynfS/hs2lJZbk0U2uLOWgRKVF//P7Ta+urKTYamjEc90ZTQnKFKnWyfjorq0ABHX7+5eCQClnTrs+MkhN4rAfasU+1thrAzKaeSdYukDLiHJYXm4jl8EbRUbEDxw3CNm5LI1yvd9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW2HPwNNMe0i58ZVqfJEVVOpploZn4rNj9/vwGlvSPs=;
 b=2imhR1010QczN1+SGihDjcD9CPaFZS5gXzzVJeCWgkI42ab0jkVvCuYP4NhCS19V+61tpN2f0qKpwJ5uY9NzVzmty1NJq1HnnqgG9L6jhQTCvnhX6KiDPLDN6NzKFKXAXFmzUNR8ZbwYfVGhZqJZR+POOFotv3wFNK+7r4FthfI=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM6PR12MB5552.namprd12.prod.outlook.com (2603:10b6:5:1bd::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16; Wed, 16 Jun 2021 05:44:50 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508%6]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 05:44:50 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Fix circular lock in nocpsch path
Thread-Topic: [PATCH] drm/amdkfd: Fix circular lock in nocpsch path
Thread-Index: AQHXYg8x1bmtZ/i+xUS0qLZG7FM1C6sVYqMAgACfLYCAAAxWAIAAEyWA
Date: Wed, 16 Jun 2021 05:44:50 +0000
Message-ID: <DDD71DB8-EF05-44B5-A3CE-144E1F73226C@amd.com>
References: <20210615175049.18382-1-Amber.Lin@amd.com>
 <a933d395-621b-52ab-da31-9e8de8525772@amd.com>
 <A1E8DF67-7630-4F63-BB42-F153E3405112@amd.com>
 <e22394ca-8cc5-9d8f-453e-68d95744090f@amd.com>
In-Reply-To: <e22394ca-8cc5-9d8f-453e-68d95744090f@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74d9b414-e065-48f3-b050-08d93089dbb6
x-ms-traffictypediagnostic: DM6PR12MB5552:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB5552B02DE8A8382BAE30B093870F9@DM6PR12MB5552.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6lwyMFEoTKKDdFvFIdzfhjd0LHSvFeEH5FO+tbskbFPpbiA7ip/tUioUemWCY6EiQ+nBTcRwPj7Xf45u3m8hQpAPBKr6DYs+ISYE/Mf7ZVPJUvC08027ny2nNQYrW5pAJG4eL2mwVxxMWDljPaElOeSaKvZP7lkCKRHOAuKf9mCBLbSUmR1M30xBQev9PaZOuyHtpQvVqCOCR11fgUVu5KJgPVUq7M241PZPM1QcQN9XIGOuethuOOFisAyEkbSl3puqSSE9CcVujQ7ZSuptNnXRtlqI++A88MJjfZmVO044QvDKMMg76Ta+3eXbhR1qC4Hdnf7/T5ueT5/v0meLShDc3c9yi1yt7eimwbxonKdE4ojgXM0ko1AlavG3HTRbnzQg2IgTiWh6WCvUXxqtgBQcdb1DQ5aUZHsVYiKO7V5E3WMGSxVMi9O/kYqF/4eTbWSFrUEM1IPlNOBPI2m3YRSEcyosJ1867eDHFkXkjViBXQR+KFysXyLWaAZ45cx0pi0FYNmUFagxwWJpIrvuirqMWooh0jG4tfGZcJKZ5uY6NwrWgd6eYpy4eKMBX5fi1VVhqvAWqozORbEEVrNa1uiCRsp8ZpJ87Y8YFHMYic2UB2uYPSd7bi4zllKX7gIDiAwvwfObw0BZIV7IjjS5TQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(36756003)(478600001)(54906003)(8936002)(6486002)(5660300002)(83380400001)(6862004)(8676002)(4326008)(2906002)(66476007)(91956017)(66446008)(66556008)(71200400001)(316002)(6636002)(76116006)(66946007)(64756008)(33656002)(6506007)(86362001)(37006003)(6512007)(38100700002)(26005)(122000001)(2616005)(186003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFJuWEtvYXMxc3NxMmsrTkpsaUFFYzVSWmk0ZVovLzNHUXV3enI5MVd2SXdi?=
 =?utf-8?B?OFFLamhpNnB1M3RrMFpNNy9uOXV6Ulc4ZHJQb0d0VUFSWkszS0FqS2NkVVNV?=
 =?utf-8?B?Q2k4c0tJcWlqMFA2YkV4d1JmQ0ptS1pEUStMRHBZZWg4d2dtdXpKd3dieSs2?=
 =?utf-8?B?TWx2MnlaMUpKYWxFRkYycGlXUU1qOTRCNVM3SUZac0FjTkpGdnhpMWJXem55?=
 =?utf-8?B?cEZZdzZHUXhDNU8yQVdjRXRla2hqeldiMzI1ZDgzQVhoQmNFS2QvMEw4RUxP?=
 =?utf-8?B?aGsvQURTTDJwcWxEVXFISmMvZHpuOVlkRldKNWJRR1ZPcXljUnVnd3Q0WGZq?=
 =?utf-8?B?dWx5dDZDU3VRVlNOL0lXalEzc3pWeDg1OWV4RGNmbnBEblhETUpXanVnMTg0?=
 =?utf-8?B?ZWhsRE1DbFpET25NSWN4RUthVUMxeE45eDlWTXFDMXl6S0w3VnBlclRnTUpJ?=
 =?utf-8?B?RVE0QjFvR1hRazcrYXp3TVA4YW9GNkRVSWZITlNaQy9CY1FURk1uR2RZSlNB?=
 =?utf-8?B?cmNDY0tNRllhVit6d3pBQXNMcEN4TUtROFNYVjJMNlROdDZ3M1ZLenA0OFlB?=
 =?utf-8?B?WUsxTlVjaHBUQkhnZG9EVFFkZUdiUFpQZDEweHovVXBHTUlKTFVWWE5oSTRT?=
 =?utf-8?B?a3ZFb1UzYkhYL0JOMmxzVFJ6dW40R1VRZE1oemJlZjI2MDNKNnBrc1BCZlBl?=
 =?utf-8?B?ZFl1SmczWWNMa3gzSTYvcUZ4Y0FSdmFPZGorT21mQTkvTmp3eXd4RXBha21Q?=
 =?utf-8?B?bTdJajJ6aW01eDhTYkJYNGtpbkkyWjgxRWYxRDJvRHJyOG9EU0hKMVZIandJ?=
 =?utf-8?B?dDQ4RjZsdHUwL3IreGlTeDVEM1BNb2E2eGJqbHFnR0oxZTdwMm1FVmpjaEU2?=
 =?utf-8?B?K0pSSWFXUlBzQlFmN2NDd3M2VnRJdTM0TUhRbWc4VE9rMHZPTjV1b2wvRGVO?=
 =?utf-8?B?eFkrTFhjQWtwUitwS25YaUtVaERqbGVORDNlZGtsQllTQ3RrTndWc25sMXFn?=
 =?utf-8?B?RlNhMUdma25IM2NQNGN0cW1iU0tnU3ZBUys2SkROSVZkaHRwQWkwR2VWekxN?=
 =?utf-8?B?SXZrMzF2R3cyVkdvK1Q1Z3BUTFRGRnU2QWVHRXpKeFdPcnhBZm5HaW9pQUti?=
 =?utf-8?B?VmR6WnlGQ2loVzJ0SUVBdlhwZUtRMHA4Y25HTUNuQXJncldVUHRaR1g5L0JP?=
 =?utf-8?B?VXdsTUkybnBkSFUvVnRBVk5hQ3ROUVJYR0NwbnVOMDMxOGNET3pnMWUzNDUw?=
 =?utf-8?B?aDJDY3NSM25LR21uNDFxcE1QTXAxTEQrZFNEYzFVTC95d0p0N0kvNmZNaHNa?=
 =?utf-8?B?SnFMYmZUcDRLYVNNczI5YlBObjY0STh3aUFNWHpkYWN4MkNQUElGVUV3T0d5?=
 =?utf-8?B?T0VuR2I3eHFrWmtqTHUxanBzSkJQUndnT2ZMOEtQa3ZabUFHbmthV2lJdzFy?=
 =?utf-8?B?QWY2cjZmTDdtN000SnBSdGJUbzY0TEoxeFc2N3ZhQUNBdHhONG1NOGt6VmdI?=
 =?utf-8?B?MXAvbEUzbCtyazd3QlR3N1J1RlZjcFBsd1hsbWpRcHNJdzdQL21tODBsZlNE?=
 =?utf-8?B?YVRVSWt3djh1VUl3Vkl4UjgwanpzRFNKQmVqQlhBbGxoRmtTUmM3Ums0NUwr?=
 =?utf-8?B?Ui9VQTlrT3ZTRkExUGhrQUVnMXZEREFyT1BPYWdHcTA1bXBiZis1MnljN3U1?=
 =?utf-8?B?YlpZUEpTaE9aTnV3MVY0SDgxWlMwaXA0dXVQSHZhN2Z5OTRxSlhOTDRRYmdI?=
 =?utf-8?Q?wsZwcQISac9nAJ4ve1RipEerVmPRXhdRewdONd+?=
Content-ID: <B479F517E548174396957D14359CBB1B@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d9b414-e065-48f3-b050-08d93089dbb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 05:44:50.3904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdW3f8bbjCKjwpfsWWIf2H6Xjl1duQyzqPiz1wb0Pex27RbYgiIWp5u9HQnjAzkh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5552
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gMjAyMeW5tDbmnIgxNuaXpSAxMjozNu+8jEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3Vl
aGxpbmdAYW1kLmNvbT4g5YaZ6YGT77yaDQo+IA0KPiBBbSAyMDIxLTA2LTE2IHVtIDEyOjAxIGEu
bS4gc2NocmllYiBQYW4sIFhpbmh1aToNCj4+PiAyMDIx5bm0NuaciDE25pelIDAyOjIy77yMS3Vl
aGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPiDlhpnpgZPvvJoNCj4+PiANCj4+
PiBbK1hpbmh1aV0NCj4+PiANCj4+PiANCj4+PiBBbSAyMDIxLTA2LTE1IHVtIDE6NTAgcC5tLiBz
Y2hyaWViIEFtYmVyIExpbjoNCj4+Pj4gQ2FsbGluZyBmcmVlX21xZCBpbnNpZGUgb2YgZGVzdHJv
eV9xdWV1ZV9ub2Nwc2NoX2xvY2tlZCBjYW4gY2F1c2UgYQ0KPj4+PiBjaXJjdWxhciBsb2NrLiBk
ZXN0cm95X3F1ZXVlX25vY3BzY2hfbG9ja2VkIGlzIGNhbGxlZCB1bmRlciBhIERRTSBsb2NrLA0K
Pj4+PiB3aGljaCBpcyB0YWtlbiBpbiBNTVUgbm90aWZpZXJzLCBwb3RlbnRpYWxseSBpbiBGUyBy
ZWNsYWltIGNvbnRleHQuDQo+Pj4+IFRha2luZyBhbm90aGVyIGxvY2ssIHdoaWNoIGlzIEJPIHJl
c2VydmF0aW9uIGxvY2sgZnJvbSBmcmVlX21xZCwgd2hpbGUNCj4+Pj4gY2F1c2luZyBhbiBGUyBy
ZWNsYWltIGluc2lkZSB0aGUgRFFNIGxvY2sgY3JlYXRlcyBhIHByb2JsZW1hdGljIGNpcmN1bGFy
DQo+Pj4+IGxvY2sgZGVwZW5kZW5jeS4gVGhlcmVmb3JlIG1vdmUgZnJlZV9tcWQgb3V0IG9mDQo+
Pj4+IGRlc3Ryb3lfcXVldWVfbm9jcHNjaF9sb2NrZWQgYW5kIGNhbGwgaXQgYWZ0ZXIgdW5sb2Nr
aW5nIERRTS4NCj4+Pj4gDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFtYmVyIExpbiA8QW1iZXIuTGlu
QGFtZC5jb20+DQo+Pj4+IFJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxp
bmdAYW1kLmNvbT4NCj4+PiBMZXQncyBzdWJtaXQgdGhpcyBwYXRjaCBhcyBpcy4gSSdtIG1ha2lu
ZyBzb21lIGNvbW1lbnRzIGlubGluZSBmb3INCj4+PiB0aGluZ3MgdGhhdCBYaW5odWkgY2FuIGFk
ZHJlc3MgaW4gaGlzIHJhY2UgY29uZGl0aW9uIHBhdGNoLg0KPj4+IA0KPj4+IA0KPj4+PiAtLS0N
Cj4+Pj4gLi4uL2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jICB8IDE4
ICsrKysrKysrKysrKystLS0tLQ0KPj4+PiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCj4+Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+Pj4+IGluZGV4IDcyYmVh
NTI3OGFkZC4uYzA2OWZhMjU5YjMwIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYw0KPj4+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYw0KPj4+PiBAQCAt
NDg2LDkgKzQ4Niw2IEBAIHN0YXRpYyBpbnQgZGVzdHJveV9xdWV1ZV9ub2Nwc2NoX2xvY2tlZChz
dHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSwNCj4+Pj4gCWlmIChyZXR2YWwgPT0gLUVU
SU1FKQ0KPj4+PiAJCXFwZC0+cmVzZXRfd2F2ZWZyb250cyA9IHRydWU7DQo+Pj4+IA0KPj4+PiAt
DQo+Pj4+IC0JbXFkX21nci0+ZnJlZV9tcWQobXFkX21nciwgcS0+bXFkLCBxLT5tcWRfbWVtX29i
aik7DQo+Pj4+IC0NCj4+Pj4gCWxpc3RfZGVsKCZxLT5saXN0KTsNCj4+Pj4gCWlmIChsaXN0X2Vt
cHR5KCZxcGQtPnF1ZXVlc19saXN0KSkgew0KPj4+PiAJCWlmIChxcGQtPnJlc2V0X3dhdmVmcm9u
dHMpIHsNCj4+Pj4gQEAgLTUyMyw2ICs1MjAsOCBAQCBzdGF0aWMgaW50IGRlc3Ryb3lfcXVldWVf
bm9jcHNjaChzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSwNCj4+Pj4gCWludCByZXR2
YWw7DQo+Pj4+IAl1aW50NjRfdCBzZG1hX3ZhbCA9IDA7DQo+Pj4+IAlzdHJ1Y3Qga2ZkX3Byb2Nl
c3NfZGV2aWNlICpwZGQgPSBxcGRfdG9fcGRkKHFwZCk7DQo+Pj4+ICsJc3RydWN0IG1xZF9tYW5h
Z2VyICptcWRfbWdyID0NCj4+Pj4gKwkJZHFtLT5tcWRfbWdyc1tnZXRfbXFkX3R5cGVfZnJvbV9x
dWV1ZV90eXBlKHEtPnByb3BlcnRpZXMudHlwZSldOw0KPj4+PiANCj4+Pj4gCS8qIEdldCB0aGUg
U0RNQSBxdWV1ZSBzdGF0cyAqLw0KPj4+PiAJaWYgKChxLT5wcm9wZXJ0aWVzLnR5cGUgPT0gS0ZE
X1FVRVVFX1RZUEVfU0RNQSkgfHwNCj4+Pj4gQEAgLTU0MCw2ICs1MzksOCBAQCBzdGF0aWMgaW50
IGRlc3Ryb3lfcXVldWVfbm9jcHNjaChzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSwN
Cj4+Pj4gCQlwZGQtPnNkbWFfcGFzdF9hY3Rpdml0eV9jb3VudGVyICs9IHNkbWFfdmFsOw0KPj4+
PiAJZHFtX3VubG9jayhkcW0pOw0KPj4+PiANCj4+Pj4gKwltcWRfbWdyLT5mcmVlX21xZChtcWRf
bWdyLCBxLT5tcWQsIHEtPm1xZF9tZW1fb2JqKTsNCj4+Pj4gKw0KPj4+PiAJcmV0dXJuIHJldHZh
bDsNCj4+Pj4gfQ0KPj4+PiANCj4+Pj4gQEAgLTE2MjksNyArMTYzMCw3IEBAIHN0YXRpYyBib29s
IHNldF9jYWNoZV9tZW1vcnlfcG9saWN5KHN0cnVjdCBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFt
LA0KPj4+PiBzdGF0aWMgaW50IHByb2Nlc3NfdGVybWluYXRpb25fbm9jcHNjaChzdHJ1Y3QgZGV2
aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSwNCj4+Pj4gCQlzdHJ1Y3QgcWNtX3Byb2Nlc3NfZGV2aWNl
ICpxcGQpDQo+Pj4+IHsNCj4+Pj4gLQlzdHJ1Y3QgcXVldWUgKnEsICpuZXh0Ow0KPj4+PiArCXN0
cnVjdCBxdWV1ZSAqcTsNCj4+Pj4gCXN0cnVjdCBkZXZpY2VfcHJvY2Vzc19ub2RlICpjdXIsICpu
ZXh0X2RwbjsNCj4+Pj4gCWludCByZXR2YWwgPSAwOw0KPj4+PiAJYm9vbCBmb3VuZCA9IGZhbHNl
Ow0KPj4+PiBAQCAtMTYzNywxMiArMTYzOCwxOSBAQCBzdGF0aWMgaW50IHByb2Nlc3NfdGVybWlu
YXRpb25fbm9jcHNjaChzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSwNCj4+Pj4gCWRx
bV9sb2NrKGRxbSk7DQo+Pj4+IA0KPj4+PiAJLyogQ2xlYXIgYWxsIHVzZXIgbW9kZSBxdWV1ZXMg
Ki8NCj4+Pj4gLQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocSwgbmV4dCwgJnFwZC0+cXVldWVz
X2xpc3QsIGxpc3QpIHsNCj4+Pj4gKwl3aGlsZSAoIWxpc3RfZW1wdHkoJnFwZC0+cXVldWVzX2xp
c3QpKSB7DQo+Pj4+ICsJCXN0cnVjdCBtcWRfbWFuYWdlciAqbXFkX21ncjsNCj4+Pj4gCQlpbnQg
cmV0Ow0KPj4+PiANCj4+Pj4gKwkJcSA9IGxpc3RfZmlyc3RfZW50cnkoJnFwZC0+cXVldWVzX2xp
c3QsIHN0cnVjdCBxdWV1ZSwgbGlzdCk7DQo+Pj4+ICsJCW1xZF9tZ3IgPSBkcW0tPm1xZF9tZ3Jz
W2dldF9tcWRfdHlwZV9mcm9tX3F1ZXVlX3R5cGUoDQo+Pj4+ICsJCQkJcS0+cHJvcGVydGllcy50
eXBlKV07DQo+Pj4+IAkJcmV0ID0gZGVzdHJveV9xdWV1ZV9ub2Nwc2NoX2xvY2tlZChkcW0sIHFw
ZCwgcSk7DQo+Pj4+IAkJaWYgKHJldCkNCj4+Pj4gCQkJcmV0dmFsID0gcmV0Ow0KPj4+PiArCQlk
cW1fdW5sb2NrKGRxbSk7DQo+Pj4+ICsJCW1xZF9tZ3ItPmZyZWVfbXFkKG1xZF9tZ3IsIHEtPm1x
ZCwgcS0+bXFkX21lbV9vYmopOw0KPj4+PiArCQlkcW1fbG9jayhkcW0pOw0KPj4+IFRoaXMgaXMg
dGhlIGNvcnJlY3Qgd2F5IHRvIGNsZWFuIHVwIHRoZSBsaXN0IHdoZW4gZHJvcHBpbmcgdGhlIGRx
bS1sb2NrDQo+Pj4gaW4gdGhlIG1pZGRsZS4gWGluaHVpLCB5b3UgY2FuIHVzZSB0aGUgc2FtZSBt
ZXRob2QgaW4NCj4+PiBwcm9jZXNzX3Rlcm1pbmF0aW9uX2Nwc2NoLg0KPj4+IA0KPj4geWVzLCB0
aGF0IGlzIHRoZSByaWdodCB3YXkgdG8gd2FsayB0aHJvdWdoIHRoZSBsaXN0LiB0aGFua3MuDQo+
PiANCj4+IA0KPj4+IEkgYmVsaWV2ZSB0aGUgc3dhcHBpbmcgb2YgdGhlIHEtPm1xZCB3aXRoIGEg
dGVtcG9yYXJ5IHZhcmlhYmxlIGlzIG5vdA0KPj4+IG5lZWRlZC4gV2hlbiBmcmVlX21xZCBpcyBj
YWxsZWQsIHRoZSBxdWV1ZSBpcyBubyBsb25nZXIgb24gdGhlDQo+Pj4gcXBkLT5xdWV1ZXNfbGlz
dCwgc28gZGVzdHJveV9xdWV1ZSBjYW5ub3QgcmFjZSB3aXRoIGl0LiBJZiB3ZSBlbnN1cmUNCj4+
PiB0aGF0IHF1ZXVlcyBhcmUgYWx3YXlzIHJlbW92ZWQgZnJvbSB0aGUgbGlzdCBiZWZvcmUgY2Fs
bGluZyBmcmVlX21xZCwNCj4+PiBhbmQgdGhhdCBsaXN0LXJlbW92YWwgaGFwcGVucyB1bmRlciB0
aGUgZHFtX2xvY2ssIHRoZW4gdGhlcmUgc2hvdWxkIGJlDQo+Pj4gbm8gcmlzayBvZiBhIHJhY2Ug
Y29uZGl0aW9uIHRoYXQgY2F1c2VzIGEgZG91YmxlLWZyZWUuDQo+Pj4gDQo+PiBubywgdGhlIGRv
dWJsZSBmcmVlIGV4aXN0cyBiZWNhdXNlIHBxbV9kZXN0cm95X3F1ZXVlIGZldGNoIHRoZSBxdWV1
ZSBmcm9tIHFpZCBieSBnZXRfcXVldWVfYnlfcWlkKCkNCj4+IHRoZSByYWNlIGlzIGxpa2UgYmVs
b3cuDQo+PiBwcW1fZGVzdHJveV9xdWV1ZQ0KPj4gCWdldF9xdWV1ZV9ieV9xaWQJCQkJcHJvY2Vz
c190ZXJtaW5hdGlvbl9jcHNjaA0KPj4gCWRlc3Ryb3lfcXVldWVfY3BzY2gNCj4+IAkJCQkJCQkJ
bG9jaw0KPj4gCQkJCQkJCQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUNCj4+IAkJCQkJCQkJCWxp
c3RfZGVsKHEpDQo+PiAJCQkJCQkJCXVubG9jaw0KPj4gCQkJCQkJCQlmcmVlX21xZA0KPj4gCWxv
Y2sNCj4+IAlsaXN0X2RlbChxKQ0KPj4gCXVubG9jaw0KPj4gCWZyZWVfbXFkDQo+IA0KPiBJIHRo
aW5rIGlmIGJvdGggdGhvc2UgdGhyZWFkcyB0cnkgdG8gZnJlZSB0aGUgc2FtZSBxdWV1ZSwgdGhl
eSBib3RoIG5lZWQNCj4gdG8gaG9sZCB0aGUgc2FtZSBwcm9jZXNzLT5tdXRleC4gRm9yIHBxbV9k
ZXN0cm95X3F1ZXVlIHRoYXQgaGFwcGVucyBpbg0KPiBrZmRfaW9jdGxfZGVzdHJveV9xdWV1ZS4g
Rm9yIHByb2Nlc3NfdGVybWluYXRpb25fY3BzY2ggdGhhdCBoYXBwZW5zIGluDQo+IGtmZF9wcm9j
ZXNzX25vdGlmaWVyX3JlbGVhc2UgYmVmb3JlIGl0IGNhbGxzDQo+IGtmZF9wcm9jZXNzX2RlcXVl
dWVfZnJvbV9hbGxfZGV2aWNlcy4NCm9oLCB5ZXMsIHlvdSBhcmUgcmlnaHQuDQpTbyB0aGUgZG91
YmxlIGZyZWUgSSBhbSBzZWVpbmcgaGFzIGRpZmZlcmVudCByb290IGNhdXNlLiA6KA0KDQo+IA0K
PiBSZWdhcmRzLA0KPiAgIEZlbGl4DQo+IA0KPiANCj4+IAkNCj4+IA0KPj4gDQo+PiANCj4+PiBS
ZWdhcmRzLA0KPj4+ICBGZWxpeA0KPj4+IA0KPj4+IA0KPj4+PiAJfQ0KPj4+PiANCj4+Pj4gCS8q
IFVucmVnaXN0ZXIgcHJvY2VzcyAqLw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
