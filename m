Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EACC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7C361211
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E7C361211
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D60076EDE4;
	Fri, 24 Sep 2021 05:50:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C69CF6EDE4
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 05:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3/jIWhIZpBGJqtxDXdmb54cPTlqqOe9ff6AsJ6+QJ6jEQqUBHNKPgQzIhwlgin4sTZ6IGgajU10F0qzplbmCK0mG2zVtWKJ7qeKDg87n0NYji7di1h4aVAifxeaM/msZA5cm1UfLyK6/2OE/S+MoqxLyVJe/euo8Rz3NTlWvTK1nxQo4FeY4JZhd3rNXQQOzQ9617NTV6I44N6EKdX6tvE6U8+HwHVYKvttQL5DGd2LDdRmHzzfTfFVYzBi80QwCNcAV4dz0p1yZnK1BUV9aBQG50GONJrC/O2fvrnofTkkiQ1AMMGWKvUZ894MD9jopqLcf2zCFA83qJ31P2isug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=2fc9tNIcs033T1rHT/ge6qoVnkKwwItyaoJEoJezKiw=;
 b=ApPe3jgTcJv0M22LzIw5ygctkomZZ6t1Sfr9GKzamGp663F0B+BS16BrKZXPSH6SdT8xeuvFjSHeH4ECvfJILxBqbNDfVa0Ruuhs1SGGQemqerSZ34mrHzKC6wJuiJbsgh5AJzQliR+hm6slK23U9Zra0aBp1ErXfc9IRDUuOkSt7dQsKWRWvNyP2wNrvAqEDLWcQbDP+B3G6p4t3DVwce5XonHy9tL7dfOq93//YZqxV67bNaVy2ElgyCud9bCry2zQZ+FzGzDHBPMpV7ifQr0kL3vSo78fvxeeQTXG5iXaEBI9vhkC//vLXiUlO14J09qqo0tEvz9kCLbFmJe3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fc9tNIcs033T1rHT/ge6qoVnkKwwItyaoJEoJezKiw=;
 b=DPN9H6R81fU6HX4WMqXwxfSJqF3QouZ/S94RExxfLxXE6qd5G6zrnFwWKM+AbbDWoW/DAlOF61UXaLwfX0pPIeZ1927jIUfLneyfBBugu0tv67hJZ43qa/dHarGjd0OpU454e+C3KaD2w1F7s1kf8WIq4hW6g1gc3hPQLuuBL0g=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.18; Fri, 24 Sep 2021 05:50:06 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 05:50:06 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/kfd: fix ttm_bo_release warning
Thread-Topic: [PATCH] drm/kfd: fix ttm_bo_release warning
Thread-Index: AQHXsF+MFLhwcdC4i0yA4fQIMdExrauxfp0AgAAFQcCAAAcjgIAAFGOQgAAVHgCAAPVIwIAAA0mAgAABUSA=
Date: Fri, 24 Sep 2021 05:50:06 +0000
Message-ID: <DM6PR12MB4250C7EC2039EC6405C5EDAAFBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210923094405.144613-1-lang.yu@amd.com>
 <063d904f-4083-f5db-b3d0-eb4e080b055f@amd.com>
 <DM6PR12MB4250123CDF0A1F69AD1C1131FBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <dc3b075f-70f9-6724-9b00-3e00afa922fa@amd.com>
 <DM6PR12MB42507FAA5B24CB49218517ECFBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <066e138e-3eab-8c4c-04b9-6c7b5d6a4acc@amd.com>
 <DM6PR12MB425014A356EE6C8D865D5AC3FBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <6d9ae09f-4347-8a58-0cd4-1efb0955fe0f@amd.com>
