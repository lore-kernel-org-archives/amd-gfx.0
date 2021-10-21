Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1BCC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 07:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4876F6109F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 07:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4876F6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC75C6EB9A;
	Thu, 21 Oct 2021 07:29:26 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 767866EB98
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 07:29:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFM2fqDI+dzgbClqCM3/lTp2xp0s3XPSFGIm9WdfBEkUYsZFAwOyIprBCsLX5wELEV56TzR698PRttFKEUMgMWYTCOvbYHnp/m2hUk8IBJEgW83ge+Pow6nNa1yLhw8aEyFXkAzBdGB31Fkh2GRu6eyW2w8MEaglqUP48j36sIl98/gTG+RcyqJp2hfTQ3M3QSaoqcepTutGsa3yCmu7hnKLhm1oGcI8EEBQAUM95WhC0Ck6mYi1hOqodCvjPBJYS5ZM8xL4APJk+iGIpLzYjFhtyUBornbcqyhLmCCeYCYG31ZUWOAU/vHV95/Yg39Wm43UXUJYFP66KcNC38/14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZREgmsPTDJ3AnL4pu+vldlPlMCUcbCViCDAZncSppDA=;
 b=bnVnIML5x/2ngDWcUA8o5lTGB651uWgCeZpm73oh6YFsidBBLDKleGICMHZXazEEBJsAoTssbrjxmXq4FBd1ZwszIX2VMtOwMQTGesRzX4m5Vhz3Y6Xn72qGVntnzOAEMH46+0nomlvx4n9r13meg+CsAvIlU183Y19N4QhIYxImOZrJcHBMegjWcgA1KBxHKiApwoyy2vNTuK7NzC6w/uAVfXlbpli0jj+MWjqkI+uQYMU724P4iyYEU/EFi+6glqEhuIcexiBoNylbTbKpWxeazdFUvv0gFZZ6lOibbvHN/bKX+5mlPz1ZyG/SBE6MMwMOma7ORpK5CyApJYNHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZREgmsPTDJ3AnL4pu+vldlPlMCUcbCViCDAZncSppDA=;
 b=bYys6WpxefqRW9/hC+0NNobWcBM64UCXiQFLGpmXHChLPjUEB2F1PEo0fTFhFz1HkMB5fHNrHf2+LNBTZn5NulsB6Aq/iWjuNcw9Qn0v5E+VHd4A1STr5LuRFOHKJdhVxGtJX0WIKWvjpxl16z82SVw1cbQO2+lItmsYTITD/NI=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Thu, 21 Oct 2021 07:29:22 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 07:29:22 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: fix a potential memory leak in
 amdgpu_device_fini_sw()
Thread-Topic: [PATCH 1/3] drm/amdgpu: fix a potential memory leak in
 amdgpu_device_fini_sw()
Thread-Index: AQHXxkvO0oo45Yb2ZkG4WAfo4m9Q46vdDWAAgAAARzA=
Date: Thu, 21 Oct 2021 07:29:22 +0000
Message-ID: <DM6PR12MB425064ECD4258EB00440C493FBBF9@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211021071750.2912140-1-lang.yu@amd.com>
 <840b06aa-f0ec-0093-9243-5636a3c5a98f@amd.com>
