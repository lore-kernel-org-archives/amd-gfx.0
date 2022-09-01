Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79573ECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Sep 2022 12:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC33210E70F;
	Thu,  1 Sep 2022 12:48:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E9F10E6F4
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Sep 2022 12:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xa6/2tEzo5cwr2hP4vLvhRDXH60a8YsMEasar/IFHovnLhBOTMDA1bS54YRYMwQeb/QqwOoHR1eNzCNbz+12Dksr4AOOPzToAPxIVx5GQqc7fs8TcOtaWM+LeaeeEagj9l5fzGZrw5V3KZxOeuSryNJZeY4qGkQyvIOBMi+ibVXwLyM0Hkef83O2fLNAP/gurfbfkwMRuREzU7sN1JBr7eVrKh0FMUyYuU6MAt/funf9YTJGxvPKNAfFPK1fsHNlujHihVZmgCmEexylOfrCNGR+dEpf01hm/mrruNkpU66M7zCiLxpYnvVdgpLsY+6a3bHpfhw7p8y696a1vM+XQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lANy/5NyhM8DDoHRp/SzqF4YteVh2Xa0Gw3c3p/T5WM=;
 b=O8XJYgErUFtP6h6zNuMmOwsitiZnS7wS96EYAd3YDRcHF9TansAtJNcqXUdgKGlxt7Mm6O0q6nW8gIYj0YxZdVcL38t/FPoVGHCa4m93MXLA9DWQoRFHadyhCdWEjV3uf+LLXyWSOezrNOCO+QAUUj72hcIBwf+veFIJGp/EChh1BuK/1Se35RWUeN3cxvTvOakJS+Z1mVXdjMIpdEx3dvmmH4fRQtjd7bwh+5xXhboOUEbS1zPDVUDfG02rTKNRG32wuvpByuMrQfiV9iGSa7kFUMjyS91DhTv/U5it93gZwKpaRPQBaCU7IVheLKv/9ysj2W0CDOoaAzzGPFol8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lANy/5NyhM8DDoHRp/SzqF4YteVh2Xa0Gw3c3p/T5WM=;
 b=DhxyDzFUxq+1iAy2KKFUaLunUlWxMZRIYp5s1GKelTvugVC2i2EeJ8KIYJkOMdC+WaEIDbuvMYAs/qOIeJWqi3rq4rOqoIigdOqGoCPgNCg8v0KASBbOWthBnTvCq79bBg35BGkaNENl/aCjZASjte3EUyTeq09r0VyjfuX8VEw=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 1 Sep 2022 12:48:45 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::bd9a:516b:ca81:3b46]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::bd9a:516b:ca81:3b46%7]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 12:48:45 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Song, Asher"
 <Asher.Song@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lee, Alvin" <Alvin.Lee2@amd.com>, "Lei,
 Jun" <Jun.Lei@amd.com>
Subject: RE: [PATCH] drm/display: guard if clause
Thread-Topic: [PATCH] drm/display: guard if clause
Thread-Index: AQHYveMDvzFHes8AGky2H7SpQ29Gra3KajqAgAAbS5A=
Date: Thu, 1 Sep 2022 12:48:45 +0000
Message-ID: <DM5PR12MB2469A08BDFF5DE74470E00F6F17B9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220901091108.108103-1-Asher.Song@amd.com>
 <1e3b5deb-48ae-ac30-8b34-671946a34bac@amd.com>
