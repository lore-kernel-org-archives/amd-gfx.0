Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FDBC74A5B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 02:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B2710E012;
	Mon, 27 Mar 2023 02:49:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76A6C10E012
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 02:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnMod7ltsmUL+CqvT6XUBfuRB1alacfDLaEwxF9tOd4h92TfK/yqcoEpbjUQ/13lNGBeb7+YstxBAwLwQAoazGnTRf2+u0J7ddhwQzY8S3Ia8DtRzzCQK1pwRchf0ynCJ7A13h/serN76yjzH1Il5DsLbfzZEs4t58GlMY9sWzIPeHTuf2Vb63Y+AviqUWsMmoLSCUEkW2U17GXi+EGSViEOC6wywXMVbma8I2JWNuZqFqfQ7Y5M4UEvaR7iRZRkR26C7DwCuvMLH2DvOmvTXBz1kRVXmN/02vg3AwUnuRT6v/B6wqi+5WDobhepOkjlojyxw3oFKYoIAQeIDy1Gxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iyr/LCLfU5MnViGNUN3TzOKhs2/c4NoU877ds2WkwZ8=;
 b=in96OlUNlYtT62CuILS7V8uKanrIoWkF5X+XnLjoN/B6oFQ6yXsX5pnkn8KJJqhYpSGmpOJMEfldKyB9/xyUZP1Ov3Mh5EfwMJgdqgS9vxgPWodKrkHgPUlgAiO0Ny0grnkGj1eqYuhmIRggVwYsUP/qYTE364Cv/MmWVCkow7sRhhtJi5HlBH5o3ban2OBtgpHBtxUUptc5UXqsBl/gZQKeEsDP3KPO5JSssvjrlNPmhszKkXdGVZy/zRzx0dSZAnSoy/2u66nEw1Xj9wUdYrlSP2y9aOpztlA4I6wKonAwbZpcX7psLypiUzRnPhvTWJrHuTSCT08LgJNXaWSfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iyr/LCLfU5MnViGNUN3TzOKhs2/c4NoU877ds2WkwZ8=;
 b=4WM8TPELBV0j2pYaIgaCuxo1M/exRT6dUS3Of+BHs7BNVf9SXVCDUKshp/371CpfVMQnobwbH18eG96IURbqpEj38XA5M5rnOXaqXKT1U3yyVOdUT+nz/rzJ+pJGYB/zOJFOMsA/+NVMXmLeiUvAZ0iTieWBrpPkeAU2qGZTsxc=
