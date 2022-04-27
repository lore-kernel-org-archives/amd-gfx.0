Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6CCC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 04:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5949210F813;
	Wed, 27 Apr 2022 04:14:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD2F410F80F
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 04:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTVPSAtgi8Th6p5bY0muUVDMR/gLscStSZxBhKSvdRWQTqN4MGxNqflJ4VrlM+TeZVwc/AdxpjrQnYHGVtberXybCtIdv5wITdfMX7/DSstjErFvSZQfgeNRlsb+3XXkotzAJofUlSXXrXfwtwuDj6RcBsv4A0B9wasWWmoCCyGKZ+p641uEfZsGFkCgKMu3Ehj11gpw0Ezd4z36rQtGewthRHN5TX2RZN5X4Vr625kLbkjSAFMG5yM3FP9aLATR/La8NMFqxVxGChQNtUgpxx8xzC5y5YHI24fbKI+EnoZOx0BeTNRrHkaG7CrxXzzNXTD7tzdox3hwtBjMS7rfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQFOJiOmYJ1GRPJzdczL7Trwhyi0ogDjGMqQSng41Sk=;
 b=c/Ndak58/xLRoEP8TNaZk6siclFBfdsnyPj4a42L8Vv11gZZtuPQzSvICsEC+GW9sE+5H7j/qkdvHC4Tv6Su8ZwSYYLwWd3oQQeSBHIDBU5qsjJu4jrT/77fCFgGnJ2yux1VOrZci2AkgstDcpMC9G0JV19ohpce/iKYfbLvw8OoBNrnHLegGQaWEeV9sBDi7x3P7Koq/eSsA89UNmncZKzmjFidNVui5UDmE38qJ3IQ3bM5IRkgrQoqOXzxmHkKC0kyin1F8HyDRn2FZ1Ko13jogFMKZwFCWVNAGZhVJ14WoscPPZ7dmLkEs+SXSGmURrmAx6LE925uxMnz5w1v8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQFOJiOmYJ1GRPJzdczL7Trwhyi0ogDjGMqQSng41Sk=;
 b=dZJK6V2uGR+LdaBHsob8NhPnrarCqw2xC1dyU1sB4uiDMhlYjtxH2I69+4jb4SbZweLxxwMx/xMjo1FfsskdX7LDATual3WPvvszB+H7LZBFQatHMaKAfJAvLPfxTJy1xu/SmPKNo2atEODQ1JWPnHjKb5FQEvZCCC0Y0gw+XZ4=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BN9PR12MB5354.namprd12.prod.outlook.com (2603:10b6:408:103::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 04:14:21 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::bc5b:45a3:477e:258d]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::bc5b:45a3:477e:258d%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 04:14:20 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled during
 s2idle suspend
Thread-Topic: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled during
 s2idle suspend
Thread-Index: AQHYWHGNCSvmg4Vj8EOz/S+SlVusl60CDd8AgAEZb8A=
Date: Wed, 27 Apr 2022 04:14:20 +0000
Message-ID: <BYAPR12MB3238D716386D4F0E246F2189FBFA9@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1650869553-28976-1-git-send-email-Prike.Liang@amd.com>
 <1603bd63-71f0-87a6-0d18-339bf43568c4@amd.com>