In-Reply-To: <1e3b5deb-48ae-ac30-8b34-671946a34bac@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alvin.Lee2@amd.com,Jun.Lei@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a415089b-1acf-4021-a298-08da8c184e91
x-ms-traffictypediagnostic: DM6PR12MB4155:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x1ruqi503jKnS1Ba9o2zRJsxB4Qh/PK8VDlGawqLprvirERQwdGCJrHq5aSpJoGHevuQ4Rlirnlv+QGQMD9U6FFz08D3gEENO2ZZb6ctvLLmMJpUVJ06oqGLeRf1nXar2TXM63+4+KHDjcrwI7aMIadPA8bJLmY+mKlWkysQ9if8MBWk1wWrHpwefS+GwSfij2ZsQLeNgVKYrlKh1qsG+iIzmh52bIFWWFS4B4TKY4mrOjOz27xpi+47Lvze6k4tFl6G0ZQK5PWfxcu4y6nXKueMKaO8+6LdnPkRxTTVKonkfEPPjgsBM1Ov5AaIzSzM3ym1GqiU4mF2MWTWk2GYcb4WsTJhB177RtYgEqbJFeJ8TVTs3AtPdXyMJ5m/Y5RzUmTdMQHx2uWzb33qlsFnC8PukneVt0mFw0H+/voIvBnucSmaggyBEBkXVVTqoNS6XN9vlnSmKzRAZ3MoHZuUA6lMDr50s4l/4XvJhAhNtXaB9xuFi9NDmJAhPTRJOM5P/7jJfee5uqTbtJHEu5bu/sqN7CEoQ/MCl2Yoc9SDowqJK4fjuPltZxPzz4+nK9jfGVOPX2680bLs08+GxSk8/B4T3qu+8RTrhKPmMponZHAiClpCniMvozbueQwz/XPNk9/Uqyfn73ziYmMJLxKQQ2yVK35JwjgluUtibzx76Qfe8Jw3NqgXXYSSN2vLCQauepSLvQpy3eED1+FhGtm/1v/pHS2hTN/Fk32dBQMDQp5gOyvDNj18f3RCA3GjOOwnu5C1urX41Jf3JFAU8iEbYw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(38100700002)(478600001)(71200400001)(55016003)(122000001)(52536014)(2906002)(33656002)(5660300002)(8936002)(6636002)(38070700005)(110136005)(66476007)(66446008)(66556008)(64756008)(66946007)(76116006)(316002)(86362001)(8676002)(186003)(26005)(9686003)(83380400001)(6506007)(7696005)(41300700001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDdhdHZLZVlBaVcxU1k5bFVaU1hQVFFMNUJJU2U3c3RMRldrQlZEazBUN2ds?=
 =?utf-8?B?RVVUMmZ4MGN0S1VEQnE1d2FoUm5BTWJncnlNcDBiQnArUFh6WVhzVTdvcEQ2?=
 =?utf-8?B?bTNjV1RqMzFGa1hYaWtwQklwb29RU09YV00xTXVkeC8zanpaQkNnMHNzOUJB?=
 =?utf-8?B?Vk5VK0VjL0VYQ2I3TWFEa3lHeSsrdy9jSmZWOC9QVEtHeXF3QTlGeFArNEh2?=
 =?utf-8?B?bVJVZzdmaFFpNkhoOUZRVGQvbmx3Z2pQK2pXYldsNkV0dC9iUkw0UTRRRVV5?=
 =?utf-8?B?c3daTXk1ZlEwZW5OZ3hrK0hHZGhKT3FQdmdtZm9IYkxmdHphMXJtaWRhekpK?=
 =?utf-8?B?LzdLVFc2SFR0c1pmNm81dnpaTkNNZnkzSGp3ektsb25ob3FkSmdNbm00aWph?=
 =?utf-8?B?ZjYzbDV6OVgrT1ZKSkQxVWl1ek03Qlp2NGREMS9ULzAzQlV1Qk52L1Q3Z0pT?=
 =?utf-8?B?RHYvWUFuc1dIOWszb3ZnbSthSGxucDYvbEVYTFNOdDRRcE4xSU1HSE43NzJL?=
 =?utf-8?B?WHlhbzVQRHdzcUZhVjlmRjJFdlJTL09tSEVrejd3N09oYXNlZDRKT3lxWmF0?=
 =?utf-8?B?S21iZTEvZ1ZMMmRVWTBtbTRvWWw4aW5uWnI5VURsdHBuRW5Dd2NPMmExM1Ns?=
 =?utf-8?B?ZXg2MXNwYmJOM0xRS3FRb0dIM2Q1S1N0QjB6bGlKS2dkazhVWUdKYkJsL1JI?=
 =?utf-8?B?d3Z6VTMyVzFHUlhNQVZnK1FsSXZReGlCUUw2QW5Yak9weXA5eksrVmZEWjU3?=
 =?utf-8?B?cmRlYmt6TkZ6TnFjNXAxWjBEQ2J6T2dQbzg1WjFza0o1bGpsNk5hcTQ5dWp0?=
 =?utf-8?B?ajAwekRnTWZsT3dqbzdhK05pb1lWNzVGcmFvODRoWEdsaG56UTZOU2ZxQ1dt?=
 =?utf-8?B?bTh0TzZTZFFWQWc3ZTJJbjhGNzlHR1haL253T09RWVZpVlFBeEZ2UE5pTVZq?=
 =?utf-8?B?TVZGa3A2QjRMUGRtdXhrYy9CbzRncGFtWVplVzNEdWZ1cUpKL0NlTWJiM3Jj?=
 =?utf-8?B?djZ5TkpIbUZMUFNPekZJdzc5R1NqUnQ1WlVYVHdpOUMrbENNTFVTaGU3VXpS?=
 =?utf-8?B?b3RJTWFmei9BSjhHdzBTcGFNdStzdXRPOERPMEI3WnhiVVpUSElzdHdyUHh0?=
 =?utf-8?B?WDdMaXJsZDQ1OGRpZi9zWkJmOXczVHljVnAwZzY4MVVpQytSamYzWGJKV3Zh?=
 =?utf-8?B?ZG9jY1N3OUUvNXM4U3dsdGtkek1hUHBkNDQrbkh2bGtDMnVkNDBBRjFTbHVr?=
 =?utf-8?B?ejlOMkJadXpON28rZEFjMDFkVGtHVGdLdE9hMHdEdG55c3BwVnNsK01LRUtt?=
 =?utf-8?B?ZEpCWjFLMC9wRDFZcHpQZU9xWDRGN0pvc1FnR0J3Y3NnMkZkZG1SSWxNeFQ3?=
 =?utf-8?B?TWZmSHpFTmhwT2k4YStwVmYyYlE4L2JzTzJNR0RTdUVoQlZSYmdXMzBSRCtS?=
 =?utf-8?B?N1Q3ZlZBTmd4bjBjc1hKVG1aMzFTNTlWblp6Y2Vjb1RadnBOWEpnWUJaamZi?=
 =?utf-8?B?c1RNOFVXZGpIbjZBQ0VjaTNSTjFpb3EyeEwrVmtLRmZ5RnpINjd4MkRCYjNB?=
 =?utf-8?B?MUo0MmM3ZU1nV0ZIN1YvZ0FPc2pWOHp2dSt1K01kNnNIb09Xem5IU0NNK0Yv?=
 =?utf-8?B?dlA3Z2RQbGE5RjM4UCsyUXZ1ektRMkNZU0JyR0pqRVBKanhLd2JMTjdTaUNO?=
 =?utf-8?B?QjZvdC9WWWp5U3NEdFVHbGMwZ25RZHFCQUowa2prQWlqd2ZPS2FMMVpZRGFv?=
 =?utf-8?B?b1JEK0hDWWlhS2Q3R051eGlmWmF3WWhLdGVsYjRiaXNFVVJwSFFmTnFFRkVH?=
 =?utf-8?B?MmJBUExIYm9ESngzb1V3UW1SM3JDVThPSGl6SFJMS2lMRHNQeVZsanVsRTJT?=
 =?utf-8?B?YVFzdHB2dHA1TkNUZk1oWmlkcTZzdnoxamVVWEc2dDI4LzVnS25DMXhLa1Az?=
 =?utf-8?B?YnVhS0ZwR0ErQ09Kdi8rQ2NGNkNNWGRkTFBWUHlwSXU3QlRhdEkxaXUrN1E2?=
 =?utf-8?B?dSticmxiWW1sT2xNc2ovaFV2Y3p4enJEeVZ4RjdNd1VybTRic3BuQlV5Q0lJ?=
 =?utf-8?B?V2tPcmdNUUtqcUE2RmxYbGF4ZUs2SlVkcWRObTFaZFBzdXRqNnF1WlUxVVJY?=
 =?utf-8?Q?iX85I+OfcdcCHqRIMUZndFw9x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a415089b-1acf-4021-a298-08da8c184e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 12:48:45.0992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hv1UC7WuDJ2BKkl2E0FaGJXsZNPPdlgr8LW5N7AJOUKwK4SwqbXW58uKTta+N9DvQmE/EZilFQLG0bOtgGsK7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

WWVzLCBleGFjdGx5LiBUaGUgbG9naWMgaW4gdHdvIHN1Y2Nlc3NpdmUgaWYgY2hlY2tzIG9mICIo
dXBkYXRlX3R5cGUgIT0gVVBEQVRFX1RZUEVfRkFTVCkgIiBpcyBpbmNvcnJlY3Qgc3RpbGwuDQoN
ClBvc3NpYmx5IHdlIGNhbiB1cGRhdGUgY29kZSBieSBkcm9wcGluZyBvbmUgaWYgY2hlY2sgYXMg
YmVsb3cuIEFueXdheSwgdGhpcyBuZWVkcyBjb25maXJtIGZyb20gZGlzcGxheSB0ZWFtIEBMZWUs
IEFsdmluIEBMZWksIEp1bi4NCg0KaWYgKHVwZGF0ZV90eXBlICE9IFVQREFURV9UWVBFX0ZBU1Qp
IHsNCiAgIAlkYy0+aHdzcy5wb3N0X3VubG9ja19wcm9ncmFtX2Zyb250X2VuZChkYywgY29udGV4
dCk7DQoJaWYgKGRjLT5od3NzLmNvbW1pdF9zdWJ2cF9jb25maWcpDQoJCWRjLT5od3NzLmNvbW1p
dF9zdWJ2cF9jb25maWcoZGMsIGNvbnRleHQpOw0KfQ0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPiANClNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMSwgMjAyMiA3
OjA3IFBNDQpUbzogU29uZywgQXNoZXIgPEFzaGVyLlNvbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOyBMZWUsIEFsdmluIDxBbHZpbi5MZWUyQGFtZC5jb20+OyBMZWks
IEp1biA8SnVuLkxlaUBhbWQuY29tPjsgQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29t
Pg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2Rpc3BsYXk6IGd1YXJkIGlmIGNsYXVzZQ0KDQpX
ZWxsIHBsZWFzZSBhZGp1c3QgdGhlIHN1YmplY3QgbGluZSwgdGhhdCBzaG91bGQgcmVhZCBzb21l
dGhpbmcgbGlrZSAiZHJtL2FtZC9kaXNwbGF5Oi4uLiIgb3IgImRybS9hbWRncHU6Li4uIi4NCg0K
QW0gMDEuMDkuMjIgdW0gMTE6MTEgc2NocmllYiBBc2hlciBTb25nOg0KPiBUbyBlbGltaW5hdGUg
dGhlIGZvbGxvd2luZyBjb21waWxpbmcgZXJyb3IsIGd1YXJkIGlmIGNsYXVzZS4NCj4NCj4gZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjLmM6IEluIGZ1bmN0
aW9uICdjb21taXRfcGxhbmVzX2Zvcl9zdHJlYW0nOg0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RjL2NvcmUvZGMuYzozNTIxOjI6IGVycm9yOiB0aGlzIA0KPiAnaWYn
IGNsYXVzZSBkb2VzIG5vdCBndWFyZC4uLiBbLVdlcnJvcj1taXNsZWFkaW5nLWluZGVudGF0aW9u
XQ0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NvcmUvZGMuYzoz
NTIzOjM6IG5vdGU6IC4uLnRoaXMgc3RhdGVtZW50LCBidXQgdGhlIGxhdHRlciBpcyBtaXNsZWFk
aW5nbHkgaW5kZW50ZWQgYXMgaWYgaXQgd2VyZSBndWFyZGVkIGJ5IHRoZSAnaWYnDQo+IGlmICh1
cGRhdGVfdHlwZSAhPSBVUERBVEVfVFlQRV9GQVNUKQ0KPiBefg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBBc2hlciBTb25nIDxBc2hlci5Tb25nQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgfCAzICsrLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYw0KPiBpbmRleCBiNDkyMzczOTBjY2UuLjY2MDcyYWMx
YmI0ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jDQo+
IEBAIC0zNTA1LDExICszNTA1LDEyIEBAIHN0YXRpYyB2b2lkIGNvbW1pdF9wbGFuZXNfZm9yX3N0
cmVhbShzdHJ1Y3QgZGMgKmRjLA0KPiAgIAkJCQkJdG9wX3BpcGVfdG9fcHJvZ3JhbS0+c3RyZWFt
X3Jlcy50Zyk7DQo+ICAgCQl9DQo+ICAgDQo+IC0JaWYgKHVwZGF0ZV90eXBlICE9IFVQREFURV9U
WVBFX0ZBU1QpDQo+ICsJaWYgKHVwZGF0ZV90eXBlICE9IFVQREFURV9UWVBFX0ZBU1Qpew0KPiAg
IAkJZGMtPmh3c3MucG9zdF91bmxvY2tfcHJvZ3JhbV9mcm9udF9lbmQoZGMsIGNvbnRleHQpOw0K
PiAgIAkJaWYgKHVwZGF0ZV90eXBlICE9IFVQREFURV9UWVBFX0ZBU1QpDQo+ICAgCQkJaWYgKGRj
LT5od3NzLmNvbW1pdF9zdWJ2cF9jb25maWcpDQo+ICAgCQkJCWRjLT5od3NzLmNvbW1pdF9zdWJ2
cF9jb25maWcoZGMsIGNvbnRleHQpOw0KPiArCX0NCg0KVGhhdCBsb29rcyBsaWtlIGEgc3RlcCBp
bnRvIHRoZSByaWdodCBkaXJlY3RseSwgYnV0IHBsZWFzZSByZS1yZWFkIHRoZSBjb2RlOg0KDQpp
ZiAodXBkYXRlX3R5cGUgIT0gVVBEQVRFX1RZUEVfRkFTVCkgew0KLi4uLg0KIMKgwqDCoCBpZiAo
dXBkYXRlX3R5cGUgIT0gVVBEQVRFX1RZUEVfRkFTVCkNCiDCoMKgwqAgLi4uLg0KfQ0KDQpUaGF0
J3MgY2VydGFpbmx5IHN0aWxsIG5vdCBjb3JyZWN0Lg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0K
DQoNCj4gICANCj4gICAJLyogU2luY2UgcGhhbnRvbSBwaXBlIHByb2dyYW1taW5nIGlzIG1vdmVk
IHRvIHBvc3RfdW5sb2NrX3Byb2dyYW1fZnJvbnRfZW5kLA0KPiAgIAkgKiBtb3ZlIHRoZSBTdWJW
UCBsb2NrIHRvIGFmdGVyIHRoZSBwaGFudG9tIHBpcGVzIGhhdmUgYmVlbiBzZXR1cA0KDQo=
