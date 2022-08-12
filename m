Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B48C00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 21:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C8A492C0A;
	Fri, 12 Aug 2022 21:40:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E16592B1B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 21:40:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeKfcJDJN7KWhbXl/7w+wgjASFpplJmgPdgnmUojg5HkLIJRqRbcNJD7yKFQjqAqDKbcJAl+lNTc8vkCbC1Fmo8ma/jZTx0j/e7Ab7bx2V5oAF8dOpJ+70cyg6nKDllxmWTOGUSmZmkp5XUrl6HZT501/GLrq0I5LNlSIkxftEfF2MSoZHQTx6PVvxQmnL885pIhPgoxgYvS45Vv85qzDWVxOl9c5Y5SZRZ6oCZm+H7y4nq7XJq3g9N3pnFIyJFjxJXyga91v9VuJkFCukCgIqeORyWlpis2iqh19dnkJdasErU/NvBaG/JivOM8RTkmFYuHyk1bo/9L6wttlye/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egsAHUBbh3Usbhdt+qyUCl1M93UCbj8c4+ECwooH7m0=;
 b=KBz3mstx15puoPFXmire9spOvlSrF2jKSwJ6GQoGQb2cocaMsBX/KzflikZkpVk/8sPbI1M5N6x2JTlFPVhcZdQyrabg9DMt1iV7b67aXX+UQM4SqDBuHzlCnPYNp205A4fh6mmNxkdHcGxfuEoPelXnsOIk2Ak/+gG4A6wmjHZCUnnnFEuA787pm8bDk4AueQ1btA8zKutiSaTHdOBUOjtN7P+qDRFHBlQnMCTE3HRGqzXGFSslWJ9lBVMTu5oK+EKJUo15HJEX5nRBVP8Qln3qI9bllan79uspSahkpIkG3YwGhuvorNjFmiYhO0/8sw09rzPGooZ7I0WLPrja4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egsAHUBbh3Usbhdt+qyUCl1M93UCbj8c4+ECwooH7m0=;
 b=ZmaiNgIcrAQitrTyMxgR6gOumI7URnWqLaWOFh5Hz1NDkleV5pqAiOrAluX6T6C7+LMo6jqBH7bZx+Xig7x9/uLmFyF2JSt7Nkm7jPEkwnWTPVCTVr+YFKXi7GhdtVJSa1yaJuuUlq7k8z2P2SNM1CjY/HFbAY7ZrqWzAjK357o=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by CY4PR12MB1943.namprd12.prod.outlook.com (2603:10b6:903:11b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 12 Aug
 2022 21:40:13 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::98a9:195a:29f5:dcc9]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::98a9:195a:29f5:dcc9%6]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 21:40:13 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix interrupt handling on ih_soft ring
Thread-Topic: [PATCH] drm/amdgpu: Fix interrupt handling on ih_soft ring
Thread-Index: AQHYro4Fyk3W1b+WN0qB8liFL9sV2q2rx38AgAADdnA=
Date: Fri, 12 Aug 2022 21:40:13 +0000
Message-ID: <BL3PR12MB642581D38FE6F14DEF2C8F46EE679@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20220812205624.2902630-1-mukul.joshi@amd.com>
 <ea5dbe2b-12d0-7c21-e22a-25446b38027a@amd.com>