Received: from DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 02:49:34 +0000
Received: from DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af]) by DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af%3]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 02:49:33 +0000
From: "Yang, WenYou" <WenYou.Yang@amd.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [Resend PATCH v1 0/3] send message to pmfw when SMT changes
Thread-Topic: [Resend PATCH v1 0/3] send message to pmfw when SMT changes
Thread-Index: AQHZXdCRiq1WHho1wE6x8W+3r8tG5a8N79Aw
Date: Mon, 27 Mar 2023 02:49:33 +0000
Message-ID: <DM6PR12MB353134DD69F58F5C9D3FFA8DFD8B9@DM6PR12MB3531.namprd12.prod.outlook.com>
References: <a75662b0-7e5b-16d9-735d-11b00a385a58@igalia.com>
In-Reply-To: <a75662b0-7e5b-16d9-735d-11b00a385a58@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-27T02:49:30Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ccab7248-d31c-420d-b9dd-c0a0572cc576;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3531:EE_|BL3PR12MB6593:EE_
x-ms-office365-filtering-correlation-id: 822c1d49-4ee6-4ae8-8b30-08db2e6de554
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ncw7EYjeL3DzgxCPzGaSBFq5iS1a8DZ1MFK5R0L0zSRXwM++Nqb5Mp6pkYPgva3HYOkCta+qoiD/Onq+lY9KqlyDuXx0pxao8wZpQY4/QjDydEZaBKv+I3+/auxp/1pg9o0sPQK7m0yfblTtELk5SrUuU03wI1rYBAJLNVk5TLRVlOt1qQP9qKI5antOOZqekkKu09laEuyUEA7fNy7nT1av4yzTAkrS6OWBA5hgB7LwmwTJPIjym7MJbQxwiiVyJrUxyhsNruD6il82JR4bPm6zl/e1wDd3jJ7eVq06nnN646Hd5GkP/E6453M98EZk2E/3V/AWG03vycLF/I38pXXu5+bF3FyYUmNbjovIj63erV7u1ohEJJfwbCq0k9VIafp14gnnvoQdtcRpERaJ7xQenGx/H0ImhgvY8trUSN34yYpzZY+tCQwtswTyYVTbod1oR3CLgIQiVjX9RuDmYf5WoA8WM7CDwTCaK3lgfHz1OZsyO8wP4EoQsHXsgtvJnjN4SYaKnofJXK/toNI+aZxqQakd57XuvX1kReyAcloRjOuUBIzcgmIBsqwk9CsSpMUBzcJ0hVFWdKjhykVDoimryPOyWoqavf9yhHzs0HyLKsOpWYmDn6noyxlhqTd5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3531.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(53546011)(6506007)(9686003)(2906002)(83380400001)(38070700005)(86362001)(33656002)(38100700002)(122000001)(55016003)(7696005)(5660300002)(8936002)(52536014)(41300700001)(110136005)(54906003)(316002)(478600001)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(4326008)(76116006)(186003)(15650500001)(26005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NU5PbG04RjJUK2dEZlpuTXQ2Ujc4UFMzY0twSFRBazhvbkFBby9xN3daR0Jt?=
 =?utf-8?B?ODNBU3laWkg4VnlnbG5nT3hoZHRyRzVwSEh4WEtSTzgyR2lJdUx1UDJBcysw?=
 =?utf-8?B?VlYzcERXSldaOGxKK1JEY1ROcHhldmltOXZKeXBmVHRqVDJ6Zi9DRmkwZ01y?=
 =?utf-8?B?N0pvRTFjS2NBUzE3bm5PRGlScXFUYVVyeDBqTnpXdkVUWXRyRDVHajhkZnVT?=
 =?utf-8?B?TjhYaGJiL2srQjlDOXZQQTRKV21CWUJBejlFZTljRjBRVVF0QlZRblNsN3Y2?=
 =?utf-8?B?b040VklTT2xnWmQvUlZtVXp3ZXFZcW5MRkJCUkhjdk1mMWkwRE0yYmx3TmVD?=
 =?utf-8?B?Y05OZmo5VXRYRGNhTWxBVGRsMEo5ek1jQnp0RnRLaWViMG5sMEpFQWo2YW9Q?=
 =?utf-8?B?WVN6N3JkVmdxRlhLMmliaWpXWWJXNFNzak5pUWZ1TXZXSkp1ZXhMNWtGRmNx?=
 =?utf-8?B?cGlpeFR1WEYrSUZwbWxrQWNLd2p4SE4ramV6SDBCeTNVQ0hDeW9VSEJSZnly?=
 =?utf-8?B?dnR2RlB5WTVMbnRWUHpRWGphMlVBRS9COVd6UWsrVUg4QVd2TFZSSVprRE52?=
 =?utf-8?B?R1VRUjhlWWliUk5zdURGcVA5Ukp4aHEvZHpNbW4ydCt0eXdOVWpTTVBzRUdq?=
 =?utf-8?B?cHRVQkxMbTBpK0lpSTZsZDhMK3NOZDE5VUVNcXFydFdRczdyRUplOHV0UVBy?=
 =?utf-8?B?cU9PMXBUU0tsNmZ3Rkw5Q0h5Qy9NeGR6ZW9wYkZVZlhmWkc1QjZ4cWN2RXJ2?=
 =?utf-8?B?dHRQZ2VGQlAvMmtnMEZaV3IzaHR5KzFFVFFjcm8yd2lWU1RyU3pEZzhsVW1E?=
 =?utf-8?B?Z3piZFlrUzNZZmQwOXl0NFdONHoxd0dqVEVnN1BNS3V6eWRYZ3lKUDdmWEhl?=
 =?utf-8?B?NnVDNjhPenNycThrMHBVTktpSFQ0QmJPdFhUbktQR3BpR0F1WENuTHlZMHFi?=
 =?utf-8?B?SHp0M2wxT1plRkQxWGhuWlFidDJqOHBZYUtwck4rQU16MzFXYXdNcEpKQ2VG?=
 =?utf-8?B?c29NalVseGtVOGpYbHdCQnhRbFE3OElDQTNUL1J2bFlGL1RWbnQ0SmM4a1Mw?=
 =?utf-8?B?YjlGeDRXei9kT3ZKeW15Y252a1BOdXVzaXpLclhnVVFNbFZtT29yTGFTVmhx?=
 =?utf-8?B?MXRmdUU5aFBwUlFqL09PNlRVVEowV3JESVNCRWd4Um1aQmk5UGlCWmtFNTNU?=
 =?utf-8?B?V2pDODkzTi9meU1LaW5WWVVhbUhaNGVPaU5tWXJKc1AxYzBPTDlRWnVIeVhn?=
 =?utf-8?B?WVNQQ0hFaHVsZXFzU2lRWWUyRFVaalBoWHExRkVuRDlHT3RVVmhpcUN2cVRD?=
 =?utf-8?B?aVhQOEJrN20xNWVvZDZUbHZmYU05bldRVTZTUGVpN2gwQzRKenV1c0M2Y1Nq?=
 =?utf-8?B?eFZRRWViUmpxa2MxbW85T3d5dFg3MWczVUcwRmZzeWsycGVrT0htbmNjdk1M?=
 =?utf-8?B?TmFVS0w4UTZqUjA0NXBSYVo3Ymc4MGd1ZFUveXBZQWhXMDJLWTBVN0N0RlFJ?=
 =?utf-8?B?RGdOeXpXaTdGRmNWbVVvVEEzdGx5TEtERWxSU2dOcEFCcitzNlVMbFNCb0M5?=
 =?utf-8?B?VmlrNCtlN3hXSU42cG9sd0M5ckFtQTFXMHkzWWVjTlF3czl3VlQzN1drYjk3?=
 =?utf-8?B?cUVlOU04UGp2MXdzSWdRc3VlTWNSVGsvdW56Zzk0RGR1WHN0REg5d0Y0Q0o3?=
 =?utf-8?B?QmZSNm05bWloeHJGNWd2eTIyeXl6THBCZnUveWhLelRnZU9ZaFdXTWJQM1p0?=
 =?utf-8?B?Q0tOTEdwdnlRSE5wUDBpUmhKQ0hNbHBGZk9QUWdtcmVqdWg2N3MwaDFTMEVk?=
 =?utf-8?B?Wk5vMUtqMXVwa3diSzUzb3ZjRVlwQ0MzalNNU1cwb0E4N2tOYnVOdWw0WXln?=
 =?utf-8?B?WUhidE9CNlhHSU1FWUhHcUgzeXZnQUFHYk41cGk2Szl3Nkp5QnJ2alpUUzYy?=
 =?utf-8?B?c2JHczZLcXFRTTcrTG4wNGRxQ3JaSU5NZjYvUW5TeCtoL2JFQWZFMk1RUTNE?=
 =?utf-8?B?T0RIN2JCeEFUejEzZ2owclFlbndMRG8rSTBPSGlMUFlqcG1TNXYxL09mblB1?=
 =?utf-8?B?b3ZBKzlRbzkzUVhEcUtIZ21BQmpNUC84amFqYUd0eVVHRDlLaWRhL0FadWZ5?=
 =?utf-8?Q?um/4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822c1d49-4ee6-4ae8-8b30-08db2e6de554
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 02:49:33.6737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXSKBgwYYNBV30dg02VCr0N5W/Bq45bOWTSDFkL3tmX6+MRnQdj/l+g+2qVsOBzvEH9rFmV/YOP0pHRLCZ0BcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
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
Cc: "Li, Ying" <YING.LI@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Yuan,
 Perry" <Perry.Yuan@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEd1aWxoZXJtZSwNCg0KVGhh
bmsgeW91IGZvciB5b3VyIGF0dGVudGlvbiBvbiB0aGUgcGF0Y2ggc2V0Lg0KDQpUaGUgcHVycG9z
ZSBvZiB0aGUgcGF0Y2ggc2V0IGlzIHRvIGltcHJvdmUgdGhlIHBlcmZvcm1hbmNlIHdoZW4gcGxh
eWluZyB0aGUgZ2FtZS4NCg0KQmVzdCBSZWdhcmRzLA0KV2VueW91DQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VpbGhlcm1lIEcuIFBpY2NvbGkgPGdwaWNjb2xpQGln
YWxpYS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMjQsIDIwMjMgNTo0NCBBTQ0KPiBUbzog
WWFuZywgV2VuWW91IDxXZW5Zb3UuWWFuZ0BhbWQuY29tPjsgYW1kLWdmeCBsaXN0IDxhbWQtDQo+
IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT47IExpdSwg
S3VuDQo+IDxLdW4uTGl1MkBhbWQuY29tPjsgTGlhbmcsIFJpY2hhcmQgcWkgPFJpY2hhcmRxaS5M
aWFuZ0BhbWQuY29tPjsgWXVhbiwNCj4gUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IExpLCBZ
aW5nIDxZSU5HLkxJQGFtZC5jb20+OyBMaW1vbmNpZWxsbywNCj4gTWFyaW8gPE1hcmlvLkxpbW9u
Y2llbGxvQGFtZC5jb20+OyBrZXJuZWwtZGV2QGlnYWxpYS5jb20NCj4gU3ViamVjdDogUmU6IFtS
ZXNlbmQgUEFUQ0ggdjEgMC8zXSBzZW5kIG1lc3NhZ2UgdG8gcG1mdyB3aGVuIFNNVCBjaGFuZ2Vz
DQo+IA0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFs
IFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywg
Y2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+IA0KPiANCj4gSGkgV2VueW91IFlhbmcs
IGZpcnN0IG9mIGFsbCB0aGFua3MgZm9yIHRoZSBpbXByb3ZlbWVudCENCj4gDQo+IEknZCBsaWtl
IHRvIGFzayB5b3UgKGFuZCBhbGwgQ0NlZCkgaWYgaXQgd291bGQgYmUgcG9zc2libGUgdG8gZXhw
bGFpbiBhIGJpdCB0aGUgZ29hbCAvDQo+IGZ1bmN0aW9uYWxpdHkgYmVoaW5kIHRoZXNlIHBhdGNo
ZXMuDQo+IA0KPiBCeSByZWFkaW5nIHRoZSBjb21taXQgZGVzY3JpcHRpb25zIGFuZCBjb2RlLCBJ
IGNhbiB1bmRlcnN0YW5kIGNvZGUtd2lzZQ0KPiB3aGF0J3MgZ29pbmcgb24gYW5kIGhvdyB0aGlz
IHdpbGwgbWVzc2FnZSB0aGUgRlcgb24gU01UIGNoYW5nZXMuIFdoYXQgSQ0KPiBjb3VsZG4ndCBw
YXJzZSBpcyB0aGUgcHVycG9zZSBvZiB0aGlzLCBvciBpbiBvdGhlciB3b3Jkcywgd2hhdCBkb2Vz
IGl0IGdhaW4gZm9yIHVzPw0KPiBBbHNvLCB3aHkgb25seSBvbiBWYW5nb2doPw0KPiANCj4gU2lu
Y2UgSSBkb24ndCBoYXZlIHRoZSBzcGVjIEkgY291bGRuJ3QgcmVhZCBhbmQgbGVhcm4gbXlzZWxm
IC0gYXBvbG9naWVzIGlmIHRoaXMgaXMNCj4gc29tZXdoYXQgYSBzaWxseSBxdWVzdGlvbi4gQWxz
bywgaWYgZm9yIHNvbWUgcmVhc29uIHlvdSBjYW5ub3QgcmVzcG9uZCAobGlrZSBhDQo+IEhXICJO
REEiKSwgaXQncyBmaW5lIHRvby4NCj4gDQo+IFRoYW5rcyBpbiBhZHZhbmNlLA0KPiANCj4gDQo+
IEd1aWxoZXJtZQ0K