In-Reply-To: <6d9ae09f-4347-8a58-0cd4-1efb0955fe0f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-24T05:50:03Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6e4fe1c8-2983-4f3c-bfae-5799c1f3790f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a183ae0d-b7d1-4a3c-100f-08d97f1f293a
x-ms-traffictypediagnostic: DM5PR1201MB0201:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0201AE5B085D33D6659925A6FBA49@DM5PR1201MB0201.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nuNRL3lMIsTmk0s+vPEmxagV5ibkK9GW1PzPKS5cCem1B7ibXbKrOhT3OWxjqyo4P5W5NmxT6M7TgIuYRPN56TQKMihDntdRZIfcgv1kQqGlyUDZu895EpDy6M5DJQxQfWj81Ds1dQSJUaDDxD+weMbUaw8oW0F4GxIefKuNycPEGbspwJGMIWetEjlIHvkX3+VXhODG2BnrfSvxU7x3QJxBWvvAkRRhPRe+YZNhSxwkzx1Mwv2cRBrvJYWa2GPeheDK34TzWSH2ApxXNPiUDnaD/pECw5eRs6olEmIhLwnpnwJkPWNnWaZHwIFf4GyRgCXKU4PbesOXwbD1SElrKoqf2+xrlFLyyybOUbMlDbydUfEOLlEfxidVN9kc90xcI24BhWVdtneD6LlfgBp03AVv1klWpPpmQSByhLma2IX+aSTCXIfw1G74YxFOVdJwvsnwq0v9O1OCFDWMz/hm2KG1lfXQINXX8gVW1XUBqbQcewlRjswfaY4l/iSDn0Zop4ZQCDrEGCkYBphkDirdgY8Ft585+Yu2sTmGyzznM+rCj6vsworV+R3p0q0Bh/FjiZF/r6sVwEIGve6WEuiCqTBUBR1Ul+iEnuAaFuMngTcvqemDMakWfQeu+PH4KtbuL5p4dHutF4OEM2VljEJHe7vxnl2MtVXy8IGBPX8qT6UD9a9aP4bHKcz50UvLYcJg3+bxEtzNNVdqcESZuHimhA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(83380400001)(71200400001)(5660300002)(2906002)(38100700002)(8936002)(110136005)(54906003)(508600001)(33656002)(52536014)(122000001)(6506007)(316002)(8676002)(53546011)(4326008)(26005)(66946007)(66476007)(66556008)(64756008)(55016002)(76116006)(66446008)(186003)(7696005)(9686003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW5sVXl4dGRJbytGL09QdDJFYWNCMklaU2FNVmJ6MGRvZWZqUU9HeFoydWVa?=
 =?utf-8?B?WnZvZ2swZVE4Mjl4N3FMdEdleENHaTFBOWZxZ0tBMkFSSXJnTkxaSnE0TUVU?=
 =?utf-8?B?dUhVZVJHTXRjTjlHZExDSzlRMFRKMkVoaWEwcmFKOC9zdkNDc1NWNUpzZlBF?=
 =?utf-8?B?UWFnK3llZkxmMnlLRlJVRlg1WU9lcUhXUVdRNmFWTXJ3bkpUTU00Ylp1MWVJ?=
 =?utf-8?B?ZzkwY3pHWVNFcGVWN1pTdno2a2h6d0JBR09nc0FWaEI4eSs2QzNOWkpVSnl5?=
 =?utf-8?B?NFd0emFDcDltaVJpWkhEb1JLYlg2Qk0wRE9ZUEdISmdBdE9YWlpabExlM3hu?=
 =?utf-8?B?UHJiWWFNS2I5cEpyNk5KV3NYT0RMcnJId2tyektlMUwrZGphY29mWjhnQ3Vz?=
 =?utf-8?B?blNxbE8zQSt1ZFNMdTJQZkNGUnBVSXVIVjYyZG9DWFV0a3hCVXUwYU0vK21S?=
 =?utf-8?B?bkRhMzZVNTVjaVZTVkZpTmhtcUtiRHhlZlRRTmRYWDBZMCswcy9EQmp2c2Rp?=
 =?utf-8?B?ZU9LZ2VrcFYwZG5hRXQxUi9sOHdnQXV0UTFWdkxXMUxsMlFXcjVkR29SSzlX?=
 =?utf-8?B?QlFOcGNlZ2dyMmpRZmMvZHJIaWpBUDMzV2o2dVNwbWJwR1Y0cEovOWxFT3Nr?=
 =?utf-8?B?a01GOG1WRGd5OTRxcjVGV0x2MTlEQkM0T3FvcHF0YVpRRVFMMlBWTzZGNWE0?=
 =?utf-8?B?cnZxY0svSjB2Q0ZUVHJRc1VXdzRQZFFSNURteFNxcS80Y0FEYnlnWWdYZmdD?=
 =?utf-8?B?eDlmOFVjYUsyZlJrczBzTmp5WDBDWWpwNVF1NVk2ZnhBTGticitxUTRIM2RC?=
 =?utf-8?B?Z1BmL2Urd0JwSEx6bDFvYk55M3BtSkhGNkliZXZuL0xrckloMkhqUnhzeHJv?=
 =?utf-8?B?dGpQQkRYUENpNHh5TUJyTEQ1ODlKRENGSmpuSTBUR0xHNFdSTzFCOUozOC9w?=
 =?utf-8?B?ZWYxaGFzd3pZS242Y05zeDY5OWR4M0RtcmplQkRyU0Y5MjhTS0RGaVpITlNu?=
 =?utf-8?B?Y1A3OFpvWXpUTlIyUDdJRy90cUFDNWxpVjNDcmlpZFdOczFqcm5lbDJyTnB3?=
 =?utf-8?B?Sy9YU29WazVUelcwMGZFdWw4ZUZZMVFoMkhiSiszYUlWaU9GLzFlc3UwMUQ4?=
 =?utf-8?B?SHZNcFVmSVQyM3VjcUR2eWNKTVYrdjNQZFp6MkRjWkNYYUJ5NUlBYmlSZ2tM?=
 =?utf-8?B?bnhzQUZqeUV0M29lbjMxTzNRNlJyZ0tScGFPajNXcDFHeFFONHNvRVY1ZXRY?=
 =?utf-8?B?dTN3b3JMYjFwT1MrQ1ZwWnJPNEZBL0V2WkltRkYySHZjZlNTWVNQa054UFh5?=
 =?utf-8?B?R25MS0tMZVdiSWF0czkveU95RFdzTkJ3SDlLbk14ZDIyaXpFcS9MNVpmQjNx?=
 =?utf-8?B?WXBnMFViWXZHM0NpUzBYbDNsdnJHUG8ySWNnSFR6dG5TdDltMktleUhrcEI5?=
 =?utf-8?B?L3h5SWlWTFlKMXVaU2pYOEJnT2c2K284TnV1cWRsV0hvVzJoS001VVJkYlli?=
 =?utf-8?B?UHR0TC9vYTVpa0xkSEZaVEgzZEFMVjYzUmJSOU5JQWFwYUpvMHA2Q0dxc256?=
 =?utf-8?B?VnN1RVNxYkZCZTFqSTgzZ2xQVmhvVWZLaVh6NjB6SkdhamRPZ1FDTW8xejdh?=
 =?utf-8?B?bGhSRXM1Nmo1ZHV5NUlFcXVUNW5CS0JSOHI4UUJUb09pbXFZaUhlMUhJUlk1?=
 =?utf-8?B?cWtTWTcvQW5QTWI4Y21jQXBIVENoamVpYU9PcG9CbXE3R1FsNFI0S3AwUzEw?=
 =?utf-8?Q?IqvsrnBy+6gdv2TqIH50QXfVbjpz7O25HinyOfF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a183ae0d-b7d1-4a3c-100f-08d97f1f293a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 05:50:06.0805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPYxrJBHfASaHh1Sr3m/EfuPi9iIca5zsx8FouiwDL+CuqZSfVdYRzqWYMnzxgpBHoqqtk/BUiJ1VkUR5QoMBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0201
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+
U2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjEgMTo0MiBQTQ0KPlRvOiBZdSwgTGFuZyA8
TGFuZy5ZdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj5DYzogS3Vl
aGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgSHVhbmcsIFJheQ0KPjxSYXku
SHVhbmdAYW1kLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSBkcm0va2ZkOiBmaXggdHRtX2Jv
X3JlbGVhc2Ugd2FybmluZw0KPg0KPkFtIDI0LjA5LjIxIHVtIDA3OjM1IHNjaHJpZWIgWXUsIExh
bmc6DQo+PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+Pj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4+PiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDIzLCAyMDIxIDEwOjUyIFBNDQo+
Pj4gVG86IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPj4+IENjOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+
OyBIdWFuZywgUmF5DQo+Pj4gPFJheS5IdWFuZ0BhbWQuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9rZmQ6IGZpeCB0dG1fYm9fcmVsZWFzZSB3YXJuaW5nDQo+Pj4NCj4+PiBBbSAy
My4wOS4yMSB1bSAxNjoyNCBzY2hyaWViIFl1LCBMYW5nOg0KPj4+PiBbQU1EIE9mZmljaWFsIFVz
ZSBPbmx5XQ0KPj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4+IEZyb206IEtv
ZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+Pj4+PiBTZW50OiBU
aHVyc2RheSwgU2VwdGVtYmVyIDIzLCAyMDIxIDg6MjQgUE0NCj4+Pj4+IFRvOiBZdSwgTGFuZyA8
TGFuZy5ZdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+Pj4+IENj
OiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBDaHJpc3RpYW4gSyBu
aWcNCj4+Pj4+IDxDM0I2Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPjsgSHVhbmcsIFJheSA8UmF5
Lkh1YW5nQGFtZC5jb20+DQo+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0va2ZkOiBmaXgg
dHRtX2JvX3JlbGVhc2Ugd2FybmluZw0KPj4+Pj4NCj4+Pj4+IEFtIDIzLjA5LjIxIHVtIDE0OjA5
IHNjaHJpZWIgWXUsIExhbmc6DQo+Pj4+Pj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCj4+Pj4+
Pg0KPj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+
Pj4+Pj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4N
Cj4+Pj4+Pj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyMywgMjAyMSA3OjQwIFBNDQo+Pj4+
Pj4+IFRvOiBZdSwgTGFuZyA8TGFuZy5ZdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCj4+Pj4+Pj4gQ2M6IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT47IENocmlzdGlhbiBLIG5pZw0KPj4+Pj4+PiA8QzNCNmNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT47IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPg0KPj4+Pj4+PiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBkcm0va2ZkOiBmaXggdHRtX2JvX3JlbGVhc2Ugd2FybmluZw0KPj4+Pj4+Pg0K
Pj4+Pj4+Pg0KPj4+Pj4+Pg0KPj4+Pj4+PiBBbSAyMy4wOS4yMSB1bSAxMTo0NCBzY2hyaWViIExh
bmcgWXU6DQo+Pj4+Pj4+PiBJZiBhIEJPIGlzIHBpbm5lZCwgdW5waW4gaXQgYmVmb3JlIGZyZWVp
bmcgaXQuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gQ2FsbCBUcmFjZToNCj4+Pj4+Pj4+IAl0dG1fYm9f
cHV0KzB4MzAvMHg1MCBbdHRtXQ0KPj4+Pj4+Pj4gCWFtZGdwdV9ib191bnJlZisweDFlLzB4MzAg
W2FtZGdwdV0NCj4+Pj4+Pj4+IAlhbWRncHVfZ2VtX29iamVjdF9mcmVlKzB4MzQvMHg1MCBbYW1k
Z3B1XQ0KPj4+Pj4+Pj4gCWRybV9nZW1fb2JqZWN0X2ZyZWUrMHgxZC8weDMwIFtkcm1dDQo+Pj4+
Pj4+PiAJYW1kZ3B1X2FtZGtmZF9ncHV2bV9mcmVlX21lbW9yeV9vZl9ncHUrMHgzMWYvMHgzYTAN
Cj5bYW1kZ3B1XQ0KPj4+Pj4+Pj4gCWtmZF9wcm9jZXNzX2RldmljZV9mcmVlX2JvcysweGEzLzB4
ZjAgW2FtZGdwdV0NCj4+Pj4+Pj4+IAlrZmRfcHJvY2Vzc193cV9yZWxlYXNlKzB4MjI0LzB4MmUw
IFthbWRncHVdDQo+Pj4+Pj4+PiAJcHJvY2Vzc19vbmVfd29yaysweDIyMC8weDNjMA0KPj4+Pj4+
Pj4gCXdvcmtlcl90aHJlYWQrMHg0ZC8weDNmMA0KPj4+Pj4+Pj4gCWt0aHJlYWQrMHgxMTQvMHgx
NTANCj4+Pj4+Pj4+IAlwcm9jZXNzX29uZV93b3JrKzB4M2MwLzB4M2MwDQo+Pj4+Pj4+PiAJa3Ro
cmVhZF9wYXJrKzB4OTAvMHg5MA0KPj4+Pj4+Pj4gCXJldF9mcm9tX2ZvcmsrMHgyMi8weDMwDQo+
Pj4+Pj4+Pg0KPj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogTGFuZyBZdSA8bGFuZy55dUBhbWQuY29t
Pg0KPj4+Pj4+Pj4gLS0tDQo+Pj4+Pj4+PiAgICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyB8IDMgKysrDQo+Pj4+Pj4+PiAgICAgIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKykNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+Pj4+Pj4+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+Pj4+Pj4+
PiBpbmRleCAyZDZiMmQ3N2I3MzguLjdlNjkzYjA2NDA3MiAxMDA2NDQNCj4+Pj4+Pj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPj4+Pj4+
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5j
DQo+Pj4+Pj4+PiBAQCAtMTU2Nyw2ICsxNTY3LDkgQEAgaW50DQo+Pj4+PiBhbWRncHVfYW1ka2Zk
X2dwdXZtX2ZyZWVfbWVtb3J5X29mX2dwdSgNCj4+Pj4+Pj4+ICAgICAgCXByX2RlYnVnKCJSZWxl
YXNlIFZBIDB4JWxseCAtIDB4JWxseFxuIiwgbWVtLT52YSwNCj4+Pj4+Pj4+ICAgICAgCQltZW0t
PnZhICsgYm9fc2l6ZSAqICgxICsgbWVtLT5hcWxfcXVldWUpKTsNCj4+Pj4+Pj4+DQo+Pj4+Pj4+
PiArCWlmIChtZW0tPmJvLT50Ym8ucGluX2NvdW50KQ0KPj4+Pj4+Pj4gKwkJYW1kZ3B1X2JvX3Vu
cGluKG1lbS0+Ym8pOw0KPj4+Pj4+Pj4gKw0KPj4+Pj4+PiBOQUssIHVzaW5nIG1lbS0+Ym8tPnRi
by5waW5fY291bnQgbGlrZSB0aGlzIGlzIGlsbGVnYWwuDQo+Pj4+Pj4gSSBkaWRuJ3QgIGdldCB5
b3VyIHBvaW50LiBJIHJlZmVycmVkIHRvIGZ1bmN0aW9uLSJ2b2lkDQo+Pj4+Pj4gYW1kZ3B1X2Jv
X3VucGluKHN0cnVjdCBhbWRncHVfYm8gKmJvKSIsIHdoaWNoIHVzZXMgaXQgbGlrZSB0aGlzLg0K
Pj4+Pj4gV2hhdCBhbWRncHVfYm9fdW5waW4oKSBkb2VzIGlzIHRoZSBmb2xsb3dpbmc6DQo+Pj4+
Pg0KPj4+Pj4gICDCoMKgwqDCoMKgwqDCoCB0dG1fYm9fdW5waW4oJmJvLT50Ym8pOw0KPj4+Pj4g
ICDCoMKgwqDCoMKgwqDCoCBpZiAoYm8tPnRiby5waW5fY291bnQpDQo+Pj4+PiAgIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+Pj4+PiAuLi4uDQo+Pj4+Pg0KPj4+Pj4g
SW4gb3RoZXIgd29yZHMgd2UgdGFrZSBmdXJ0aGVyIGFjdGlvbnMgYmFzZWQgb24gaWYgdGhlIGJ1
ZmZlciB1cyBpcw0KPj4+Pj4gc3RpbGwgcGlubmVkIG9yIG5vdCBhZnRlciBhbiB1bnBpbiBvcGVy
YXRpb24uDQo+Pj4+Pg0KPj4+Pj4gV2hhdCB5b3UgdHJ5IHRvIGRvIGhlcmUgaXMgdW5waW5uaW5n
IHRoZSBCTyB3aGVuIGl0IGlzIHBpbm5lZA0KPj4+Pj4gaW5kZXBlbmRlbnQgaWYgc29tZWJvZHkg
ZWxzZSBvciBvdXIgY29kZSBoYXMgcGlubmVkIGl0IGJlZm9yZS4NCj4+Pj4gSGkgQ2hyaXN0aWFu
LA0KPj4+Pg0KPj4+PiBUaGFua3MgZm9yIHlvdXIgZXhwbGFuYXRpb24gYW5kIGFkdmljZS4gSSBn
b3QgeW91ciBwb2ludC4NCj4+Pj4gQWN0dWFsbHksIHRoZXNlIEJPcyBhcmUgYWxsb2NhdGVkIGFu
ZCBwaW5uZWQgZHVyaW5nIGEga2ZkIHByb2Nlc3MgbGlmZWN5Y2xlLg0KPj4+PiBJIHdpbGwgdHJ5
IHRvIGFkZCBhIGZsYWcgaW50byBzdHJ1Y3Qga2dkX21lbSB0byBpbmRpY2F0ZSB3aGljaCBCTyBp
cw0KPj4+PiBwaW5lZCBhbmQgc2hvdWxkIGJlIHVucGlubmVkLiBXaGljaCB3aWxsIG1ha2UNCj4+
Pj4gYW1kZ3B1X2JvX3Bpbi9hbWRncHVfYm9fdW5waW4gY2FsbHMgYmFsYW5jZWQuIFRoYW5rcyEN
Cj4+PiBUaGF0IGlzbid0IHRvIG11Y2ggYmV0dGVyLiBUaGUgcmVhbCBzb2x1dGlvbiB3b3VsZCBi
ZSB0byB1bnBpbiB0aGVtDQo+Pj4gd2hlbiB0aGUga2ZkIHByb2Nlc3MgaXMgZGVzdHJveWVkLg0K
Pj4gWWVzLCB3aWxsIHVucGluIHRoZW0gd2hlbiB0aGUga2ZkIHByb2Nlc3MgaXMgZGVzdHJveWVk
Lg0KPj4gQnV0IHdlIHNob3VsZCBpbmRpY2F0ZSB3aGljaCBCTyBpcyBwaW5uZWQgYW5kIHNob3Vs
ZCBiZSB1bnBpbm5lZC4gUmlnaHQ/DQo+DQo+V2VsbCBub3Qgd2l0aCBhIGZsYWcgb3Igc29tZXRo
aW5nIGxpa2UgdGhhdC4NCj4NCj5UaGUga25vd2xlZGdlIHdoaWNoIEJPIGlzIHBpbm5lZCBhbmQg
bmVlZHMgdG8gYmUgdW5waW5uZWQgc2hvdWxkIGNvbWUgZnJvbQ0KPnRoZSBjb250cm9sIGxvZ2lj
IGFuZCBub3QgYmUgcGFwZXJlZCBvdmVyIGJ5IHNvbWUgZ2VuZXJhbCBoYW5kbGluZy4NCj5UaGF0
J3MgdGhlIGJhY2tncm91bmQgd2h5IHdlIGhhdmUgcmVtb3ZlZCB0aGUgZ2VuZXJhbCBoYW5kbGlu
ZyBmb3IgdGhpcyBmcm9tDQo+VFRNIGluIHRoZSBmaXJzdCBwbGFjZS4NCj4NCj5JbiBvdGhlciB3
b3JkcyB3aGVuIHlvdSBuZWVkIHRvIHBpbiBhIEJPIGJlY2F1c2UgaXQgaXMga21hcHBlZCBpdCBz
aG91bGQgYmUNCj51bnBpbm5lZCB3aGVuIGl0IGlzIGt1bm1hcHBlZCBhbmQgaWYgeW91IGRvbid0
IGt1bm1hcCBhdCBhbGwgdGhlbiB0aGVyZSBpcw0KPnNvbWV0aGluZyB3cm9uZyB3aXRoIHRoZSBj
b2RlIHN0cnVjdHVyZSBmcm9tIGEgaGlnaGVyIGxldmVsIHBvaW50IG9mIHZpZXcuDQoNClllcywg
dGhpcyBmdW5jdGlvbiAiYW1kZ3B1X2FtZGtmZF9ncHV2bV9tYXBfZ3R0X2JvX3RvX2tlcm5lbCIg
ZGlkIGEga21hcCwNCmJ1dCB3aXRob3V0IGEga3VubWFwIHdoZW4gdGhlIGtmZCBwcm9jZXNzIGlz
IGRlc3Ryb3llZC4gVGhlIGZsYWcgYWN0dWFsbHkgaW5kaWNhdGVzIGttYXAva3VubWFwLg0KDQpS
ZWdhcmRzLA0KTGFuZw0KDQo+UmVnYXJkcywNCj5DaHJpc3RpYW4uDQo+DQo+Pg0KPj4gUmVnYXJk
cywNCj4+IExhbmcNCj4+DQo+Pj4gUmVnYXJkcywNCj4+PiBDaHJpc3RpYW4uDQo+Pj4NCj4+Pj4g
UmVnYXJkcywNCj4+Pj4gTGFuZw0KPj4+Pj4gVGhhdCBjYW4gbGVhZCB0byBhbGwga2luZCBvZiBw
cm9ibGVtcyBhbmQgaXMgY2xlYXJseSBpbGxlZ2FsLg0KPj4+Pj4NCj4+Pj4+Pj4gV2hlcmUgd2Fz
IHRoZSBCTyBwaW5uZWQgaW4gdGhlIGZpcnN0IHBsYWNlPw0KPj4+Pj4+IEkgZm91bmQgdHdvIHBs
YWNlczoNCj4+Pj4+Pg0KPj4+Pj4+IAlyZXQgPSBrZmRfcHJvY2Vzc19hbGxvY19ncHV2bShwZGQs
IHFwZC0+aWJfYmFzZSwgUEFHRV9TSVpFLCBmbGFncywNCj4+Pj4+PiAJCQkJICAgICAgJmthZGRy
KTsNCj4+Pj4+Pg0KPj4+Pj4+IAlyZXQgPSBrZmRfcHJvY2Vzc19hbGxvY19ncHV2bShwZGQsIHFw
ZC0+Y3dzcl9iYXNlLA0KPj4+Pj4+IAkJCQkgICAgICBLRkRfQ1dTUl9UQkFfVE1BX1NJWkUsIGZs
YWdzLCAma2FkZHIpOw0KPj4+Pj4gV2VsbCB0aGVuIHlvdSBuZWVkIHRvIGZpZ3VyZSBvdXQgd2hl
cmUgdGhhdCBtZW1vcnkgaXMgZnJlZWQgYWdhaW4NCj4+Pj4+IGFuZCBwbGFjZSB0aGUgdW5waW4g
YXBwcm9wcmlhdGVseS4NCj4+Pj4+DQo+Pj4+PiBHZW5lcmFsIHJ1bGUgb2YgdGh1bWIgaXMgdGhh
dCBjYWxscyB0bw0KPj4+Pj4gYW1kZ3B1X2JvX3Bpbi9hbWRncHVfYm9fdW5waW4gc2hvdWxkIGJl
IGJhbGFuY2VkLg0KPj4+Pj4NCj4+Pj4+IFJlZ2FyZHMsDQo+Pj4+PiBDaHJpc3RpYW4uDQo+Pj4+
Pg0KPj4+Pj4+IFJlZ2FyZHMsDQo+Pj4+Pj4gTGFuZw0KPj4+Pj4+DQo+Pj4+Pj4+IENocmlzdGlh
bi4NCj4+Pj4+Pj4NCj4+Pj4+Pj4+ICAgICAgCXJldCA9IHVucmVzZXJ2ZV9ib19hbmRfdm1zKCZj
dHgsIGZhbHNlLCBmYWxzZSk7DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gICAgICAJLyogUmVtb3ZlIGZy
b20gVk0gaW50ZXJuYWwgZGF0YSBzdHJ1Y3R1cmVzICovDQo=