In-Reply-To: <1603bd63-71f0-87a6-0d18-339bf43568c4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=365112e7-a480-4f1b-82f6-aae54c7c4ea4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-27T04:06:09Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a1b3732-d14b-4693-a988-08da28046772
x-ms-traffictypediagnostic: BN9PR12MB5354:EE_
x-microsoft-antispam-prvs: <BN9PR12MB5354FF99E02179C24337764FFBFA9@BN9PR12MB5354.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MPURFtdQ3Ht6CX9UIHiDRqzfKM154PWdCakJkD4R4TMLJc5iP5khXdCn/M9Mny3byUPYvUt70GkUTrW40P+IFaqRFORyHM/bTGzxg8YG8kbs2SWkztXmuOVbDpppc0EGj5xlRMk0JRC1aUTPIZqzNXoJwse6zwFgHsROrPH0sXFwVntBO+3jMHb81TWLSKhFrDuULun2gnTHN0dQqBhkat8ymEA77YRjUgr1J2iOjgdQ6tGY9MWh279eAd7wUrtBTbluN+3Ht1UchxR4LOW1IZDcAVz8X+vrNTRpIdBB2igdR06D9PnejYkpy72DYJsJCu0MIx7zpk8I2qbpxJ8YgXwK4AmBgdrytPGgDChEAmUEmKUj0NqaDnE0j6PcZ3Xs2ocjHJC+WVfW3QYrGTwZP0zitmhLMLlK43LMHCaVSJhhH48L/FVbODLQxP+KHknwPnOaEhiK+n8cBiARHybI5JEZt+x2suDXcu8z7aLHI/P5aXi3aEqe30swZYE4C0h2256+u4RjCuy+Rp7Vfacu6uIGTUfhVBjbddiK0BxuhawKeKEq4XO5NSWMH21JiOfqE+TVehyfmi5F8JxVEkP1jdObpyUVFqSELkNrPxXbIYYiafbGUGDyWqFjp7la4cT95S6Xb25Oxyw77pywavXd9Xf0FF4fBjCH5/EQq9mxCpHDNmmW956CQkij46bUXGBfQeVrVQ8wOCFOurGXCiLCmQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(83380400001)(38100700002)(38070700005)(186003)(6506007)(53546011)(508600001)(86362001)(122000001)(52536014)(5660300002)(8936002)(55016003)(15650500001)(33656002)(2906002)(7696005)(26005)(66446008)(66476007)(4326008)(54906003)(64756008)(9686003)(66946007)(8676002)(76116006)(66556008)(316002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGNMcDdlZThrY3N3RDBwaVFUMzRWRTJaUkdxTzFPWnp5MnU2YzF5Wks2RXVk?=
 =?utf-8?B?L1NkUnhsWEFQWkMrOVRZRC91bHhZK2JiekU3M2JYUm9mVENLZnF5WDBBZzNh?=
 =?utf-8?B?ck1GYUFjMTFQb2dWQ3loTE41cGhVT3NEMEdienFWS0trenZMWkdYN0FoTHA5?=
 =?utf-8?B?cjJhcTR6b3BQbTltTWZPS2NaOFc0Z1ZDZVRYbUpERlRONDNqWmhoK1JJUkpv?=
 =?utf-8?B?Y0lNMFUrTHRtZzV0YXRTNGtXdFBkYWl4eWFPQVFiM2ZIMWZ2NFlXQWpTRlRE?=
 =?utf-8?B?ZXpydVdSbFExV283cUVwREtwUnFkNjlPOEs4NGVhVUJzZEpTNm5LeWI1TXho?=
 =?utf-8?B?WkJsdDZTc0VrV0MyVnhBN244bEJLUTZkVzNTRGltL1RXQmM4dWxzV3hyeUNq?=
 =?utf-8?B?a1dBWUtmRFZmc05jMWZ5cmhuNHlNang1NnJrWTkrSHlNcnY5eHlPNTVwZzlq?=
 =?utf-8?B?dUdORWFsZVp5YzlxN2IyZW9idThzdG5xR0djWHJxL1JCM1pQUXIzOE9wdFI5?=
 =?utf-8?B?WCs2YnVobkFwb0xrVUxwQW12SEo5Y05VNWpxVGpVVWMrNTBoajRESHJZaXJo?=
 =?utf-8?B?elRpS1U2MlNjMXZDUnAyR0ZNWm9WOVJIbnJUVmRQK09SVURyQVAyOWV0UWND?=
 =?utf-8?B?cUdkTlFFSXJzYUt1K3R0a29yQmxNcXluZ1laSEwvbmUvVTBoN1RuOW02UmRP?=
 =?utf-8?B?Z2psMWVUVDh1SDJoS3MyVUhrYy9JSytaU2oxT01tdy9aS091UldPNnlwbGNv?=
 =?utf-8?B?YlJkSTZoQXdZWG9mZUFUeS9qQVpLVnRWYkkyM1RSeWFxb0Y3NEs2bVJJN0I1?=
 =?utf-8?B?Q1htSTBYSjBXS3lsbnQ5blJlMnhOS0k3cjFETkMrSGNuRHdQYXo1YUEwR2ta?=
 =?utf-8?B?VVNMdmlJT2FyeitWenJ1cFNSQy9rbGlEdi9POVE0a1RMdm93K2Q3OGcrWU40?=
 =?utf-8?B?M0hkbGtJVjIzeWFTcXJuTmx5TjFKeGhwTmlQM3E3WDE3ZFQzOE9oOC96L1hW?=
 =?utf-8?B?V3plcUt3ZlE0L1dSdXZFK3RNczZ4ZXd1b2xQTHVPVWpac1BBazdWZUs5U3U2?=
 =?utf-8?B?OThJY0lZdWV0cnkycG1nK3ZyZU5OaGwvUXBpQlpVVG9ZMzVrM3JrUTQ5alpm?=
 =?utf-8?B?OWlxNUd3ejlkS2dKMHhSMkczYTZzaWxKZlNZSEhkbHFBajBjbHRDQkRCbVBz?=
 =?utf-8?B?dVh5ak9mQXg2OC9SNkFjTENHb3BlVFRzckNDbDRUN2lyUjhWdHhIamdSQXZx?=
 =?utf-8?B?cWwxb1NnaFpzaVlRNk96NDhDYk9rYVpyUWJzSGRFbkd4WUY4Rm5Mb3hmZGVB?=
 =?utf-8?B?UnA3TysrMlJJdno2VTlKeUQ3b0FmaWFQbVlRL1l5am96VFhNdDExVDYrQmth?=
 =?utf-8?B?NURRdU55d21lUXVGWVZyR3hPTngyTUVWYlFVU05FRWQxVVhra3R6cUszbHpR?=
 =?utf-8?B?OFE4ZEg5SXdZYU9rNWxaTG1PdkNJRDArYjF2S09HUmZrcFpCVGJxdlBLSHNP?=
 =?utf-8?B?U2ZIVWJWTWRvWTBNMzZ0bmRORmcyNWNFZEwvQWRYbEE2b0R3eC92MDIxRHh6?=
 =?utf-8?B?dzNFeGxVeFZ6L1ZZNVZpYjNPNHArN3NBem8rQ3Zxb3RaKzRmZGlDSGdlR0NO?=
 =?utf-8?B?TlM2MnBZMmxBbzRsMzRMSityeHlaVmh5VkVVWU01bWhlSW10N3h3WUFZYzBI?=
 =?utf-8?B?QWFtYnlqTUNoeW12d3h0OXcyNmJjdnBZaTBadmU1azdyZTdOS2tiOGJWMVRZ?=
 =?utf-8?B?MXM2bzI0SjY3QkhFRVpVeXh2ZnRmRUd3K2pmZnVXSjExeU1relhtNjRSQjY3?=
 =?utf-8?B?RThNZnJRU0dFZmpER2p2bGU3RVJLYm41OVFLK1UxVEZYdkNSR0QzU1VmeUVK?=
 =?utf-8?B?YitEMHIyR2h0Q0RoNi9UVTYzTXBiOHluQ08vWVhDU0llSml4MVZWQ3RVejNB?=
 =?utf-8?B?OVpxNUFFZnR6MHh3RkM3ZyszYkhUaFlnMDVWeXlUL1MzVjQ0bEhGNnFneTJv?=
 =?utf-8?B?dkFXRGJOSDU0blpxZHZXN1kzZ2VIU3BXd0gxVzRsMEJJRnRTcVZRdUhoL2w3?=
 =?utf-8?B?bVNsRzJ4WmROeWFnbFBhcHcxUFJuTlpKUEM4R01GVEhTOE5ORG5kZDlienFN?=
 =?utf-8?B?d0xsclM0dEFmMWpwRWxIdXJUbEgrZlJSVDNLdG8rbkpZV0w3bzRWVnp6SllM?=
 =?utf-8?B?VG13cFlsQStuT1lSQ0I5eWttT0dHRnFibG5OWGc2dmhCeVBOYUJUMkVhelBs?=
 =?utf-8?B?anNKM0U2M0NxSlZzZFQ3cWcwTlR2QjNieFA4S0R4RUJxR1BpcU5xeXJ2NDNY?=
 =?utf-8?Q?DjcNwPWiQVvRKhy8s/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1b3732-d14b-4693-a988-08da28046772
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 04:14:20.6269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFQl7+J+KzsRP0Mip/7IbtX1+qC+LPoySZvxW3otmblAotoMCdLbxr33myHUkEYX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5354
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAyNiwgMjAy
MiA3OjE5IFBNDQo+IFRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIFJheQ0KPiA8UmF5Lkh1YW5nQGFtZC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGtlZXAgbW1odWIgY2xvY2sgZ2F0
aW5nIGJlaW5nIGVuYWJsZWQNCj4gZHVyaW5nIHMyaWRsZSBzdXNwZW5kDQo+DQo+DQo+DQo+IE9u
IDQvMjUvMjAyMiAxMjoyMiBQTSwgUHJpa2UgTGlhbmcgd3JvdGU6DQo+ID4gV2l0aG91dCBNTUhV
QiBjbG9jayBnYXRpbmcgYmVpbmcgZW5hYmxlZCB0aGVuIE1NSFVCIHdpbGwgbm90DQo+ID4gZGlz
Y29ubmVjdCBmcm9tIERGIGFuZCB3aWxsIHJlc3VsdCBpbiBERiBDLXN0YXRlIGVudHJ5IGNhbid0
IGJlDQo+ID4gYWNjZXNzZWQgZHVyaW5nIFMyaWRsZSBzdXNwZW5kLCBhbmQgZXZlbnR1YWxseSBz
MGl4IGVudHJ5IHdpbGwgYmUgYmxvY2tlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtl
IExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgfCAxMCArKysrKysrKysrDQo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjEwXzAuYw0KPiA+IGluZGV4IGE0NTVlNTlmNDFmNC4uMjA5NDZiYzdmYzkz
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5j
DQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMNCj4gPiBA
QCAtMTE1MSw2ICsxMTUxLDE2IEBAIHN0YXRpYyBpbnQgZ21jX3YxMF8wX3NldF9jbG9ja2dhdGlu
Z19zdGF0ZSh2b2lkDQo+ICpoYW5kbGUsDQo+ID4gICAgIGludCByOw0KPiA+ICAgICBzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsNCj4g
Pg0KPiA+ICsgICAvKg0KPiA+ICsgICAgKiBUaGUgaXNzdWUgbW1odWIgY2FuJ3QgZGlzY29ubmVj
dCBmcm9tIERGIHdpdGggTU1IVUIgY2xvY2sNCj4gZ2F0aW5nIGJlaW5nIGRpc2FibGVkDQo+ID4g
KyAgICAqIGlzIGEgbmV3IHByb2JsZW0gb2JzZXJ2ZWQgYXQgREYgMy4wLjMsIGhvd2V2ZXIgd2l0
aCB0aGUgc2FtZQ0KPiBzdXNwZW5kIHNlcXVlbmNlIG5vdA0KPiA+ICsgICAgKiBzZWVuIGFueSBp
c3N1ZSBvbiB0aGUgREYgMy4wLjIgc2VyaWVzIHBsYXRmb3JtLg0KPiA+ICsgICAgKi8NCj4gPiAr
ICAgaWYgKGFkZXYtPmluX3MwaXggJiYgYWRldi0+aXBfdmVyc2lvbnNbREZfSFdJUF1bMF0gPiBJ
UF9WRVJTSU9OKDMsDQo+IDAsIDIpKSB7DQo+ID4gKyAgICAgICAgICAgZGV2X2RiZyhhZGV2LT5k
ZXYsICJrZWVwIG1taHViIGNsb2NrIGdhdGluZyBiZWluZw0KPiBlbmFibGVkIGZvciBzMGl4XG4i
KTsNCj4gPiArICAgICAgICAgICByZXR1cm4gMDsNCj4gPiArICAgfQ0KPiA+ICsNCj4NCj4gVGhp
cyBvbmx5IGlnbm9yZXMgY2xvY2sgZ2F0aW5nIHJlcXVlc3RzIGFzIGxvbmcgYXMgczBpeCBmbGFn
IGlzIHNldC4gQXMgZmFyIGFzIEkNCj4gc2VlLCBzMGl4IGZsYWcgaXMgc2V0IHRvIHRydWUgZXZl
biBkdXJpbmcgcmVzdW1lIGFuZCBzZXQgdG8gZmFsc2Ugb25seSBhZnRlcg0KPiByZXN1bWUgaXMg
Y29tcGxldGVkLiBJcyB0aGF0IGludGVudGlvbiBhbmQgaXMgdGhpcyB0ZXN0ZWQgdG8gYmUgd29y
a2luZyBmaW5lPyBJDQo+IHN1Z2dlc3QgdG8ga2VlcCB0aGlzIHNwZWNpZmljYWxseSBmb3Igc3Vz
cGVuZCBjYWxscy4NCj4NCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQpJdCByZWFzb25hYmxlIGZvciBh
bHNvIG5vdCByZWVuYWJsZSB0aGUgY2xvY2sgZ2F0aW5nIG9uIHRoZSBzMmlsZGUgcmVzdW1lIHNp
bmNlIGNsb2NrIGdhdGluZw0Kbm90IGRpc2FibGVkIG9uIHRoZSBzMmlkbGUgc3VzcGVuZC4gSGF2
ZSBtZXJnZWQgdGhlIGZpeCBmb3Igbm90IGJsb2NraW5nIHMwaXggc3VwcG9ydCBmb3Igc29tZQ0K
dXBjb21pbmcgYXNpYyBhbmQgbWVhbndoaWxlIHN0aWxsIG5lZWQgZGlnIGludG8gd2hldGhlciB0
aGUgREYgQy1zdGF0ZSwgTU1IVUIgRFMgb3IgQklPUyBtbWh1YiBwb3dlciBnYXRlIHJlcXVlc3Qg
ZGlmZmVyZW50IG9uIEdDIDEwLjMuNyBpbnRyb2R1Y2UgdGhpcyBpc3N1ZSBhbmQgdGhlbiBtYWtl
IGEgZ2VuZXJpYyBzb2x1dGlvbiBmb3Igc3VjaCB0aGlzIGlzc3VlLg0KDQo+ID4gICAgIHIgPSBh
ZGV2LT5tbWh1Yi5mdW5jcy0+c2V0X2Nsb2NrZ2F0aW5nKGFkZXYsIHN0YXRlKTsNCj4gPiAgICAg
aWYgKHIpDQo+ID4gICAgICAgICAgICAgcmV0dXJuIHI7DQo+ID4NCg==