In-Reply-To: <840b06aa-f0ec-0093-9243-5636a3c5a98f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-21T07:29:20Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=737e6d8f-f75d-4612-a21c-61dced28d02a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd52f78b-2fc8-4c5e-b2b8-08d9946480a4
x-ms-traffictypediagnostic: DM5PR1201MB2491:
x-microsoft-antispam-prvs: <DM5PR1201MB2491C148046A438E33C7A496FBBF9@DM5PR1201MB2491.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c8bNkrBeGLddNipidyfYXCzibGsMKI3nWsOnA6c5wnT3DUq54OqWZxbxsiUbmruCOfca+Wwu4nmulSPPS7uoQrRXriYNkG5/Vvq53MY4LLs6tMgLwtwkV52YwABpSmmBiZACsqEH4xHi792uu/BNyXHGO+mCYmsiKNjW/h2Hn4cRkddkd5vIMvMs0eZReD9Y+jA4Vjdlf5m2R2pkKL05qtu1+nLWgs1D25/gEBrSeR1CimR58B9qwPOE+1mJIWSLcCJ/PtrM1ktwJKkwPGMYS3+sTXV1xYTEd8siTWImK6gGpQ+ADjGBDjXF8mAv7amKlZxqzHQ07joE6PBK113JDK5EtlllpSr8m1NjdBH14goF7J/jwtLxtYwbTq5dgDOtzDUSSTUq86NCUiHF6zquOGevSdupQLlFHvZGkLigu3aEdqROkeSQiZGFehLrMurdReIIEoT/E6zQDViYu05l+Il0dMD1YQnyE7geN6ekj6M78/1mxC/XsGv4Tc3YvZntvyWwcBO+HggBW5QEHrpInbqySaPkS6HmUXlyJ+GP5WQZVbUbj1KqVUBDZqAuD7NBBzTXTO8CePURLrKh5wOC/6XZzuLtjc+x00UdLKFir05pvIjHCuQ+66ANkNh+yXIv/TIsAumDvajvOaTR6YfcqJ7jCa/+PiEF2Tp4LZz+v7r3JpAaSluJs5C2b9koajqlidHyXWrDqyO9DGmpuVLW3w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(38070700005)(38100700002)(83380400001)(6506007)(33656002)(2906002)(8676002)(508600001)(110136005)(7696005)(122000001)(54906003)(55016002)(4326008)(71200400001)(5660300002)(76116006)(66446008)(86362001)(52536014)(64756008)(316002)(8936002)(66946007)(26005)(66556008)(186003)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekxNYVNFMEFLbjU3MEd3eHphc2ZNWXU1am9Md2s4RkQ3bm55M1RNajd6ODJu?=
 =?utf-8?B?RmN4d3N1K2lEam11MU8rcG9qbS9TVkthTjgwbWZCOC9IcGx5N3N1ZXVBZzdW?=
 =?utf-8?B?c1FBNVVtbENiT0VaVS9QbkNsS3VjbmlncFFjSU9vbWxDREFXS0U2U01WVnZh?=
 =?utf-8?B?aEliRHY0L09helV3OGh6cGpyZWpOd1g3dXNRYWRiZjJyRWtULzFiZzlRZFFa?=
 =?utf-8?B?a0NJM1Y4d2psTWk3YnJ0TkRLNmdIRzJJQVhpZGJTcUNQeER3SlRySGtiRWlW?=
 =?utf-8?B?RzlaY2dicy90UTdoaEduMWkrTVhvUmlhcWx3RWMvWG9qZ0pKNC83eGNWNFRK?=
 =?utf-8?B?WTdiUEMwSWNlcWg5N242N1EvN3ZkSXpjQS9iQlI4UVl1Tzh4TlJvV1FKZkpi?=
 =?utf-8?B?Uk8vR1JLbWJNR3J1QXJLUS82TWVmN3M0ZFVLU2trZEhqSkxyYzk3VERpMVJX?=
 =?utf-8?B?dUtVekQ3T01TdjNjTG5xNGIrbXMrb2U5NWxrOGJEeFhvSGlhMGNmRVV5Ynla?=
 =?utf-8?B?TlMxRGNKbWpTV3B3djF0RDFzVXlGaEE2ZjdhdGtXNlVGcUw1Ymg1cElIM3BC?=
 =?utf-8?B?bU8rZFhxM3pGSkZkditqTjVZeEpnQklKVGc1c011OTVYeml5OVEvZkU4NFZR?=
 =?utf-8?B?MzhhTUVEdjdZS2FEL2ZYUm0zSlhtYkdRbTFjWkV0Yjh5d0hhZVNCS2dqbDJE?=
 =?utf-8?B?VGRNR1JyY2kxWWt6L051M0duUzRocWNibDNXMEVKT1h1M3AyQ2E3dkZ4eXdq?=
 =?utf-8?B?and2QkNYT2FYU0crSy9BRzZwNmhSK3N1aWlGT050OEFVUVhHa1paaURrS3BX?=
 =?utf-8?B?VkYwUnkrU0J3RGlEV2s4S0hFRzV5UW9IVVhkU1lza0NhK2d2bWdJQ2Uxc3pi?=
 =?utf-8?B?ZkQ5UDI2ZFFXRW1GSlk5bXU0cXg2UmUzM2xabU5PaURLd1RhNTRHdmlpWmpD?=
 =?utf-8?B?dmJKdytUUVkyMTJiVTJyYm52dk8wOGtQM3JrQjByNHFJcXQ0bVJlNXQ1cGJk?=
 =?utf-8?B?Zk1WRkhTUnJwODVXUWcyUDJCdXRwRERLVVZheHI1TmVjRlFKVUlZSE94dFM2?=
 =?utf-8?B?cWYzaE5aMEYvWituOW5jVVZEK252cUQ4MTNyOTFzV3VneWw4K2RCa3MxSkcr?=
 =?utf-8?B?QVR5ZXBrbVFENlVRK0Z5WUxCYkdBKy9TdXhMTlZOYXFpbE84ZzFGd2plS2Nz?=
 =?utf-8?B?WHJXNXpOMWt4MmdMTUZMR0FUTDZlNThVVW1OYk5BSEtxVUZ5dEJMY29YTFpr?=
 =?utf-8?B?YXhkRCtaU2RRdWk5eWVhcXlBODFWWTQrU042WTlSN05WU1JNVzY5azVBQkxN?=
 =?utf-8?B?V1JjNlVialU1REZGOVExTVV4K3pheGl5SXZUMDZuSzJNbjJabWU5MHdIY1Ar?=
 =?utf-8?B?VzNkTzJJMW9PZzQ1c3VlSG9yaFVISk10SnI1eHN5eEpycDIrVGRMMkdRMFAr?=
 =?utf-8?B?NjZQVERJM3FjWXFlN2pmOU4xbFc1bStBS0lQK3BnY2MwbkgxbjR1em1INnRk?=
 =?utf-8?B?R2hOQWFrRk5JL1lZN21ic1M3WExsQTF2U2w5b2ZiV3d4OGZPamhyRW5kWnpW?=
 =?utf-8?B?aUViUkg5cGI1UzdFbGZGRkx5dGg5dGNGNHY0Yjh4SnU0RGJqMWdROVVhQUFL?=
 =?utf-8?B?MCtiMURGOTlvWmJRbVBTVk9PVzZhOWttVGYwZGtzdE96dHk3VlY1eDRFaEpS?=
 =?utf-8?B?d0hNWDR0NnhxWE50T0x5N1ZiOUJmaDllUHFPMTVBUEl3ZFc5YmJNejVsNVBB?=
 =?utf-8?Q?qqT+ppR/bYoQUFMkjV27DUh+gIYSwL7b1X5niDn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd52f78b-2fc8-4c5e-b2b8-08d9946480a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 07:29:22.4956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: langyu12@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2491
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
U2VudDogVGh1cnNkYXksIE9jdG9iZXIgMjEsIDIwMjEgMzoyNyBQTQ0KPlRvOiBZdSwgTGFuZyA8
TGFuZy5ZdUBhbWQuY29tPjsgR3JvZHpvdnNreSwgQW5kcmV5DQo+PEFuZHJleS5Hcm9kem92c2t5
QGFtZC5jb20+DQo+Q2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IEh1YW5nLCBSYXkNCj48UmF5Lkh1YW5nQGFtZC5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCAxLzNdIGRybS9hbWRncHU6IGZpeCBhIHBvdGVudGlhbCBtZW1vcnkgbGVhayBpbg0KPmFt
ZGdwdV9kZXZpY2VfZmluaV9zdygpDQo+DQo+SXMgdGhlcmUgYW55IHJlYXNvbiB5b3UgYXJlIHNl
bmRpbmcgdGhhdCBhcm91bmQgb25seSBpbnRlcm5hbGx5IGFuZCBub3QgdG8gdGhlDQo+cHVibGlj
IG1haWxpbmcgbGlzdD8NCg0KU29ycnksIEkgbWlzc2VkIHRoYXQuIEl04oCZcyBhIG1pc3Rha2Uu
DQoNClJlZ2FyZHMsDQpMYW5nDQoNCj5DaHJpc3RpYW4uDQo+DQo+QW0gMjEuMTAuMjEgdW0gMDk6
MTcgc2NocmllYiBMYW5nIFl1Og0KPj4gYW1kZ3B1X2ZlbmNlX2RyaXZlcl9zd19maW5pKCkgc2hv
dWxkIGJlIGV4ZWN1dGVkIGJlZm9yZQ0KPj4gYW1kZ3B1X2RldmljZV9pcF9maW5pKCksIG90aGVy
d2lzZSBmZW5jZSBkcml2ZXIgcmVzb3VyY2Ugd29uJ3QgYmUNCj4+IHByb3Blcmx5IGZyZWVkIGFz
IGFkZXYtPnJpbmdzIGhhdmUgYmVlbiB0b3JlIGRvd24uDQo+Pg0KPj4gRml4ZXM6IDcyYzhjOTdi
MTUyMiAoImRybS9hbWRncHU6IFNwbGl0IGFtZGdwdV9kZXZpY2VfZmluaSBpbnRvIGVhcmx5DQo+
PiBhbmQgbGF0ZSIpDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGFuZyBZdSA8bGFuZy55dUBhbWQu
Y29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYyB8IDIgKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMNCj4+IGluZGV4IDQxY2U4NjI0NDE0NC4uNTY1NGM0NzkwNzczIDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+IEBAIC0zODQzLDgg
KzM4NDMsOCBAQCB2b2lkIGFtZGdwdV9kZXZpY2VfZmluaV9odyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZQ0KPj4gKmFkZXYpDQo+Pg0KPj4gICB2b2lkIGFtZGdwdV9kZXZpY2VfZmluaV9zdyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikNCj4+ICAgew0KPj4gLQlhbWRncHVfZGV2aWNlX2lwX2Zpbmko
YWRldik7DQo+PiAgIAlhbWRncHVfZmVuY2VfZHJpdmVyX3N3X2ZpbmkoYWRldik7DQo+PiArCWFt
ZGdwdV9kZXZpY2VfaXBfZmluaShhZGV2KTsNCj4+ICAgCXJlbGVhc2VfZmlybXdhcmUoYWRldi0+
ZmlybXdhcmUuZ3B1X2luZm9fZncpOw0KPj4gICAJYWRldi0+ZmlybXdhcmUuZ3B1X2luZm9fZncg
PSBOVUxMOw0KPj4gICAJYWRldi0+YWNjZWxfd29ya2luZyA9IGZhbHNlOw0K