In-Reply-To: <ea5dbe2b-12d0-7c21-e22a-25446b38027a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-12T21:40:11Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f3572bc2-f970-43af-b29f-90ffe88d8777;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e71a2282-4be8-4fa7-75d5-08da7cab3d27
x-ms-traffictypediagnostic: CY4PR12MB1943:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PL59VEBsBfWtMhqXK8/8XS83yVplCvItv2yWMn+yrSBpC9T1nbeaYt8XhwYWVZkMhWnNAwWNCfxpYYUN5Fa+SBgP3WNt9QqWR6fHB96a2vVnxeF5ppbKwksawP6c2MR6U5+pzEZpuY7Qqu6prDHLc5GaaKzrYQKKaJ4eOHCzYHpLkKFuWGV1UFYzQxs3rgqrhSi5T5mXaXRSMmdn9JiHuuaFWooapEsQrGrEqgzAY7wjoGkwP3jQuJXmjR0qOaTGX6e03fBOZQJN3N4ot1qNCembTh5buC9nStHztBQrLAlCEMgrIoSE0hKD7ptByoce96qTA/E80uGFiHCJE+TuOMvaYmJmhLOZ5709xUjxkD1gv30WPWSOdDEFtzFoZmSQabLAaxeZeG7D7/NNs/ulWnzf+VZgEkFumHrbDkeEalZ/0B4TjU0bJqGqr/CubcZFqE6m+zVj2T0SvXcjVkicWuw6wHBMfltFJUU83vwG2pHqdypdvJuVJJZJHqmwYP+GpTJREEJxCLl9A9byVh6rwfed/DMRzNrRfiYA3E+Uvn6UO4ztVXinhPT4sJmgtqShsVJlMcrpm9rE1UUM0Z++Xg5xSc9sQXBh9IbzX550/ebDo3csfGp1p5ocuCc7qQPOIIfXZYWfpPsH1v6sEWc3UpzrrC2U8hP0tWFU3ZcRxHk3vgnjiYvLRfOrhmmeiOp8oVzLzqfdpvelZg4ADp8BnRjYzzzrGSj9rhCNYRhoA4JuIKquEL8ocs4FXNBD1Wv/8whkz9DN8bt35P/m7hxkBEtPHPmKb7HtrKLNGRjt7kC+2gAwVuB/BwbWaTcp0KZY0kM9WRpy8RQ1tGcN3PsUPw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(33656002)(86362001)(83380400001)(38100700002)(122000001)(64756008)(38070700005)(66446008)(66556008)(66476007)(76116006)(66946007)(8676002)(316002)(110136005)(52536014)(5660300002)(8936002)(478600001)(71200400001)(26005)(9686003)(6506007)(7696005)(53546011)(55016003)(2906002)(186003)(41300700001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFgzUWhMY3htUVVNOXpaalp6WnV4aklHNGdiRldjQUJZeXNDYXZQc0RFTW5P?=
 =?utf-8?B?OFJMMnl6QjcxMEtnRjNqcnZtNkdPcTBqTzJOUEJSZTFlbW5XVUVGMnRjZ3Jl?=
 =?utf-8?B?MFd5Y3pEZW42OVZRZFY2VDk5dDduWWIvYURBRTVXaFI3a3ZRd0ttZ2NpUEVj?=
 =?utf-8?B?RVNvVUl6MVdNUW5ySlhpcnAwY0tBVk9tU1dOT09oSk5jbUlid0pNNlVJYnZv?=
 =?utf-8?B?dnQ1TzdhOURXanhnRndLTXhKTUNLdmo3bUxZcmV2dEsvK200M3dmTzEyV3RM?=
 =?utf-8?B?cS9nZTZqZmRKV1NjVjJTVHF0QzlWWXVuUk9RSjJXOUZjcWdxeGJjYTNqa1Ro?=
 =?utf-8?B?V3hqd0NlY1NvNGxBc1doUWZNam1RZWREVDV0WVJTWVlrZmRNYVVCNDYvOFNi?=
 =?utf-8?B?MTdEaEo1cGxmNzU3VTBiRjlGRktKWXdtaStkRTI0dmwydk1SRW1JVWFHU3dk?=
 =?utf-8?B?L1pWZHp5ZEtNTzduaWdjQ3MvSlVzT3p3OTdnYjdadTZZeWpGSE5vVGhieVVW?=
 =?utf-8?B?Y0FoLzFyVEMxaWNCbkJIc0c4RE9nSkxEbFprS2cxNmlLSDRDY3Ztd0Q1UzBw?=
 =?utf-8?B?OTNTY2RVNmxqTTlBdEtaWXdyVU1GT1E3bDRMald1SkNIbkN4aE1QYmx6TjZn?=
 =?utf-8?B?UHZTS2RrWkRMSVg3UVVDNGx5OE0zWkNoQ2lPcGN0blNoMDNNbmRkUTZ3eGd2?=
 =?utf-8?B?MzNsbFFUNllrS1dpNlFaRk9VQVQzSUJubEJBR3dyTmwyc3Y3YnV1VUNJR3dv?=
 =?utf-8?B?Vk41bDRycmwrQm1NdXZ3aDNiYm5adFQzdVloNEFjZ24wbmJTcmJYeUtHd0lI?=
 =?utf-8?B?aGhKZFhETkZla3MwUmJ5cjhQVk5WUjhySjF4Y1pJeVBVUUNQeTdJVE8zY25T?=
 =?utf-8?B?azBBZHkyK053elVIWUdiUk1VR3lWd2dQSldwVHdFSzJSczJxSWZ0RWlsWHZi?=
 =?utf-8?B?YW5pbkpPTTRZY2tFVFhCYnMvcklZQ0pBZmo2OS9nUHZibXVKSjFtdkJKSVQ5?=
 =?utf-8?B?akhwYnhTZE9HcGdTQXBBTkdQMGlxN0I1d0FHb0tsOU05aVIvY1ZJUXVBWXhI?=
 =?utf-8?B?VFBkVU5Ocy9HOEFWT0dPRlBUTnlnZzJ1RW92dTNjVzZmODBrcy9MYVBteUpI?=
 =?utf-8?B?MVV3aUpnSWxyYjJURGR2UXBQQzFHUlBjcmd6VEVOYWkrRVJEbkJUbmVuUlVp?=
 =?utf-8?B?ODFDUVJyOHMwNjBoTjE2M2RHbUV3V2JJamZXM0xhaG44YkwrUXlrQzl5ajFV?=
 =?utf-8?B?MTF5blV5akpFVkl6RWFjek5hNUFSbU1ocTM2QnhJOW1MOVlkV1FNblROWkVY?=
 =?utf-8?B?YlJ1eC9GL1BaMzJZOENZVG9BZmlPKzJQZi9Da2hCWE5VNzR1T3VXZC9KWnlr?=
 =?utf-8?B?NW5TT0FpZndpTXRucm9yRTVOZWN4KzBHbTMyV0hjcUN0TGVkc0VHTkxlTXZQ?=
 =?utf-8?B?U2dneHhVeFRSeHZONjNSOFdOK0htbHlCWUZUQnFVV1lpa2ZidVVmaG94QXQ0?=
 =?utf-8?B?cE5MVjlCcy9KYWExK0hTd2wyWmQwTXdhYWZxMmFxczBxR0tCc2NBNVVBVWx4?=
 =?utf-8?B?QXNFU01hT0MweHFzVW9LeFJnaDFTZTZia1Y0ZmhEN0ROaEZZeEtReFYwNWJ0?=
 =?utf-8?B?R0R4WGhDNGtoRk0yejJCV1JkM29TZDJ2L0ZiNklPT0J1SUZ4eWN3cXpLL3pa?=
 =?utf-8?B?aEdnVUxqY0trSnNYUkdCSU5aZDJFd0VURlpoM1lyenZhdmQ3UmVMZDBPbko5?=
 =?utf-8?B?MHgvR2xEempYUU96aUhDeHY2N1NwMStNSkxNcVJhemR5YitpT2loelpJb3Vn?=
 =?utf-8?B?Uzh3VU8vallhQ3VrdlVzTGJVeExKL1lMcEFFQVpOVkJjZUZTci91czByV3pR?=
 =?utf-8?B?eVZpL0pUQzZPS1d0WXFUWHFaQ3BoY1hwZk5CQlQyRWkyUGZmbUg1SVBqYVlM?=
 =?utf-8?B?czBMZGh5dlcxRVhXYXVTSmF2NWZLanJZRnhDeGxmMVZCOWE0cHJFMGU4dWQ2?=
 =?utf-8?B?eDJaMTVEbzFFdSt4NS9FSnUzYVh4WEVZT1EwM0xINEFkSjRhRzZGMEk4OEtQ?=
 =?utf-8?B?Z1BGYlhXSDFvREcxSFp3Mk5RanBpUjYrSTJDL0VuSDh2bzBzVTJYWWhsSGRi?=
 =?utf-8?Q?9mas=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71a2282-4be8-4fa7-75d5-08da7cab3d27
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 21:40:13.3282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sy3uc/3PITIwg3Qf8DFk4NI2xUYsIM+MhDxmcRlQJfrj4Vwe5VhKj1hWyYdhzUMgzvyd5A+1Hh6uxB+dtNq1/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1943
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMTIsIDIwMjIgNToyNyBQTQ0KPiBUbzogSm9z
aGksIE11a3VsIDxNdWt1bC5Kb3NoaUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4IGludGVycnVwdCBo
YW5kbGluZyBvbiBpaF9zb2Z0IHJpbmcNCj4gDQo+IA0KPiBPbiAyMDIyLTA4LTEyIDE2OjU2LCBN
dWt1bCBKb3NoaSB3cm90ZToNCj4gPiBUaGVyZSBhcmUgbm8gYmFja2luZyBoYXJkd2FyZSByZWdp
c3RlcnMgZm9yIGloX3NvZnQgcmluZy4NCj4gPiBBcyBhIHJlc3VsdCwgZG9uJ3QgdHJ5IHRvIGFj
Y2VzcyBoYXJkd2FyZSByZWdpc3RlcnMgZm9yIHJlYWQgYW5kIHdyaXRlDQo+ID4gcG9pbnRlcnMg
d2hlbiBwcm9jZXNzaW5nIGludGVycnVwdHMgb24gdGhlIElIIHNvZnQgcmluZy4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IE11a3VsIEpvc2hpIDxtdWt1bC5qb3NoaUBhbWQuY29tPg0KPiANCj4g
VGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuIEJ1dCB5b3UgcHJvYmFibHkgc2hvdWxkIGFwcGx5
IHRoZSBzYW1lDQo+IGNoYW5nZXMgdG8gdmVnYTEwX2loLmMgYW5kIG5hdmkxMF9paC5jIGFzIHdl
bGwuDQo+DQoNCk9vcHMgc29ycnkgSSBtaXNzZWQgdGhhdC4gV2lsbCB1cGRhdGUgdGhlIHBhdGNo
IGFuZCByZS1zZW5kLg0KDQpSZWdhcmRzLA0KTXVrdWwNCiANCj4gUmVnYXJkcywNCj4gIMKgIEZl
bGl4DQo+IA0KPiANCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zl
Z2EyMF9paC5jIHwgNyArKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmVnYTIwX2loLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3ZlZ2EyMF9paC5jDQo+ID4gaW5kZXggM2I0ZWI4Mjg1OTQzLi4yMDIyZmZiYjhkYmEgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMjBfaWguYw0KPiA+IEBAIC0zODUs
OSArMzg1LDExIEBAIHN0YXRpYyB1MzIgdmVnYTIwX2loX2dldF93cHRyKHN0cnVjdA0KPiBhbWRn
cHVfZGV2aWNlICphZGV2LA0KPiA+ICAgCXUzMiB3cHRyLCB0bXA7DQo+ID4gICAJc3RydWN0IGFt
ZGdwdV9paF9yZWdzICppaF9yZWdzOw0KPiA+DQo+ID4gLQlpZiAoaWggPT0gJmFkZXYtPmlycS5p
aCkgew0KPiA+ICsJaWYgKGloID09ICZhZGV2LT5pcnEuaWggfHwgaWggPT0gJmFkZXYtPmlycS5p
aF9zb2Z0KSB7DQo+ID4gICAJCS8qIE9ubHkgcmluZzAgc3VwcG9ydHMgd3JpdGViYWNrLiBPbiBv
dGhlciByaW5ncyBmYWxsIGJhY2sNCj4gPiAgIAkJICogdG8gcmVnaXN0ZXItYmFzZWQgY29kZSB3
aXRoIG92ZXJmbG93IGNoZWNraW5nIGJlbG93Lg0KPiA+ICsJCSAqIGloX3NvZnQgcmluZyBkb2Vz
bid0IGhhdmUgYW55IGJhY2tpbmcgaGFyZHdhcmUgcmVnaXN0ZXJzLA0KPiA+ICsJCSAqIHVwZGF0
ZSB3cHRyIGFuZCByZXR1cm4uDQo+ID4gICAJCSAqLw0KPiA+ICAgCQl3cHRyID0gbGUzMl90b19j
cHUoKmloLT53cHRyX2NwdSk7DQo+ID4NCj4gPiBAQCAtNDYxLDYgKzQ2Myw5IEBAIHN0YXRpYyB2
b2lkIHZlZ2EyMF9paF9zZXRfcnB0cihzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4g
PiAgIHsNCj4gPiAgIAlzdHJ1Y3QgYW1kZ3B1X2loX3JlZ3MgKmloX3JlZ3M7DQo+ID4NCj4gPiAr
CWlmIChpaCA9PSAmYWRldi0+aXJxLmloX3NvZnQpDQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsNCj4g
PiAgIAlpZiAoaWgtPnVzZV9kb29yYmVsbCkgew0KPiA+ICAgCQkvKiBYWFggY2hlY2sgaWYgc3dh
cHBpbmcgaXMgbmVjZXNzYXJ5IG9uIEJFICovDQo+ID4gICAJCSppaC0+cnB0cl9jcHUgPSBpaC0+
cnB0cjsNCg==
