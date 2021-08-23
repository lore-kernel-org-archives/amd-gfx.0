Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C9BC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 07:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D9861184
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 07:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1D9861184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EDF889D4B;
	Mon, 23 Aug 2021 07:11:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F1889D4B
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 07:11:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTtddskK3Z4Y1vcGl4tL5w2MN7HD67FP4WoYulkS9iOA4nxsHum61GYuWOIaHvjv3rm6BwNioy2U7og6G3/5DmUOB35m8AJIft0ozorAj1q7XN7Ymlj6zmlFay2awG7az7SOyKMfBikXyfQPmPpia4GcyTcUMOg4NNV40nqEGNq1jVBLGUtzhkHM6/fu+CPlQr48l8Os0kz7ZGsR1/1CQkWd362xMpFKxg7Cotoa1W4l6Ufcd7Sfi3z/OK5+dfBettEmHNCZNwdFxf8a0iLYqODX5Stk0H0RErp/Z4WMH3HA7qJk9Zsv1xGWLN4zaug9PYv/7L3uS08xSlOd5+ryJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZAG013ZAbbIAPF5ChBXpBQkgdRIPKjpBVnwc1ZJB6Q=;
 b=hV93RM3g1NAgiOoVvLUExrCh0E7paL+PrUGbzD8wBoeyDRWeF02RmZ0zuY+4Rt6Eluv0KCIIDVsgzy+EE0ImggifSqVDwQx0kE3jwEx/hPOFFPI0aQdH6To4mqZjHa3QihzJQ/mj6m9oVKa8YkvtufSgUFkexJSSm45H6AnhIGMn0vm1mpIG2R181zHCeGBuXeLp+XOsaZBHpJKbcPaVmCo+H+ZWABHWJtwzMw68cvie7rGjMDcYnINWO837LfBoAIh5gkwQNlcT3mf0OPRXNA/jwIxaohXfug6+9Qg5aZb5kzz5p2vbvkJo+ZMTP/tjtfiw5C3QJoVCXTBUr1CJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZAG013ZAbbIAPF5ChBXpBQkgdRIPKjpBVnwc1ZJB6Q=;
 b=P8/rFJaIb5SqsLfTngVNwLnLKwhZI/qh68U/rcn4Qpz8+kKmW3s6sNTpf6+a5/V3YLrWaSs+XQKcTAiK8rUuRkG4XWZ3PCf7H5vJRBnLeNgl9lQ5BVOXFz3U6q004XesMnCGCjYF+1xT6DNwj39puGxIfGa06CP5XzP0evipZFc=
Received: from BY5PR12MB5560.namprd12.prod.outlook.com (2603:10b6:a03:1d8::15)
 by SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 07:11:11 +0000
Received: from BY5PR12MB5560.namprd12.prod.outlook.com
 ([fe80::75e1:c194:6ae9:695b]) by BY5PR12MB5560.namprd12.prod.outlook.com
 ([fe80::75e1:c194:6ae9:695b%3]) with mapi id 15.20.4415.024; Mon, 23 Aug 2021
 07:11:10 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Evans Jahja
 <evansjahja13@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: Voltage control on Southern Island GPU using radeon driver
Thread-Topic: Voltage control on Southern Island GPU using radeon driver
Thread-Index: AQHXl8IfzIEQ76V7Zk6e5k8ZXxPrXquAn9cAgAAJhOA=
Date: Mon, 23 Aug 2021 07:11:10 +0000
Message-ID: <BY5PR12MB55607F9193F1A315210D1B838EC49@BY5PR12MB5560.namprd12.prod.outlook.com>
References: <CAAq5pW_7Tv=qzTeUkTuMZMwq+FN63Qmz3pXCiwMx5R4Gbg89bA@mail.gmail.com>
 <a4db54d0-9978-035a-538e-7c51d8082037@amd.com>
In-Reply-To: <a4db54d0-9978-035a-538e-7c51d8082037@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-23T07:11:08Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d09f8b86-715f-4fcd-9c1d-d899a7a8ff74;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6eb666a8-48c3-4cbe-6939-08d966052f9e
x-ms-traffictypediagnostic: SJ0PR12MB5405:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR12MB540563D2C589A9712F5722E48EC49@SJ0PR12MB5405.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uc9ObH53bQKspSLaToSAHutCO6ba+8bvDvT+NnC63i6GZ68j0Zi1xX7x9x9eN1LYHGWzUw7aHIkCA6o8/qoy+uOFrdZFsywO7a1xDQEpchzHbge6x+SKTtWMgFRfXaDQG9h7Xuo1s9FK0wszWDpMgm3aO4OU9uuGdfC6LvnjK0ujADnJpMElPhBWENbvUtubcGVmXUSQjjgE7kpmixn3xHNfxxKTgcGaTlaTAqZJ+Rg/4yeASKT/LrWs9TxsJZ9TT4dY8IBmIafCt7Sl/bccsaJgev60DuEwgNF+rhQXkfkEPJZkcd9CicDsrTAKEl/rkkSRQe302FTzNvLQC5yI+SPPVwDpjXa16/6Iw+tpSqlAy2KOO/3iEL8oBYXRUTE+6iRBU759K0EtaOdZ4hXSpdraQHPg5ixC9WNEsIoSO1y6AQS8+y7KWWbGSmIvxHeMWSZt6k7sSF+1LM9+nGOpKeDlsAD23F9EsxWCQpj9gzrZnv5xQi2pgAqHiM+KlVkia1qUo5whnZakDewouP3v8L5QBf6LJ6NkcswTFqCtak/a0LXldQi6/bPsQpXKU6l1sIPYRun9/huw6JmiuUoiu6n/QdVyOh9k2RUk/B6Jx2j9LbZEgTG1REezng/hcjOMrcIFOwKqSkidFxd3EAvtnXu5Evv66UpIskBamcBxUNMR28o9dMl7qLxVduYJdJeUGCSk2gkt6EYKVKlnqj8sRg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(66574015)(8936002)(122000001)(83380400001)(186003)(38100700002)(53546011)(6506007)(38070700005)(8676002)(26005)(5660300002)(86362001)(52536014)(55016002)(316002)(66476007)(66446008)(110136005)(66556008)(64756008)(66946007)(71200400001)(478600001)(7696005)(9686003)(33656002)(76116006)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STlOeFcyQzFoTmtWY0I3NVVzVUxuQkxNUVBLZXpRckpueGxCZUc2WmJvNkNi?=
 =?utf-8?B?SFpUcnZsVmhBMUY1cjQ1U2Y4QUdpa09oTmFmaGhBc01hTEdJS3Y2aUNJNFJZ?=
 =?utf-8?B?eFVTNFpNSmpmSnFtdnNhWDRUQUJMaC9UNVNMdFF1Y1JCOHdVMHI4UW9Hbmhl?=
 =?utf-8?B?K2xUUDgyOTlDNWFLcG1saTRZdEQvVmtGWVlpbWdhaGwxRWFWUGFvYzYzbHh5?=
 =?utf-8?B?QmRxeEhPV0F2Yk5ReXpJekxGR0pudWUrSW1RMkROejVKaWNnVVNFRzdsMnpm?=
 =?utf-8?B?ZHpKZUFXa2oyQnAwcFJMOERMd0tSeVU0QXFqVnY2OVhEaHdwTmZzSFYwTXA4?=
 =?utf-8?B?QWxBbTlrcTM5T1JzU0hjVXNzVE82RGMrV0E4YjJpYVVqY1Jxbk1jZ2hJQ3Uv?=
 =?utf-8?B?NHRMb0JucEVGMExsRlhVUDI4bmdNVFBNRDVjNnljWXhFbTBxeUwwclR0SVd5?=
 =?utf-8?B?aUIwL1lYNnZzUGcrQ280MjJzSUxmMys4OWZ2dnAyVDl1bzJUd3FHLzR4emRP?=
 =?utf-8?B?RjNIQkZXWFdzRUZ4RkZGU1lMTk9IeHVlL1ZUYnB4MFB4U2ZYTUtrOFVDNHdy?=
 =?utf-8?B?eTBxU2dNVFJzTTJ3eEVOWS9XRGJoL1FkQnZ5dDlwbUJjbi9QeDliWkVRZFgy?=
 =?utf-8?B?eFcvK2JydDEybDdxSkdOOTFUM1RuTXFOeUlaa3d4UXQwZjZCM3YwbHVnSWVX?=
 =?utf-8?B?WlpiVll6R0dBYVc3QXNKTC9vb29CZkFWcXJQdHJURzE3eXh2bjZKL0YrRU9k?=
 =?utf-8?B?NEYva0YrVDZ0V0NpODJxMktaOExOZm9PSXJRSlBPMDdjWDdJM3JYV2pTQkY3?=
 =?utf-8?B?MEFaTHkyY1pQNW5UbER3YUVTbm4wNTZvR0dCV09BVUNRM0JHblpHd3VBaGor?=
 =?utf-8?B?dHVvVTJXMy9BQ3ppZW43c0hSYld0clUyUXRyWmVwMUwvQWJPd1kyNW5RRU1L?=
 =?utf-8?B?c0ZVa1phbGtybTJ6OGZoUzA1Y1FpOCtsRzdSZllNck8zS2dnU2hBQ0RuYUp5?=
 =?utf-8?B?eUVvbUkwTDh3Vm9SRmVBNGlYcC82ZW8ycVlScmtUWE5sRzBya3lXVFFYNU4z?=
 =?utf-8?B?YTFjeGdRNmRFRDBuZHo1b1RkeXZWVkpOa1RFbUE5N1plNE9QSjY1djQyZzFK?=
 =?utf-8?B?WDJWR3N5SGdWaE1wZTk3QXJFNTdWMnlQYUc4aHhxWnh4QTdZU2g2ZWs4MVVz?=
 =?utf-8?B?UGRZMUwzN3dGdklzMW9zaEdPbVpkM3JkY05tYVBQM3M1c29IY2FSaTRYbno0?=
 =?utf-8?B?eVhFemJCOXJsTkVlWFQ3ZC9CWUVmWjZRT0pNQnZQMUkzckE1MS92NmE2SlAy?=
 =?utf-8?B?SkRqRDB5L1p0VDUza3FhOFhKM2FIdEh5K0xpRGRlNGlIemtKakYyRXZ4VXJL?=
 =?utf-8?B?RmhCdnVXRGRVY3IydEZ4U3FoRXJ6R21GQ29IN0NDc29QVUdtdUlhRytoK1ht?=
 =?utf-8?B?aVdDRHJKeS9WeEFuVWt3SXVESy9hSUVTaGd0NTlHOG1ZRFlmemh5ZFhzeExB?=
 =?utf-8?B?c0VaNmpzOXNWK1F3TS94Um5za3JtelArN1IrenlkTDFhYXVSK2xJOUYxdEFR?=
 =?utf-8?B?bFAwZEFySFV2MU5CTDFua0pkaWdydUYxd1p0RjhPUjk1dk5FN0FLck50cVJk?=
 =?utf-8?B?MGZwcUkvL3hkU2JUK3dMSmVMNUtIY3BpS2IvcUI0blNvVG92VEtvRkZ0LzJL?=
 =?utf-8?B?TGtTOUIxUzVON3liZnd2MmZpK24yTC9scmkwM2ZtT1FqOTdGR2t3a0xPQmpX?=
 =?utf-8?Q?ViOZ+EEG9bKURq3i4XuthXQqal/SHJ5rLpVzXxq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb666a8-48c3-4cbe-6939-08d966052f9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 07:11:10.7415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ck4V/PRiWf3QAQNmuZDfSbKLetbuVulzhTTfQZ1SIlIqaj7S6xzJe+rjI8xwKcSJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgRXZhbnMNCkknbSBzb3JyeSBidXQgSSBkb24n
dCBzdWdnZXN0IHlvdSBtYW51YWxseSBjb250cm9sIHRoZSBzdGFuZGFsb25lIHZvbHRhZ2UgYmVj
YXVzZSBpdCdzIHByZWRlZmluZWQgd2l0aCB0aGUgY2xvY2sgdmFsdWUuDQpBIGRlY3JlYXNlIG9m
IHZvbHRhZ2UgY291bGQgaGl0IHRoZSBoYXJkd2FyZSBjcml0aWNhbCBwYXRoLiBZb3UgbWF5IG5l
ZWQgdG8gY2hhbmdlIHRoZSBjbG9jayBhbmQgdm9sdGFnZSB0b2dldGhlciwgd2UgY2FsbCBpdCBk
cG0gbGV2ZWwgY2hhbmdlLg0KVGhhbmtzLg0KIA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4g
T24gQmVoYWxmIE9mIENocmlzdGlhbiBLw7ZuaWcNClNlbnQ6IE1vbmRheSwgQXVndXN0IDIzLCAy
MDIxIDI6MjYgUE0NClRvOiBFdmFucyBKYWhqYSA8ZXZhbnNqYWhqYTEzQGdtYWlsLmNvbT47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogVm9sdGFnZSBjb250cm9s
IG9uIFNvdXRoZXJuIElzbGFuZCBHUFUgdXNpbmcgcmFkZW9uIGRyaXZlcg0KDQpbQ0FVVElPTjog
RXh0ZXJuYWwgRW1haWxdDQoNCkhpIEV2YW5zLA0KDQppbiBnZW5lcmFsIHRoZSB2b2x0YWdlIHRh
YmxlcyBhcmUgc3RvcmVkIGluIHRoZSBhdG9tYmlvcyBhbmQgdGhlIGJlc3QgYWR2aWNlIEkgY2Fu
IGdpdmUgeW91IGlzIHRvIGZpcnN0IGRvdWJsZSBjaGVjayBpZiB0aGVyZSBpc24ndCBhbiB1cGRh
dGVkIEJJT1MgZm9yIHlvdXIgaGFyZHdhcmUuDQoNCkJ1dCBBbGV4IGlzIHRoZSBleHBlcnQgb24g
cG93ZXIgbWFuYWdlbWVudCwgZXNwZWNpYWxseSBmb3IgdGhvc2Ugb2xkZXIgaGFyZHdhcmUgZ2Vu
ZXJhdGlvbnMuIE1heWJlIGhlIGhhcyBhbm90aGVyIGlkZWEgd2hhdCB0byB0cnkuDQoNClJlZ2Fy
ZHMsDQpDaHJpc3RpYW4uDQoNCkFtIDIzLjA4LjIxIHVtIDAzOjU2IHNjaHJpZWIgRXZhbnMgSmFo
amE6DQo+IEhpLCBJIGhhdmUgYSBIQUlOQU4gR1BVIGJlbG93Og0KPg0KPiBsc3BjaSAtbm4NCj4g
MGE6MDAuMCBEaXNwbGF5IGNvbnRyb2xsZXIgWzAzODBdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2Vz
LCBJbmMuDQo+IFtBTUQvQVRJXSBTdW4gTEUgW1JhZGVvbiBIRCA4NTUwTSAvIFI1IE0yMzBdIFsx
MDAyOjY2NmZdDQo+DQo+IEkgcnVuIGxpbnV4IDUuMTMuMTIgb24gQXJjaCBvbiBhIExlbm92byBC
NDAtNzAgbGFwdG9wLg0KPg0KPiBJJ20gdHJ5aW5nIHRvIHVuZGVyc3RhbmQgbW9yZSBvbiBob3cg
dm9sdGFnZSBjb250cm9sIHdvcmtzIGFuZCBob3cgSSANCj4gY2FuIG1vZGlmeSB0aGUgdm9sdGFn
ZSBmb3IgZG9pbmcgb3ZlcnZvbHRhZ2UgLyB1bmRlcnZvbHRhZ2Ugb24gbXkgR1BVLg0KPiBUaGUg
cmVhc29uIGlzIEkgYW0gb2JzZXJ2aW5nIGhvdyBydW5uaW5nIHByb2dyYW1zIHVuZGVyIGhpZ2gg
R1BVIGxvYWQNCj4gKGdsbWFyazIpIHdvdWxkIGxlYWQgdG8gY3Jhc2hlcyB3aGVuIEkgdXNlIGRw
bT0xIGluIGVpdGhlciByYWRlb24gb3IgDQo+IGFtZGdwdSBkcml2ZXIsIHdoaWNoIHNlZW1zIHRv
IGhhcHBlbiB3aGVuIEkgYW0gcmVhY2hpbmcgcG93ZXIgbGV2ZWwgNCANCj4gKHNjbGsgOTAwTUh6
KSwgd2hpbGUgYSBsaWdodGVyIHByb2dyYW0gbGlrZSBnbHhnZWFycyBjb3VsZCBydW4gYW5kIA0K
PiBzd2l0Y2ggcG93ZXIgbGV2ZWxzICBiZXR3ZWVuIDAsMSwyIHdpdGhvdXQgaXNzdWUgdW5kZXIg
Ym90aCBkcml2ZXJzLiBJIA0KPiBiZWxpZXZlIG15IGxhcHRvcCBtaWdodCBiZSBmYXVsdHksIGJ1
dCBJIHdvdWxkIGxpa2UgdG8gdGFrZSB0aGlzIA0KPiBvcHBvcnR1bml0eSB0byB0cnkgZml4aW5n
IGl0IGZyb20gdGhlIGRyaXZlcidzIHNpZGUgc28gdGhhdCBpdCBjYW4gcnVuIA0KPiBhbnl3YXks
IGhvd2V2ZXIgbGltaXRlZC4NCj4NCj4gUmlnaHQgbm93LCBJIGhhdmUgbWFuYWdlZCB0byBpbmNy
ZWFzZSB0aGUgcGVyZm9ybWFuY2Ugb2YgbXkgR1BVIGJ5IA0KPiBtYW51YWxseSBvdmVyd3JpdGlu
ZyB0aGUgc2NsayB0byA2MzBNSHogaW4gYWxsIHBlcmZvcm1hbmNlX2xldmVscyBpbiANCj4gcmFk
ZW9uX3BtLmMsIHdoaWNoIHN1cnByaXNlcyBtZSBhcyBvdmVycmlkaW5nIHRoZSBjbG9jayB3YXMg
bm90IA0KPiBwb3NzaWJsZSBmb3IgbWUgdG8gZG8gcHJldmlvdXNseSB2aWEgc3lzZnMuDQo+DQo+
IEkndmUgbWFuYWdlZCB0byB0d2VhayBib3RoIHNjbGsgYW5kIG1jbGsgKG9yIHNvIEkgYmVsaWV2
ZSksIGJ1dCBJIA0KPiBzdGlsbCBjYW5ub3QgdHdlYWsgdGhlIHZvbHRhZ2UgKHZkZGMpLiBUaGUg
cmVhc29uIGlzLCBpZiBJIGluY3JlYXNlIA0KPiB0aGUgc2NsayB0byA2NTBNSHosIHRoZSBsb2Nr
dXAgd2lsbCBoYXBwZW4gYWdhaW4uIENoYW5naW5nIHRoZQ0KPiBwbC0+dmRkYyAgdmFyaWFibGUg
ZG9lcyBub3Qgc2VlbSB0byBkbyBhbnl0aGluZy4gQWZ0ZXIgdmFyaW91cyB0cmFjaW5nDQo+IHdp
dGggcHJpbnRrLCBJIHVuZGVyc3RhbmQgdGhhdCBvbiBteSBzeXN0ZW06DQo+DQo+IHBpLT52b2x0
YWdlX2NvbnRyb2wgPSByYWRlb25fYXRvbV9pc192b2x0YWdlX2dwaW8ocmRldiwNCj4gU0VUX1ZP
TFRBR0VfVFlQRV9BU0lDX1ZEREMsDQo+ICAgIFZPTFRBR0VfT0JKX0dQSU9fTFVUKQ0KPg0KPiB0
aGlzIHJldHVybnMgZmFsc2UsIHdoaWxlOg0KPg0KPiBzaV9waS0+dm9sdGFnZV9jb250cm9sX3N2
aTIgPQ0KPiByYWRlb25fYXRvbV9pc192b2x0YWdlX2dwaW8ocmRldiwgU0VUX1ZPTFRBR0VfVFlQ
RV9BU0lDX1ZEREMsDQo+ICAgIFZPTFRBR0VfT0JKX1NWSUQyKTsNCj4NCj4gVGhpcyByZXR1cm5z
IHRydWUsIHNvIEkgYmVsaWV2ZSBteSBzeXN0ZW0gaXMgdXNpbmcgU1ZJMiBzb21laG93IHRvIHNl
dCANCj4gdGhlIHZvbHRhZ2UuIEhhdmluZyBubyBleHBlcmllbmNlIHdpdGggU1ZJMiwgSSByZWFk
IG9ubGluZSBhbmQgZm91bmQgDQo+IG91dCB0aGF0IFNWSTIgaXMgYSB2b2x0YWdlIHJlZ3VsYXRv
ciB0aGF0IHVzZXMgRGF0YSAvIENsb2NrIHBpbnMgdG8gDQo+IGNsb2NrLWluIDggYml0cyBvZiBp
bmZvcm1hdGlvbiBhbmQgY29udmVydCBpdCB0byBzb21lIHZvbHRhZ2UgdmFsdWUgDQo+IGJldHdl
ZW4gT0ZGLCAwLjVWIC0+IDEuNVYsIG9mZmVyaW5nIGZpbmUgY29udHJvbCBiYXNlZCBvbiBzb21l
IGxvb2sgdXAgDQo+IHRhYmxlLg0KPg0KPiBNeSBxdWVzdGlvbnMgYXJlIGFzIGZvbGxvd3M6DQo+
IElzIGl0IHBvc3NpYmxlIGZvciBtZSB0byBtb2RpZnkgbXkgc3lzdGVtIHNvIHRoYXQgSSBjYW4g
bWFudWFsbHkgDQo+IGFkanVzdCB0aGUgdm9sdGFnZSB0byBteSBHUFU/DQo+DQo+IFRoYW5rIHlv
dSB2ZXJ5IG11Y2ggaW4gYWR2YW5jZS4gVGhpcyBpcyB0aGUgZmlyc3QgdGltZSBJIGRlYWwgd2l0
aCANCj4ga2VybmVsIGRyaXZlcnMsIHNvIGFueSBndWlkYW5jZSBvbiB0aGUgbWF0dGVyIGhlbHBz
IGEgbG90Lg0KPg0KPiAtIEV2YW5zDQo+DQo+DQo=
